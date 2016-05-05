pcode dump


	New pBlock

internal pblock, dbName =M
;; Starting pCode block
_main:	;Function start
; 0 exit points
;	.line	398; "demo212.c"	ULAWC=ULAWC_DEFAULT;
	LDA	#0x18
	STA	_ULAWC
;	.line	399; "demo212.c"	init();
	CALL	_init
;	.line	400; "demo212.c"	if(!(init_io_state&IO_CAP) )
	LDA	#0x08
	AND	_init_io_state
	JNZ	_00387_DS_
;	.line	403; "demo212.c"	API_SPI_ERASE((USHORT)R2_STARTPAGE); // first time we erase!!
	CLRA	
	STA	_SPIH
	LDA	#0x80
	STA	_SPIM
	CLRA	
	STA	_SPIL
	LDA	#0x01
	STA	_SPIOP
	LDA	#0x02
	STA	_SPIOP
_00387_DS_:
;	.line	405; "demo212.c"	IODIR=0xf0;
	LDA	#0xf0
	STA	_IODIR
_00421_DS_:
;	.line	408; "demo212.c"	timer_routine();
	CALL	_timer_routine
;	.line	409; "demo212.c"	IO^=0x80;
	LDA	#0x80
	XOR	_IO
	STA	_IO
;	.line	410; "demo212.c"	if(key_code)
	LDA	_key_code
	JZ	_00399_DS_
;	.line	412; "demo212.c"	if(sys_state!=SYS_IDLE)
	LDA	_sys_state
	JZ	_00396_DS_
;	.line	413; "demo212.c"	enter_idle_mode();
	CALL	_enter_idle_mode
	JMP	_00397_DS_
_00396_DS_:
;	.line	415; "demo212.c"	switch(key_code)
	LDA	_key_code
	JZ	_00397_DS_
	SETB	_C
	LDA	#0x03
	SUBB	_key_code
	JNC	_00397_DS_
	LDA	_key_code
	DECA	
	CALL	_00470_DS_
_00470_DS_:
	SHL	
	ADD	#_00471_DS_
	STA	_STACKL
	CLRA	
	ADDC	#>(_00471_DS_)
	STA	_STACKH
	RET	
_00471_DS_:
	JMP	_00389_DS_
	JMP	_00388_DS_
	JMP	_00393_DS_
_00388_DS_:
;	.line	418; "demo212.c"	enter_rec_mode();
	CALL	_enter_rec_mode
;	.line	419; "demo212.c"	break;
	JMP	_00397_DS_
_00389_DS_:
;	.line	422; "demo212.c"	API_SPI_READ_PAGE((USHORT)R2_STARTPAGE, 1);// read prev data to 0x100
	CLRA	
	STA	_SPIH
	LDA	#0x80
	STA	_SPIM
	CLRA	
	STA	_SPIL
	LDA	#0x48
	STA	_SPIOP
;	.line	423; "demo212.c"	if(TAG==0xff)
	CLRA	
	STA	_ROMPL
	LDA	#0x81
	STA	_ROMPH
	LDA	@_ROMPINC
	XOR	#0xff
	JNZ	_00391_DS_
;	.line	425; "demo212.c"	TAG=0;
	LDA	#0x81
	STA	_ROMPH
	CLRA	
	STA	_ROMPL
	STA	@_ROMPINC
;	.line	426; "demo212.c"	API_SPI_WRITE_PAGE((USHORT)R2_STARTPAGE,1); // write it
	CLRA	
	STA	_SPIH
	LDA	#0x80
	STA	_SPIM
	CLRA	
	STA	_SPIL
	LDA	#0x01
	STA	_SPIOP
	LDA	#0x44
	STA	_SPIOP
;	.line	427; "demo212.c"	enter_play_mode(0);
	CLRA	
	PUSH	
	CALL	_enter_play_mode
	JMP	_00397_DS_
_00391_DS_:
;	.line	430; "demo212.c"	enter_play_mode(1);
	LDA	#0x01
	PUSH	
	CALL	_enter_play_mode
;	.line	433; "demo212.c"	break;
	JMP	_00397_DS_
_00393_DS_:
;	.line	435; "demo212.c"	enter_amp_mode();
	CALL	_enter_amp_mode
_00397_DS_:
;	.line	438; "demo212.c"	key_code=0;
	CLRA	
	STA	_key_code
_00399_DS_:
;	.line	441; "demo212.c"	if(sys_state==SYS_REC)
	LDA	_sys_state
	XOR	#0x02
	JNZ	_00418_DS_
;	.line	443; "demo212.c"	if(!sys_rec())
	CALL	_sys_rec
	JNZ	_00421_DS_
;	.line	445; "demo212.c"	enter_play_mode(2);
	LDA	#0x02
	PUSH	
	CALL	_enter_play_mode
	JMP	_00421_DS_
_00418_DS_:
;	.line	448; "demo212.c"	else if(sys_state==SYS_AMP)
	LDA	_sys_state
	XOR	#0x03
	JNZ	_00415_DS_
;	.line	450; "demo212.c"	sys_amp();
	CALL	_sys_amp
	JMP	_00421_DS_
_00415_DS_:
;	.line	452; "demo212.c"	else if(sys_state==SYS_PLAY)
	LDA	_sys_state
	XOR	#0x01
	JNZ	_00412_DS_
;	.line	453; "demo212.c"	sys_play();
	CALL	_sys_play
	JMP	_00421_DS_
_00412_DS_:
;	.line	454; "demo212.c"	else if(!sleep_timer && key_state==KEYS_NOKEY)
	LDA	_sleep_timer
	JNZ	_00408_DS_
	LDA	_key_state
	JNZ	_00408_DS_
;	.line	455; "demo212.c"	api_enter_dsleep_mode();
	CALL	_api_enter_dsleep_mode
	JMP	_00421_DS_
_00408_DS_:
;	.line	459; "demo212.c"	if(key_state)
	LDA	_key_state
	JZ	_00403_DS_
;	.line	460; "demo212.c"	api_enter_stdby_mode(0 ,0,0); // use tmr wk
	CLRA	
	PUSH	
	PUSH	
	PUSH	
	CALL	_api_enter_stdby_mode
	JMP	_00404_DS_
_00403_DS_:
;	.line	462; "demo212.c"	api_enter_stdby_mode(IO_KEY_ALL,0,0); //use tmr+io wk
	CLRA	
	PUSH	
	PUSH	
	LDA	#0x07
	PUSH	
	CALL	_api_enter_stdby_mode
_00404_DS_:
;	.line	463; "demo212.c"	if(!TOV)
	LDC	_TOV
	JC	_00421_DS_
;	.line	464; "demo212.c"	key_machine(); // wake up by IO, we get keycode first
	CALL	_key_machine
	JMP	_00421_DS_

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_sys_amp:	;Function start
; 0 exit points
;	.line	384; "demo212.c"	if(rec_stage==0 && !beep_timer)
	LDA	_rec_stage
	JNZ	_00376_DS_
	LDA	_beep_timer
	JNZ	_00376_DS_
;	.line	386; "demo212.c"	rec_stage=1;
	LDA	#0x01
	STA	_rec_stage
;	.line	387; "demo212.c"	api_amp_start();
	CALL	_api_amp_start
_00376_DS_:
;	.line	389; "demo212.c"	if(key_state)
	LDA	_key_state
	JZ	_00379_DS_
;	.line	390; "demo212.c"	api_enter_stdby_mode(0 ,0,0); // use tmr wk
	CLRA	
	PUSH	
	PUSH	
	PUSH	
	JMP	_api_enter_stdby_mode
_00379_DS_:
;	.line	392; "demo212.c"	api_enter_stdby_mode(IO_KEY_ALL,0,0); //use IO wk
	CLRA	
	PUSH	
	PUSH	
	LDA	#0x07
	PUSH	
	JMP	_api_enter_stdby_mode

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_enter_amp_mode:	;Function start
; 0 exit points
;	.line	377; "demo212.c"	api_amp_prepare(0x3f, 0x80, 0x0, API_EN5K_ON, 1) ; // analog mode
	LDA	#0x01
	PUSH	
	LDA	#0x10
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x80
	PUSH	
	LDA	#0x3f
	PUSH	
	CALL	_api_amp_prepare
;	.line	378; "demo212.c"	sys_state=SYS_AMP;
	LDA	#0x03
	STA	_sys_state
;	.line	379; "demo212.c"	rec_stage=0;
	CLRA	
	STA	_rec_stage
;	.line	380; "demo212.c"	beep_timer=200;
	LDA	#0xc8
	STA	_beep_timer
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_sys_rec:	;Function start
; 2 exit points
;	.line	291; "demo212.c"	BYTE sys_rec(void)
	LDA	_RAMP1L
	PUSH	
	P02P1	
	LDA	#0x06
	CALL	__sp_inc
;	.line	295; "demo212.c"	if(key_code)
	LDA	_key_code
	JZ	_00275_DS_
;	.line	297; "demo212.c"	enter_idle_mode();
	CALL	_enter_idle_mode
;	.line	298; "demo212.c"	return 2; // key stop
	LDA	#0x02
	JMP	_00304_DS_
_00275_DS_:
;	.line	300; "demo212.c"	if(rec_stage<4) // stage=0 means noise calibration
	LDA	_rec_stage
	ADD	#0xfc
	JC	_00279_DS_
;	.line	303; "demo212.c"	if(api_rec_job_no_write(&the_state, &oldpwr[rindex])!=0)
	LDA	_rindex
	SHL	
	STA	@P1,3
	CLRA	
	ROL	
	STA	@P1,1
	LDA	#(_oldpwr + 0)
	ADD	@P1,3
	STA	@P1,2
	LDA	#> (_oldpwr + 0)
	ADDC	@P1,1
	STA	@P1,1
	LDA	@P1,2
	PUSH	
	LDA	@P1,1
	PUSH	
	LDA	#(_the_state + 0)
	PUSH	
	LDA	#> (_the_state + 0)
	PUSH	
	CALL	_api_rec_job_no_write
	JNZ	_00001_DS_
	JMP	_00298_DS_
_00001_DS_:
;	.line	305; "demo212.c"	oldindex[rindex]=the_state.index;
	LDA	_rindex
	ADD	#(_oldindex + 0)
	STA	@_RAMP1
	CLRA	
	ADDC	#> (_oldindex + 0)
	STA	@P1,4
	LDA	(_the_state + 2)
	STA	@P1,2
	LDA	@P1,4
	STA	_ROMPH
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	@P1,2
	STA	@_ROMPINC
;	.line	306; "demo212.c"	oldpredict[rindex]=the_state.predict;
	LDA	_rindex
	STA	@_RAMP1
	CLRA	
	STA	@P1,4
	LDA	@_RAMP1
	SHL	
	STA	@P1,2
	LDA	@P1,4
	ROL	
	STA	@P1,5
	LDA	#(_oldpredict + 0)
	ADD	@P1,2
	STA	@_RAMP1
	LDA	#> (_oldpredict + 0)
	ADDC	@P1,5
	STA	@P1,4
	LDA	_the_state
	STA	@P1,2
	LDA	(_the_state + 1)
	STA	@P1,5
	LDA	@P1,4
	STA	_ROMPH
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	@P1,2
	STA	@_ROMPINC
	LDA	@P1,5
	STA	@_ROMPINC
;	.line	307; "demo212.c"	rec_stage++;
	LDA	_rec_stage
	INCA	
	STA	_rec_stage
;	.line	308; "demo212.c"	rindex++;
	LDA	_rindex
	INCA	
;	.line	309; "demo212.c"	rindex&=3;
	STA	_rindex
	AND	#0x03
	STA	_rindex
;	.line	311; "demo212.c"	goto halt_rec;
	JMP	_00298_DS_
_00279_DS_:
;	.line	313; "demo212.c"	if(rec_stage==4) // compare
	LDA	_rec_stage
	XOR	#0x04
	JZ	_00002_DS_
	JMP	_00285_DS_
_00002_DS_:
;	.line	315; "demo212.c"	if(api_rec_job_no_write(&the_state, &newpwr)!=0)		
	LDA	#(_newpwr + 0)
	PUSH	
	LDA	#> (_newpwr + 0)
	PUSH	
	LDA	#(_the_state + 0)
	PUSH	
	LDA	#> (_the_state + 0)
	PUSH	
	CALL	_api_rec_job_no_write
	JNZ	_00003_DS_
	JMP	_00298_DS_
_00003_DS_:
;	.line	317; "demo212.c"	oldindex[rindex]=the_state.index;
	LDA	_rindex
	ADD	#(_oldindex + 0)
	STA	@_RAMP1
	CLRA	
	ADDC	#> (_oldindex + 0)
	STA	@P1,4
	LDA	(_the_state + 2)
	STA	@P1,2
	LDA	@P1,4
	STA	_ROMPH
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	@P1,2
	STA	@_ROMPINC
;	.line	318; "demo212.c"	oldpredict[rindex]=the_state.predict;
	LDA	_rindex
	STA	@_RAMP1
	CLRA	
	STA	@P1,4
	LDA	@_RAMP1
	SHL	
	STA	@P1,2
	LDA	@P1,4
	ROL	
	STA	@P1,5
	LDA	#(_oldpredict + 0)
	ADD	@P1,2
	STA	@_RAMP1
	LDA	#> (_oldpredict + 0)
	ADDC	@P1,5
	STA	@P1,4
	LDA	_the_state
	STA	@P1,2
	LDA	(_the_state + 1)
	STA	@P1,5
	LDA	@P1,4
	STA	_ROMPH
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	@P1,2
	STA	@_ROMPINC
	LDA	@P1,5
	STA	@_ROMPINC
;	.line	319; "demo212.c"	pwravg = (oldpwr[0]>>2)+(oldpwr[1]>>2)+(oldpwr[2]>>2)+(oldpwr[3]>>2);
	LDA	_oldpwr
	STA	@_RAMP1
	LDA	(_oldpwr + 1)
	SHR	
	STA	@P1,5
	LDA	@_RAMP1
	ROR	
	STA	@P1,2
	LDA	@P1,5
	SHR	
	STA	@P1,5
	LDA	@P1,2
	ROR	
	STA	@P1,2
	LDA	(_oldpwr + 2)
	STA	@_RAMP1
	LDA	(_oldpwr + 3)
	SHR	
	STA	@P1,1
	LDA	@_RAMP1
	ROR	
	STA	@P1,3
	LDA	@P1,1
	SHR	
	STA	@P1,1
	LDA	@P1,3
	ROR	
	ADD	@P1,2
	STA	@P1,2
	LDA	@P1,5
	ADDC	@P1,1
	STA	@P1,5
	LDA	(_oldpwr + 4)
	STA	@_RAMP1
	LDA	(_oldpwr + 5)
	SHR	
	STA	@P1,1
	LDA	@_RAMP1
	ROR	
	STA	@P1,3
	LDA	@P1,1
	SHR	
	STA	@P1,1
	LDA	@P1,3
	ROR	
	ADD	@P1,2
	STA	@P1,2
	LDA	@P1,5
	ADDC	@P1,1
	STA	@P1,5
	LDA	(_oldpwr + 6)
	STA	@_RAMP1
	LDA	(_oldpwr + 7)
	SHR	
	STA	@P1,1
	LDA	@_RAMP1
	ROR	
	STA	@P1,3
	LDA	@P1,1
	SHR	
	STA	@P1,1
	LDA	@P1,3
	ROR	
	ADD	@P1,2
	STA	_pwravg
	LDA	@P1,5
	ADDC	@P1,1
	STA	(_pwravg + 1)
;	.line	320; "demo212.c"	oldpwr[rindex]=newpwr;
	LDA	_rindex
	STA	@_RAMP1
	CLRA	
	STA	@P1,4
	LDA	@_RAMP1
	SHL	
	STA	@P1,2
	LDA	@P1,4
	ROL	
	STA	@P1,5
	LDA	#(_oldpwr + 0)
	ADD	@P1,2
	STA	@_RAMP1
	LDA	#> (_oldpwr + 0)
	ADDC	@P1,5
	STA	_ROMPH
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	_newpwr
	STA	@_ROMPINC
	LDA	(_newpwr + 1)
	STA	@_ROMPINC
;	.line	321; "demo212.c"	the_index = (rindex-1)&3;
	LDA	_rindex
	DECA	
	AND	#0x03
;	.line	322; "demo212.c"	the_pred=oldpredict[the_index];			
	STA	_the_index
	STA	@_RAMP1
	CLRA	
	STA	@P1,4
	LDA	@_RAMP1
	SHL	
	STA	@P1,2
	LDA	@P1,4
	ROL	
	STA	@P1,5
	LDA	#(_oldpredict + 0)
	ADD	@P1,2
	STA	@_RAMP1
	LDA	#> (_oldpredict + 0)
	ADDC	@P1,5
	STA	@P1,4
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	@P1,4
	STA	_ROMPH
	LDA	@_ROMPINC
	STA	_the_pred
	LDA	@_ROMPINC
	STA	(_the_pred + 1)
;	.line	323; "demo212.c"	the_index=oldpwr[the_index];
	LDA	#(_oldpwr + 0)
	ADD	@P1,2
	STA	@P1,2
	LDA	#> (_oldpwr + 0)
	ADDC	@P1,5
	STA	@P1,5
	LDA	@P1,2
	STA	_ROMPL
	LDA	@P1,5
	STA	_ROMPH
	LDA	@_ROMPINC
	STA	@_RAMP1
	LDA	@_ROMPINC
	LDA	@_RAMP1
	STA	_the_index
;	.line	326; "demo212.c"	rindex++;
	LDA	_rindex
	INCA	
;	.line	327; "demo212.c"	rindex&=3;
	STA	_rindex
	AND	#0x03
	STA	_rindex
;	.line	328; "demo212.c"	if(newpwr>=((pwravg<<1)+20))
	LDA	_pwravg
	SHL	
	STA	@_RAMP1
	LDA	(_pwravg + 1)
	ROL	
	STA	@P1,4
	LDA	#0x14
	ADD	@_RAMP1
	STA	@_RAMP1
	CLRA	
	ADDC	@P1,4
	STA	@P1,4
	SETB	_C
	LDA	_newpwr
	SUBB	@P1,0
	LDA	(_newpwr + 1)
	SUBB	@P1,4
	JNC	_00298_DS_
;	.line	331; "demo212.c"	api_rec_write_prev(1); // 1 means previous 1 frame installed
	LDA	#0x01
	PUSH	
	CALL	_api_rec_write_prev
;	.line	332; "demo212.c"	k=rindex-2;
	LDA	#0xfe
	ADD	_rindex
	AND	#0x03
;	.line	334; "demo212.c"	the_state.index=oldindex[k]; // the state for playing
	STA	@_RAMP1
	ADD	#(_oldindex + 0)
	STA	@P1,4
	CLRA	
	ADDC	#> (_oldindex + 0)
	STA	@P1,2
	LDA	@P1,4
	STA	_ROMPL
	LDA	@P1,2
	STA	_ROMPH
	LDA	@_ROMPINC
	STA	(_the_state + 2)
;	.line	335; "demo212.c"	the_state.predict=oldpredict[k];
	LDA	@_RAMP1
	STA	@P1,4
	CLRA	
	STA	@P1,2
	LDA	@P1,4
	SHL	
	STA	@_RAMP1
	LDA	@P1,2
	ROL	
	STA	@P1,5
	LDA	#(_oldpredict + 0)
	ADD	@_RAMP1
	STA	@P1,4
	LDA	#> (_oldpredict + 0)
	ADDC	@P1,5
	STA	@P1,2
	LDA	@P1,4
	STA	_ROMPL
	LDA	@P1,2
	STA	_ROMPH
	LDA	@_ROMPINC
	STA	@_RAMP1
	LDA	@_ROMPINC
	STA	@P1,5
	LDA	@_RAMP1
	STA	_the_state
	LDA	@P1,5
	STA	(_the_state + 1)
;	.line	336; "demo212.c"	rec_stage++;
	LDA	_rec_stage
	INCA	
	STA	_rec_stage
;	.line	337; "demo212.c"	pwravg+=5; //  a shift
	LDA	#0x05
	ADD	_pwravg
	STA	_pwravg
	CLRA	
	ADDC	(_pwravg + 1)
	STA	(_pwravg + 1)
;	.line	340; "demo212.c"	goto halt_rec;
	JMP	_00298_DS_
_00285_DS_:
;	.line	343; "demo212.c"	i= api_rec_job_do_write(&newpwr,&new_end_page);
	LDA	#(_new_end_page + 0)
	PUSH	
	LDA	#> (_new_end_page + 0)
	PUSH	
	LDA	#(_newpwr + 0)
	PUSH	
	LDA	#> (_newpwr + 0)
	PUSH	
	CALL	_api_rec_job_do_write
;	.line	344; "demo212.c"	if(i==1)
	STA	@_RAMP1
	XOR	#0x01
;	.line	347; "demo212.c"	oldpwr[rindex]=newpwr;
	JZ	_00298_DS_
	LDA	_rindex
	SHL	
	STA	@P1,5
	CLRA	
	ROL	
	STA	@P1,3
	LDA	#(_oldpwr + 0)
	ADD	@P1,5
	STA	@P1,4
	LDA	#> (_oldpwr + 0)
	ADDC	@P1,3
	STA	_ROMPH
	LDA	@P1,4
	STA	_ROMPL
	LDA	_newpwr
	STA	@_ROMPINC
	LDA	(_newpwr + 1)
	STA	@_ROMPINC
;	.line	348; "demo212.c"	rindex++;
	LDA	_rindex
	INCA	
;	.line	349; "demo212.c"	rindex&=3;
	STA	_rindex
	AND	#0x03
	STA	_rindex
;	.line	351; "demo212.c"	if(rec_stage<9)
	LDA	_rec_stage
	ADD	#0xf7
	JC	_00296_DS_
;	.line	352; "demo212.c"	rec_stage++;
	LDA	_rec_stage
	INCA	
	STA	_rec_stage
	JMP	_00298_DS_
_00296_DS_:
;	.line	353; "demo212.c"	else if( i==0 || (i==2 && rec_stage==9 && simple_speech_check()==0))
	LDA	@_RAMP1
	JZ	_00290_DS_
	LDA	@_RAMP1
	XOR	#0x02
	JNZ	_00298_DS_
	LDA	_rec_stage
	XOR	#0x09
	JNZ	_00298_DS_
	CALL	_simple_speech_check
	JNZ	_00298_DS_
_00290_DS_:
;	.line	355; "demo212.c"	if(i==2)
	LDA	@_RAMP1
	XOR	#0x02
	JNZ	_00289_DS_
;	.line	356; "demo212.c"	new_end_page--; // sub1 is generally OK
	LDA	_new_end_page
	DECA	
	STA	_new_end_page
	LDA	#0xff
	ADDC	(_new_end_page + 1)
	STA	(_new_end_page + 1)
_00289_DS_:
;	.line	357; "demo212.c"	api_rec_stop(0);
	CLRA	
	PUSH	
	CALL	_api_rec_stop
;	.line	358; "demo212.c"	sys_state=SYS_IDLE;
	CLRA	
;	.line	359; "demo212.c"	return 0; // 0 means finish;
	STA	_sys_state
	JMP	_00304_DS_
_00298_DS_:
;	.line	363; "demo212.c"	if(!key_state)
	LDA	_key_state
	JNZ	_00300_DS_
;	.line	364; "demo212.c"	api_enter_stdby_mode(IO_KEY_ALL,0,1);
	LDA	#0x01
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x07
	PUSH	
	CALL	_api_enter_stdby_mode
	JMP	_00301_DS_
_00300_DS_:
;	.line	366; "demo212.c"	api_enter_stdby_mode(0,0,0);
	CLRA	
	PUSH	
	PUSH	
	PUSH	
	CALL	_api_enter_stdby_mode
_00301_DS_:
;	.line	367; "demo212.c"	if(!TOV)
	LDC	_TOV
	JC	_00303_DS_
;	.line	368; "demo212.c"	key_machine();
	CALL	_key_machine
_00303_DS_:
;	.line	369; "demo212.c"	return 1;
	LDA	#0x01
_00304_DS_:
	STA	_PTRCL
	LDA	#0xFA
	CALL	__sp_dec
	POP	
	STA	_RAMP1L
	LDA	_PTRCL
	RET	
;; end of function sys_rec
; exit point of _sys_rec

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_simple_speech_check:	;Function start
; 2 exit points
;	.line	278; "demo212.c"	BYTE simple_speech_check(void) // if 4 frame power no change (lot)
	LDA	_RAMP1L
	PUSH	
	P02P1	
	LDA	#0x05
	CALL	__sp_inc
;	.line	283; "demo212.c"	for(i=0;i<4;i++)
	CLRA	
	STA	@P1,3
_00250_DS_:
;	.line	285; "demo212.c"	j=oldpwr[i];
	LDA	@P1,3
	SHL	
	STA	@P1,1
	CLRA	
	ROL	
	STA	@P1,2
	LDA	#(_oldpwr + 0)
	ADD	@P1,1
	STA	@_RAMP1
	LDA	#> (_oldpwr + 0)
	ADDC	@P1,2
	STA	@P1,4
	LDA	@_RAMP1
	STA	_ROMPL
	LDA	@P1,4
	STA	_ROMPH
	LDA	@_ROMPINC
	STA	@P1,1
	LDA	@_ROMPINC
;	.line	286; "demo212.c"	if((j-(j>>3))>pwravg) // here must use > not >=, incase 0
	STA	@P1,2
	SHR	
	STA	@P1,4
	LDA	@P1,1
	ROR	
	STA	@_RAMP1
	LDA	@P1,4
	SHR	
	STA	@P1,4
	LDA	@_RAMP1
	ROR	
	STA	@_RAMP1
	LDA	@P1,4
	SHR	
	STA	@P1,4
	LDA	@_RAMP1
	ROR	
	STA	@_RAMP1
	SETB	_C
	LDA	@P1,1
	SUBB	@P1,0
	STA	@P1,1
	LDA	@P1,2
	SUBB	@P1,4
	STA	@P1,2
	SETB	_C
	LDA	_pwravg
	SUBB	@P1,1
	LDA	(_pwravg + 1)
	SUBB	@P1,2
	JC	_00251_DS_
;	.line	287; "demo212.c"	return 1;
	LDA	#0x01
	JMP	_00252_DS_
_00251_DS_:
;	.line	283; "demo212.c"	for(i=0;i<4;i++)
	LDA	@P1,3
	INCA	
	STA	@P1,3
	ADD	#0xfc
	JNC	_00250_DS_
;	.line	289; "demo212.c"	return 0;
	CLRA	
_00252_DS_:
	STA	_PTRCL
	LDA	#0xFB
	CALL	__sp_dec
	POP	
	STA	_RAMP1L
	LDA	_PTRCL
	RET	
;; end of function simple_speech_check
; exit point of _simple_speech_check

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_sys_play:	;Function start
; 0 exit points
;	.line	251; "demo212.c"	if(!api_play_job())
	CALL	_api_play_job
	JNZ	_00240_DS_
;	.line	254; "demo212.c"	if(playing_seg==2)
	LDA	_playing_seg
	XOR	#0x02
	JNZ	_00234_DS_
;	.line	256; "demo212.c"	api_play_stop();
	CALL	_api_play_stop
;	.line	257; "demo212.c"	enter_rec_mode();
	JMP	_enter_rec_mode
_00234_DS_:
;	.line	260; "demo212.c"	enter_idle_mode();
	JMP	_enter_idle_mode
_00240_DS_:
;	.line	264; "demo212.c"	if(key_state==KEYS_NOKEY)
	LDA	_key_state
	JNZ	_00237_DS_
;	.line	267; "demo212.c"	api_enter_stdby_mode(IO_KEY_ALL, 0, 1);
	LDA	#0x01
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x07
	PUSH	
	JMP	_api_enter_stdby_mode
_00237_DS_:
;	.line	270; "demo212.c"	api_enter_stdby_mode(0,0,0);
	CLRA	
	PUSH	
	PUSH	
	PUSH	
	JMP	_api_enter_stdby_mode

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_enter_idle_mode:	;Function start
; 0 exit points
;	.line	229; "demo212.c"	if(sys_state==SYS_AMP)
	LDA	_sys_state
	XOR	#0x03
	JNZ	_00226_DS_
;	.line	230; "demo212.c"	api_amp_stop();
	CALL	_api_amp_stop
_00226_DS_:
;	.line	231; "demo212.c"	api_play_stop();
	CALL	_api_play_stop
;	.line	233; "demo212.c"	if(sys_state==SYS_REC) // stop from recording
	LDA	_sys_state
	XOR	#0x02
	JNZ	_00228_DS_
;	.line	235; "demo212.c"	api_rec_stop(1); // it will add endcode here
	LDA	#0x01
	PUSH	
	CALL	_api_rec_stop
;	.line	237; "demo212.c"	api_beep_start(NORMAL_BEEP);
	LDA	#0x14
	PUSH	
	CALL	_api_beep_start
;	.line	238; "demo212.c"	wait_beep(BEEP_TIME2);
	LDA	#0x20
	PUSH	
	CALL	_wait_beep
;	.line	239; "demo212.c"	api_beep_stop();
	CALL	_api_beep_stop
;	.line	240; "demo212.c"	wait_beep(BEEP_TIME2);
	LDA	#0x20
	PUSH	
	CALL	_wait_beep
;	.line	241; "demo212.c"	api_beep_start(NORMAL_BEEP);
	LDA	#0x14
	PUSH	
	CALL	_api_beep_start
;	.line	242; "demo212.c"	wait_beep(BEEP_TIME2);
	LDA	#0x20
	PUSH	
	CALL	_wait_beep
;	.line	243; "demo212.c"	api_beep_stop();
	CALL	_api_beep_stop
_00228_DS_:
;	.line	245; "demo212.c"	sys_state=SYS_IDLE;
	CLRA	
	STA	_sys_state
;	.line	246; "demo212.c"	sleep_timer=KEY_WAIT;
	LDA	#0x05
	STA	_sleep_timer
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_enter_rec_mode:	;Function start
; 0 exit points
;	.line	195; "demo212.c"	key_code=0;
	CLRA	
	STA	_key_code
;	.line	198; "demo212.c"	wait_beep(BEEP_TIME1);
	LDA	#0x32
	PUSH	
	CALL	_wait_beep
;	.line	200; "demo212.c"	if(key_code)
	LDA	_key_code
	JZ	_00215_DS_
;	.line	201; "demo212.c"	return; // return will set 0
	RET	
_00215_DS_:
;	.line	207; "demo212.c"	API_EN5K_OFF
	CLRA	
	PUSH	
	LDA	#0xf2
	PUSH	
	CLRA	
	PUSH	
	CALL	_api_rec_prepare
;	.line	209; "demo212.c"	wait_beep(REC_WAIT_TIME);
	LDA	#0x46
	PUSH	
	CALL	_wait_beep
;	.line	210; "demo212.c"	if(key_code)
	LDA	_key_code
	JZ	_00217_DS_
;	.line	212; "demo212.c"	api_rec_stop(0);
	CLRA	
	PUSH	
;	.line	213; "demo212.c"	return;	
	JMP	_api_rec_stop
_00217_DS_:
;	.line	216; "demo212.c"	R3_STARTPAGE,R3_ENDPAGE,callbackchk))
	LDA	#(_callbackchk+0)
	PUSH	
	LDA	#>(_callbackchk+0)
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x02
	PUSH	
	LDA	#0x90
	PUSH	
	CLRA	
	PUSH	
	PUSH	
	LDA	#0xd0
	PUSH	
	LDA	#0x06
	PUSH	
	CALL	_api_rec_start
	JNZ	_00219_DS_
;	.line	218; "demo212.c"	api_rec_stop(0);
	CLRA	
	PUSH	
;	.line	219; "demo212.c"	return;		
	JMP	_api_rec_stop
_00219_DS_:
;	.line	221; "demo212.c"	sys_state=SYS_REC;
	LDA	#0x02
	STA	_sys_state
;	.line	222; "demo212.c"	rec_stage=0;
	CLRA	
;	.line	223; "demo212.c"	rindex=0;
	STA	_rec_stage
	STA	_rindex
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_callbackchk:	;Function start
; 2 exit points
;	.line	180; "demo212.c"	if(!key_state)
	LDA	_key_state
	JNZ	_00203_DS_
;	.line	181; "demo212.c"	api_enter_stdby_mode(IO_KEY_ALL,0,1);
	LDA	#0x01
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x07
	PUSH	
	CALL	_api_enter_stdby_mode
	JMP	_00204_DS_
_00203_DS_:
;	.line	183; "demo212.c"	api_enter_stdby_mode(0,0,0);
	CLRA	
	PUSH	
	PUSH	
	PUSH	
	CALL	_api_enter_stdby_mode
_00204_DS_:
;	.line	184; "demo212.c"	if(!TOV)
	LDC	_TOV
	JC	_00206_DS_
;	.line	185; "demo212.c"	key_machine();
	CALL	_key_machine
_00206_DS_:
;	.line	186; "demo212.c"	timer_routine();
	CALL	_timer_routine
;	.line	187; "demo212.c"	if(key_code)
	LDA	_key_code
	JZ	_00208_DS_
;	.line	188; "demo212.c"	return 1;
	LDA	#0x01
	RET	
_00208_DS_:
;	.line	189; "demo212.c"	return 0;
	CLRA	
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_wait_beep:	;Function start
; 0 exit points
;	.line	161; "demo212.c"	void wait_beep(BYTE count)
	LDA	_RAMP1L
	PUSH	
	P02P1	
	LDA	@P1,-2
	STA	_beep_timer
_00194_DS_:
;	.line	164; "demo212.c"	while(beep_timer)
	LDA	_beep_timer
	JZ	_00197_DS_
;	.line	166; "demo212.c"	timer_routine();
	CALL	_timer_routine
;	.line	167; "demo212.c"	if(key_state)
	LDA	_key_state
	JZ	_00192_DS_
;	.line	168; "demo212.c"	api_enter_stdby_mode(0 ,0,0); // use tmr wk
	CLRA	
	PUSH	
	PUSH	
	PUSH	
	CALL	_api_enter_stdby_mode
	JMP	_00194_DS_
_00192_DS_:
;	.line	170; "demo212.c"	api_enter_stdby_mode(IO_KEY_ALL,0,0); //use tmr+io wk
	CLRA	
	PUSH	
	PUSH	
	LDA	#0x07
	PUSH	
	CALL	_api_enter_stdby_mode
	JMP	_00194_DS_
_00197_DS_:
	POP	
	STA	_RAMP1L
	POP	
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_enter_play_mode:	;Function start
; 2 exit points
;	.line	139; "demo212.c"	BYTE enter_play_mode(BYTE seg)
	LDA	_RAMP1L
	PUSH	
	P02P1	
	PUSH	
;	.line	141; "demo212.c"	BYTE try_play=0;
	CLRA	
	STA	@_RAMP1
;	.line	142; "demo212.c"	api_set_vol(API_PAGV_DEFAULT,API_PLAYG_DEFAULT);
	LDA	#0x78
	PUSH	
	LDA	#0x3f
	PUSH	
	CALL	_api_set_vol
;	.line	143; "demo212.c"	switch(seg)
	SETB	_C
	LDA	#0x02
	SUBB	@P1,-2
	JNC	_00174_DS_
	LDA	@P1,-2
	CALL	_00185_DS_
_00185_DS_:
	SHL	
	ADD	#_00186_DS_
	STA	_STACKL
	CLRA	
	ADDC	#>(_00186_DS_)
	STA	_STACKH
	RET	
_00186_DS_:
	JMP	_00171_DS_
	JMP	_00172_DS_
	JMP	_00173_DS_
_00171_DS_:
;	.line	146; "demo212.c"	try_play=API_PSTARTH(P0);
	LDA	#0x04
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x70
	PUSH	
	LDA	#0x02
	PUSH	
	LDA	#0x1d
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x10
	PUSH	
	CLRA	
	PUSH	
	CALL	_api_play_start
	STA	@_RAMP1
;	.line	147; "demo212.c"	break;
	JMP	_00174_DS_
_00172_DS_:
;	.line	149; "demo212.c"	try_play=API_PSTARTH(P1);
	LDA	#0x04
	PUSH	
	LDA	#0x01
	PUSH	
	LDA	#0xc4
	PUSH	
	LDA	#0x01
	PUSH	
	LDA	#0x76
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x1d
	PUSH	
	CLRA	
	PUSH	
	CALL	_api_play_start
	STA	@_RAMP1
;	.line	150; "demo212.c"	break;
	JMP	_00174_DS_
_00173_DS_:
;	.line	153; "demo212.c"	try_play=api_play_start_with_state(R3_STARTPAGE, new_end_page, 0x17f, R3_ULAW, API_DAOSR_HIGH, &the_state);
	LDA	#(_the_state + 0)
	PUSH	
	LDA	#> (_the_state + 0)
	PUSH	
	LDA	#0x04
	PUSH	
	CLRA	
	PUSH	
	LDA	#0x7f
	PUSH	
	LDA	#0x01
	PUSH	
	LDA	_new_end_page
	PUSH	
	LDA	(_new_end_page + 1)
	PUSH	
	LDA	#0x90
	PUSH	
	CLRA	
	PUSH	
	CALL	_api_play_start_with_state
	STA	@_RAMP1
_00174_DS_:
;	.line	156; "demo212.c"	if(try_play)
	LDA	@_RAMP1
	JZ	_00176_DS_
;	.line	157; "demo212.c"	sys_state=SYS_PLAY;
	LDA	#0x01
	STA	_sys_state
_00176_DS_:
;	.line	158; "demo212.c"	playing_seg=seg;
	LDA	@P1,-2
	STA	_playing_seg
;	.line	159; "demo212.c"	return try_play; // return the result
	LDA	@_RAMP1
	STA	_PTRCL
	POP	
	POP	
	STA	_RAMP1L
	POP	
	LDA	_PTRCL
	RET	
;; end of function enter_play_mode
; exit point of _enter_play_mode

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_timer_routine:	;Function start
; 0 exit points
;	.line	127; "demo212.c"	if(!TOV)
	LDC	_TOV
;	.line	128; "demo212.c"	return ;
	JNC	_00166_DS_
;	.line	129; "demo212.c"	TOV=0;
	CLRB	_TOV
;	.line	130; "demo212.c"	if(sleep_timer)
	LDA	_sleep_timer
;	.line	131; "demo212.c"	sleep_timer--;
	JZ	_00163_DS_
	DECA	
	STA	_sleep_timer
_00163_DS_:
;	.line	132; "demo212.c"	if(beep_timer)
	LDA	_beep_timer
	JZ	_00165_DS_
;	.line	133; "demo212.c"	beep_timer--;
	LDA	_beep_timer
	DECA	
	STA	_beep_timer
_00165_DS_:
;	.line	135; "demo212.c"	key_machine();
	CALL	_key_machine
_00166_DS_:
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_key_machine:	;Function start
; 0 exit points
;	.line	91; "demo212.c"	void key_machine(void)
	LDA	_RAMP1L
	PUSH	
	P02P1	
	PUSH	
;	.line	94; "demo212.c"	k=get_key();
	CALL	_get_key
	STA	@_RAMP1
;	.line	95; "demo212.c"	switch(key_state)
	SETB	_C
	LDA	#0x02
	SUBB	_key_state
	JNC	_00133_DS_
	LDA	_key_state
	CALL	_00153_DS_
_00153_DS_:
	SHL	
	ADD	#_00154_DS_
	STA	_STACKL
	CLRA	
	ADDC	#>(_00154_DS_)
	STA	_STACKH
	RET	
_00154_DS_:
	JMP	_00120_DS_
	JMP	_00124_DS_
	JMP	_00129_DS_
_00120_DS_:
;	.line	98; "demo212.c"	if(!key_code && k)
	LDA	_key_code
	JNZ	_00133_DS_
;	.line	100; "demo212.c"	last_stroke=k;
	LDA	@_RAMP1
	JZ	_00133_DS_
	STA	_last_stroke
;	.line	101; "demo212.c"	key_state=KEYS_DEB;
	LDA	#0x01
	STA	_key_state
;	.line	102; "demo212.c"	key_timer=KEY_WAIT;
	LDA	#0x05
	STA	_key_timer
;	.line	104; "demo212.c"	break;
	JMP	_00133_DS_
_00124_DS_:
;	.line	106; "demo212.c"	if(k!=last_stroke)
	LDA	_last_stroke
	XOR	@_RAMP1
;	.line	108; "demo212.c"	key_state=KEYS_NOKEY;
	JZ	_00126_DS_
	CLRA	
	STA	_key_state
;	.line	109; "demo212.c"	break;
	JMP	_00133_DS_
_00126_DS_:
;	.line	111; "demo212.c"	if(!--key_timer)
	LDA	_key_timer
	DECA	
	STA	_key_timer
	JNZ	_00133_DS_
;	.line	113; "demo212.c"	key_code=last_stroke;
	LDA	_last_stroke
	STA	_key_code
;	.line	114; "demo212.c"	key_state=KEYS_WAITRELEASE;
	LDA	#0x02
	STA	_key_state
;	.line	116; "demo212.c"	break;
	JMP	_00133_DS_
_00129_DS_:
;	.line	118; "demo212.c"	if(!k)
	LDA	@_RAMP1
	JNZ	_00133_DS_
;	.line	119; "demo212.c"	key_state=KEYS_NOKEY;
	CLRA	
	STA	_key_state
_00133_DS_:
;	.line	122; "demo212.c"	};
	POP	
	POP	
	STA	_RAMP1L
	RET	

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_init:	;Function start
; 0 exit points
;	.line	82; "demo212.c"	IODIR=0xc0;
	LDA	#0xc0
	STA	_IODIR
;	.line	83; "demo212.c"	IO=0xFF; // all high
	LDA	#0xff
	STA	_IO
;	.line	84; "demo212.c"	IOWK=0; // deep sleep mode no use wk
	CLRA	
	STA	_IOWK
;	.line	85; "demo212.c"	sleep_timer=KEY_WAIT;
	LDA	#0x05
	STA	_sleep_timer
;	.line	86; "demo212.c"	new_end_page=R3_ENDPAGE;
	CLRA	
	STA	_new_end_page
	LDA	#0x02
	STA	(_new_end_page + 1)
;	.line	88; "demo212.c"	api_timer_on(TMR_RLD);
	LDA	#0xe0
	PUSH	
	JMP	_api_timer_on

	New pBlock

CSEG	 (CODE), dbName =C
;; Starting pCode block
_get_key:	;Function start
; 2 exit points
;	.line	70; "demo212.c"	if(!(IO&IO_PLAY))
	LDA	#0x02
	AND	_IO
	JNZ	_00106_DS_
;	.line	71; "demo212.c"	return KEY_CODE_PLAY;
	LDA	#0x01
	RET	
_00106_DS_:
;	.line	72; "demo212.c"	if(!(IO&IO_AMP))
	LDA	#0x04
	AND	_IO
	JNZ	_00108_DS_
;	.line	73; "demo212.c"	return KEY_CODE_AMP;
	LDA	#0x03
	RET	
_00108_DS_:
;	.line	74; "demo212.c"	if(!(IO&IO_REC))
	LDA	_IO
	SHR	
	JC	_00110_DS_
;	.line	75; "demo212.c"	return KEY_CODE_REC;
	LDA	#0x02
	RET	
_00110_DS_:
;	.line	76; "demo212.c"	return 0;
	CLRA	
	RET	
