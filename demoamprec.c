#include<ms311.h>
#include<ms311sphlib.h>
#include "spidata.h"

// timer is independent from the lib
#define TMR_RLD (256-32)

// system state 
#define SYS_PLAY 1
//#define SYS_REC 2
#define SYS_AMP 2
#define SYS_AMP_REC 3
#define SYS_IDLE 0

// For EMI consideration
#define ULAWC_DEFAULT 0x18

// here we define the key related operation
#define KEYS_NOKEY 0
#define KEYS_DEB 1
#define KEYS_WAITRELEASE 2

#define KEY_CODE_PLAY 1
#define KEY_CODE_REC 2
#define KEY_CODE_AMP 3

#define KEY_WAIT 5

#define IO_REC 0x01
#define IO_PLAY 0x02
#define IO_AMP 0x4
#define IO_KEY_ALL 0x7
// add a cap for power-on detect
#define IO_CAP 0x08
#define LED_IO_REC 0x40

// typical beep value
//#define NORMAL_BEEP 0x14
//#define BEEP_TIME1 50
#define BEEP_TIME2 32
#define REC_WAIT_TIME 7


BYTE key_state;
BYTE sys_state;
BYTE last_stroke;
BYTE key_code;
BYTE key_timer;
BYTE beep_timer;
BYTE rec_stage; // stage for recording

// wait a while to enter sleep
BYTE sleep_timer;

BYTE oldindex[4];
USHORT oldpredict[4];
USHORT oldpwr[4];
BYTE rindex;

USHORT newpwr;
USHORT pwravg;
USHORT the_pred;
BYTE the_index;
USHORT new_end_page;
adpcm_state the_state;
BYTE playing_seg;


// KEY is defined by get_key
BYTE get_key(void)
{
	if(!(IO&IO_PLAY))
		return KEY_CODE_PLAY;
	if(!(IO&IO_AMP))
		return KEY_CODE_AMP;
	if(!(IO&IO_REC))
		return KEY_CODE_REC;
	return 0;
}

void init(void)
{
	// add init job here
	IODIR=0xc0;
	IO=0xFF; // all high
	IOWK=0; // deep sleep mode no use wk
	sleep_timer=KEY_WAIT;
	new_end_page=R3_ENDPAGE;
	
	api_timer_on(TMR_RLD);
}

void key_machine(void)
{
	BYTE k;	// following is key machine
	k=get_key();
	switch(key_state)
	{
		case KEYS_NOKEY:
			if(!key_code && k)
			{
				last_stroke=k;
				key_state=KEYS_DEB;
				key_timer=KEY_WAIT;
			}
			break;
		case KEYS_DEB:
			if(k!=last_stroke)
			{
				key_state=KEYS_NOKEY;
				break;
			}
			if(!--key_timer)
			{
				key_code=last_stroke;
				key_state=KEYS_WAITRELEASE;
			}
			break;
		case KEYS_WAITRELEASE:
			if(!k)
				key_state=KEYS_NOKEY;
			break;
			
	};
}

void timer_routine(void)
{
	if(!TOV)
		return ;
	TOV=0;
	if(sleep_timer)
		sleep_timer--;
	if(beep_timer)
		beep_timer--;
	// add timer jobs here
	key_machine();

}

BYTE enter_play_mode(BYTE seg)
{
	BYTE try_play=0;
	api_set_vol(API_PAGV_DEFAULT,API_PLAYG_DEFAULT);
	switch(seg)
	{
		case 0:
			try_play=API_PSTARTH(P0);
			break;
		case 1:					
			try_play=API_PSTARTH(P1);
			break;
		case 2:
			try_play= API_PSTARTH(R3);
			//try_play=api_play_start_with_state(R3_STARTPAGE, new_end_page, 0x17f, R3_ULAW, API_DAOSR_HIGH, &the_state);
			break;
	}
	if(try_play)
		sys_state=SYS_PLAY;
	playing_seg=seg;
	return try_play; // return the result
}
void wait_beep(BYTE count)
{
	beep_timer=count;
	while(beep_timer)
	{
		timer_routine();
		if(key_state)
			api_enter_stdby_mode(0 ,0,0); // use tmr wk
		else
			api_enter_stdby_mode(IO_KEY_ALL,0,0); //use tmr+io wk

	}
}

BYTE callbackchk(void)
{
	// when start recording,
	// it checks if need abort here
	// we use only DMA wake up
	if(!key_state)
		api_enter_stdby_mode(IO_KEY_ALL,0,1);
	else
		api_enter_stdby_mode(0,0,0);
	if(!TOV)
		key_machine();
	timer_routine();
	if(key_code)
		return 1;
	return 0;
}

void enter_rec_mode(void)
{

	key_code=0;
	//if(sys_state!=SYS_AMP || sys_state!=SYS_AMP_REC)
		//return;
	
	//api_beep_start(NORMAL_BEEP);
	//wait_beep(BEEP_TIME1);
	//api_beep_stop();
	//if(key_code)
		//return; // return will set 0
	// after beep, we check if key released
	if(sys_state==SYS_AMP)
	{
		api_amp_rec_start(R3_STARTPAGE, R3_ENDPAGE);
		IO&=LED_IO_REC;
		sys_state=SYS_AMP_REC;
	}
	else if(sys_state==SYS_AMP_REC)
	{
		IO|=LED_IO_REC;
		api_amp_rec_stop(1);
		sys_state=SYS_AMP;
	}else
		return;
	rec_stage=0;
	rindex=0;
	
		
}
void enter_idle_mode(void)
{
	if(sys_state==SYS_AMP_REC)
	{
		api_amp_rec_stop(1);
	}
	if(sys_state==SYS_AMP)
		api_amp_stop();
	api_play_stop();

	sys_state=SYS_IDLE;
	sleep_timer=KEY_WAIT;
	IO=0xff;
}

void sys_play(void)
{
	if(!api_play_job())
	{
		api_play_stop();

		if(playing_seg!=2)
			enter_play_mode(2);
		else
			enter_idle_mode();
	}
	else
	{
		if(key_state==KEYS_NOKEY)
		{// if no key press, timer off
		  // use IO,DMA to wake up						
			api_enter_stdby_mode(IO_KEY_ALL, 0, 1);
		}else
		{ // otherwise use timer wake up
			api_enter_stdby_mode(0,0,0);
		}
	}

}


// if there is speech, return 1
BYTE simple_speech_check(void) // if 4 frame power no change (lot)
{
	// compare to last avg power
	BYTE i;
	USHORT j;
	for(i=0;i<4;i++)
	{
		j=oldpwr[i];
		if((j-(j>>3))>pwravg) // here must use > not >=, incase 0
			return 1;
	}
	return 0;
}
/*
BYTE sys_rec(void)
{
	BYTE i;
	
	if(key_code)
	{
		enter_idle_mode();
		return 2; // key stop
	}
	if(rec_stage<4) // stage=0 means noise calibration
					// we take 4 frames 
	{
		if(api_rec_job_no_write(&the_state, &oldpwr[rindex])!=0)
		{
			oldindex[rindex]=the_state.index;
			oldpredict[rindex]=the_state.predict;
			rec_stage++;
			rindex++;
			rindex&=3;
		}
		goto halt_rec;
	}
	if(rec_stage==4) // compare
	{
		if(api_rec_job_no_write(&the_state, &newpwr)!=0)		
		{
			oldindex[rindex]=the_state.index;
			oldpredict[rindex]=the_state.predict;
			pwravg = (oldpwr[0]>>2)+(oldpwr[1]>>2)+(oldpwr[2]>>2)+(oldpwr[3]>>2);
			oldpwr[rindex]=newpwr;

			
			rindex++;
			rindex&=3;
			if(newpwr>=((pwravg<<1)+20))
			{
				BYTE k;
				api_rec_write_prev(1); // 1 means previous 1 frame installed
				k=rindex-2;
				k=k&3;
				the_state.index=oldindex[k]; // the state for playing
				the_state.predict=oldpredict[k];
				rec_stage++;
				pwravg+=5; //  a shift
			}
		}
		goto halt_rec;
	}

	i= api_rec_job_do_write(&newpwr,&new_end_page);
	if(i==1)
		goto halt_rec;
	
	oldpwr[rindex]=newpwr;
	rindex++;
	rindex&=3;

	if(rec_stage<9)
		rec_stage++;
	else if( i==0 || (i==2 && rec_stage==9 && simple_speech_check()==0))
	{
		if(i==2)
			new_end_page--; // sub1 is generally OK
		api_rec_stop(0);
		sys_state=SYS_IDLE;
		return 0; // 0 means finish;
	}

halt_rec:	
	if(!key_state)
		api_enter_stdby_mode(IO_KEY_ALL,0,1);
	else
		api_enter_stdby_mode(0,0,0);
	if(!TOV)
		key_machine();
	return 1;

}
*/


#define TAG (*((BYTE*)0x8100))

void enter_amp_mode(void)
{
	api_set_vol(API_PAGV_DEFAULT,API_PLAYG_DEFAULT);
	api_amp_prepare(0x3f, 0x80, 0x60, API_EN5K_ON, 0,6,callbackchk) ; // analog mode
	sys_state=SYS_AMP;
	rec_stage=0;
	beep_timer=50;
}

void sys_amp(void)
{
	if(rec_stage==0 && !beep_timer)
	{
		rec_stage=1;
		api_amp_start();
	}
	if(sys_state==SYS_AMP_REC)
	{
		if(!api_amp_rec_job())
		{
			api_amp_rec_stop(0);
			sys_state=SYS_AMP; // back to amp mode
		}
	}
	if(key_state || beep_timer)
		api_enter_stdby_mode(0 ,0,0); // use tmr wk
	else
		api_enter_stdby_mode(IO_KEY_ALL,0,1); //use IO wk
	
}

main()
{
	API_USE_ERC;
	ULAWC=ULAWC_DEFAULT;
	OFFSETL=2;
	init();
	if(!(init_io_state&IO_CAP) )
	{
		//enter_play_mode(0);
		API_SPI_ERASE((USHORT)R2_STARTPAGE); // first time we erase!!
	}
	IODIR=0xf0;
	while(1)
	{
		timer_routine();
		IO^=0x80;
		if(key_code)
		{
			if(sys_state!=SYS_IDLE && key_code!=KEY_CODE_REC)
				enter_idle_mode();
			else
			switch(key_code)
			{
				case KEY_CODE_REC:
					enter_rec_mode();
					break;
				case KEY_CODE_PLAY:
				
					API_SPI_READ_PAGE((USHORT)R2_STARTPAGE, 1);// read prev data to 0x100
					if(TAG==0xff)
					{
						TAG=0;
						API_SPI_WRITE_PAGE((USHORT)R2_STARTPAGE,1); // write it
						enter_play_mode(0);
					}else
					{
						enter_play_mode(1);
					}
					
					break;
				case KEY_CODE_AMP:
					enter_amp_mode();
					break;
			}
			key_code=0;
		}
		/*
		if(sys_state==SYS_REC)
		{
			if(!sys_rec())
			{
				enter_play_mode(2);
			}
		}
		else */  if(sys_state==SYS_AMP|| sys_state==SYS_AMP_REC)
		{
			sys_amp();
		}
		else if(sys_state==SYS_PLAY)
			sys_play();
		else if(!sleep_timer && key_state==KEYS_NOKEY)
			api_enter_dsleep_mode();
			//api_normal_sleep(IO_KEY_ALL,0,1); // LVRDIS=1
		else
		{
			if(key_state)
				api_enter_stdby_mode(0 ,0,0); // use tmr wk
			else
				api_enter_stdby_mode(IO_KEY_ALL,0,0); //use tmr+io wk
			if(!TOV)
				key_machine(); // wake up by IO, we get keycode first
		}
	}
}
