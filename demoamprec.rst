ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 1.



                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.3.0 #8604 (Oct 17 2015) (MSVC)
                              4 ; This file was generated Sun Nov 22 19:16:58 2015
                              5 ;--------------------------------------------------------
                              6 ; MST port for the MS322 series simple CPU
                              7 ;--------------------------------------------------------
                              8 ;	.file	"demoamprec.c"
                              9 	.module demoamprec
                             10 	;.list	p=MS311
                             11 	;.radix dec
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 2.



                             12 	.include "ms311sfr.def"
                              1 	.area ms322sfr (SFR,OVR)
                              2 .globl _IOR  	
                              3 .globl _IODIR	
                              4 .globl _IO	
                              5 .globl _IOWK	
                              6 .globl _IOWKDR 
                              7 .globl _TIMERC 
                              8 .globl _THRLD	
                              9 .globl _RAMP0L 
                             10 .globl _RAMP0LH
                             11 .globl _RAMP0H 
                             12 .globl _RAMP1L 
                             13 .globl _RAMP1LH
                             14 .globl _RAMP1H 
                             15 .globl _PTRCL	
                             16 .globl _PTRCH	
                             17 .globl _ROMPL 	
                             18 .globl _ROMPLH
                             19 .globl _ROMPH 	
                             20 .globl _BEEPC 	
                             21 .globl _FILTERG 	
                             22 .globl _ULAWC 	
                             23 .globl _STACKL 
                             24 .globl _STACKH 
                             25 .globl _ADCON	
                             26 .globl _DACON  
                             27 .globl _SYSC 	
                             28 .globl _SPIM	
                             29 .globl _SPIMH
                             30 .globl _SPIH	
                             31 .globl _SPIOP	
                             32 .globl _SPI_BANK
                             33 .globl _ADP_IND
                             34 .globl _ADP_VPL
                             35 .globl _ADP_VPH
                             36 .globl _ADP_VPLH
                             37 .globl _ADL	
                             38 .globl _ADH	
                             39 .globl _ZC	
                             40 .globl _ADCG	
                             41 .globl _DAC_PL	
                             42 .globl _DAC_PH 
                             43 .globl _PAG	
                             44 .globl _DMAL	
                             45 .globl _DMAH	
                             46 .globl _DMAHL
                             47 .globl _SPIL	
                             48 .globl _IOMASK 
                             49 .globl _IOCMP  
                             50 .globl _IOCNT  
                             51 .globl _LVDCON 
                             52 .globl _LVRCON 
                             53 .globl _OFFSETL
                             54 .globl _OFFSETLH
                             55 .globl _OFFSETH
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 3.



                             56 .globl _RCCON  
                             57 .globl _BGCON  
                             58 .globl _PWRL	
                             59 .globl _PWRHL	
                             60 .globl _CRYPT  
                             61 .globl _PWRH	
                             62 .globl _IROMDL 
                             63 .globl _IROMDH 
                             64 .globl _IROMDLH 
                             65 .globl _RECMUTE
                             66 .globl _SPKC
                             67 .globl _DCLAMP
                             68 .globl _SSPIC
                             69 .globl _SSPIL
                             70 .globl _SSPIM
                             71 .globl _SSPIH
                             72 ; fake registers below
                             73 .globl _RAMP0UW
                             74 .globl _RAMP1UW
                             75 .globl _ROMPUW
                             76 .globl _RAMP0	
                             77 .globl _RAMP0INC
                             78 .globl _RAMP1  
                             79 .globl _RAMP1INC
                             80 .globl _RAMP1INC2
                             81 .globl _ROMP	
                             82 .globl _ROMPINC
                             83 .globl _ROMPINC2
                             84 .globl _ACC	
                             85 .globl _ICE0
                             86 .globl _ICE1
                             87 .globl _ICE2
                             88 .globl _ICE3
                             89 .globl _ICE4
                             90 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 4.



                             13 ;--------------------------------------------------------
                             14 ; overlayable items in internal ram 
                             15 ;--------------------------------------------------------
                             16 ;	udata_ovr
                             17 	;***Area-order define***
                             18 	.area sharebank (DATA,OVR)
                             19 	.area DSEG (DATA)
                             20 	.area ISEG (DATA)
                             21 	.area XSEG (DATA)
                             22 	.area XISEG (DATA)
                             23 	.area SSEG (DATA,OVR)
                             24 ;--------------------------------------------------------
                             25 ; reset vector 
                             26 ;--------------------------------------------------------
                             27 .area STARTUP_CSEG	 (CODE)	
                             28 	.globl __ms311_cstartup
   0000 F5 31         [ 2]   29 	jmp __ms311_cstartup
                             30 ;--------------------------------------------------------
                             31 ; code
                             32 ;--------------------------------------------------------
                             33 ;***
                             34 ;  pBlock Stats: dbName = M
                             35 ;***
                             36 ;entry:  _main:	;Function start
                             37 ; 0 exit points
                             38 ;highest stack level is: 0
                             39 ;functions called:
                             40 ;   _init
                             41 ;   _timer_routine
                             42 ;   _enter_idle_mode
                             43 ;   _enter_rec_mode
                             44 ;   _enter_play_mode
                             45 ;   _enter_amp_mode
                             46 ;   _sys_amp
                             47 ;   _sys_play
                             48 ;   _api_enter_dsleep_mode
                             49 ;   _api_enter_stdby_mode
                             50 ;   _key_machine
                             51 ;; Starting pCode block
   0002                      52 _main:	;Function start
                             53 ; 0 exit points
                             54 ;	.line	397; "demoamprec.c"	API_USE_ERC;
   0002 00 98         [ 2]   55 	LDA	#0x98
   0004 72 2F         [ 2]   56 	AND	_RCCON
   0006 60 03         [ 2]   57 	ORA	#0x03
   0008 12 2F         [ 2]   58 	STA	_RCCON
                             59 ;	.line	398; "demoamprec.c"	ULAWC=ULAWC_DEFAULT;
   000A 00 18         [ 2]   60 	LDA	#0x18
   000C 12 10         [ 2]   61 	STA	_ULAWC
                             62 ;	.line	399; "demoamprec.c"	OFFSETL=2;
   000E 00 02         [ 2]   63 	LDA	#0x02
   0010 12 2D         [ 2]   64 	STA	_OFFSETL
                             65 ;	.line	400; "demoamprec.c"	init();
   0012 B3 A6         [ 3]   66 	CALL	_init
                             67 ;	.line	401; "demoamprec.c"	if(!(init_io_state&IO_CAP) )
   0014 00 08         [ 2]   68 	LDA	#0x08
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 5.



   0016 73 00         [ 2]   69 	AND	_init_io_state
   0018 E4 12         [ 2]   70 	JNZ	_00306_DS_
                             71 ;	.line	404; "demoamprec.c"	API_SPI_ERASE((USHORT)R2_STARTPAGE); // first time we erase!!
   001A CE            [ 1]   72 	CLRA	
   001B 12 17         [ 2]   73 	STA	_SPIH
   001D 00 80         [ 2]   74 	LDA	#0x80
   001F 12 16         [ 2]   75 	STA	_SPIM
   0021 CE            [ 1]   76 	CLRA	
   0022 12 26         [ 2]   77 	STA	_SPIL
   0024 00 01         [ 2]   78 	LDA	#0x01
   0026 12 18         [ 2]   79 	STA	_SPIOP
   0028 00 02         [ 2]   80 	LDA	#0x02
   002A 12 18         [ 2]   81 	STA	_SPIOP
   002C                      82 _00306_DS_:
                             83 ;	.line	406; "demoamprec.c"	IODIR=0xf0;
   002C 00 F0         [ 2]   84 	LDA	#0xf0
   002E 12 01         [ 2]   85 	STA	_IODIR
   0030                      86 _00337_DS_:
                             87 ;	.line	409; "demoamprec.c"	timer_routine();
   0030 B3 34         [ 3]   88 	CALL	_timer_routine
                             89 ;	.line	410; "demoamprec.c"	IO^=0x80;
   0032 00 80         [ 2]   90 	LDA	#0x80
   0034 82 02         [ 2]   91 	XOR	_IO
   0036 12 02         [ 2]   92 	STA	_IO
                             93 ;	.line	411; "demoamprec.c"	if(key_code)
   0038 03 07         [ 2]   94 	LDA	_key_code
   003A E6 79         [ 2]   95 	JZ	_00319_DS_
                             96 ;	.line	413; "demoamprec.c"	if(sys_state!=SYS_IDLE && key_code!=KEY_CODE_REC)
   003C 03 05         [ 2]   97 	LDA	_sys_state
   003E E6 0A         [ 2]   98 	JZ	_00315_DS_
   0040 03 07         [ 2]   99 	LDA	_key_code
   0042 80 02         [ 2]  100 	XOR	#0x02
                            101 ;	.line	414; "demoamprec.c"	enter_idle_mode();
   0044 E6 04         [ 2]  102 	JZ	_00315_DS_
   0046 B1 F7         [ 3]  103 	CALL	_enter_idle_mode
   0048 F0 B2         [ 2]  104 	JMP	_00316_DS_
   004A                     105 _00315_DS_:
                            106 ;	.line	416; "demoamprec.c"	switch(key_code)
   004A 03 07         [ 2]  107 	LDA	_key_code
   004C E6 64         [ 2]  108 	JZ	_00316_DS_
   004E 2F            [ 2]  109 	SETB	_C
   004F 00 03         [ 2]  110 	LDA	#0x03
   0051 4B 07         [ 2]  111 	SUBB	_key_code
   0053 E0 5D         [ 2]  112 	JNC	_00316_DS_
   0055 03 07         [ 2]  113 	LDA	_key_code
   0057 CD            [ 1]  114 	DECA	
   0058 B0 5A         [ 3]  115 	CALL	_00384_DS_
   005A                     116 _00384_DS_:
   005A 90            [ 1]  117 	SHL	
   005B 50 65         [ 2]  118 	ADD	#_00385_DS_
   005D 12 11         [ 2]  119 	STA	_STACKL
   005F CE            [ 1]  120 	CLRA	
   0060 40 00         [ 2]  121 	ADDC	#>(_00385_DS_)
   0062 12 12         [ 2]  122 	STA	_STACKH
   0064 C0            [ 1]  123 	RET	
   0065                     124 _00385_DS_:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 6.



   0065 F0 6F         [ 2]  125 	JMP	_00308_DS_
   0067 F0 6B         [ 2]  126 	JMP	_00307_DS_
   0069 F0 B0         [ 2]  127 	JMP	_00312_DS_
   006B                     128 _00307_DS_:
                            129 ;	.line	419; "demoamprec.c"	enter_rec_mode();
   006B B2 18         [ 3]  130 	CALL	_enter_rec_mode
                            131 ;	.line	420; "demoamprec.c"	break;
   006D F0 B2         [ 2]  132 	JMP	_00316_DS_
   006F                     133 _00308_DS_:
                            134 ;	.line	423; "demoamprec.c"	API_SPI_READ_PAGE((USHORT)R2_STARTPAGE, 1);// read prev data to 0x100
   006F CE            [ 1]  135 	CLRA	
   0070 12 17         [ 2]  136 	STA	_SPIH
   0072 00 80         [ 2]  137 	LDA	#0x80
   0074 12 16         [ 2]  138 	STA	_SPIM
   0076 CE            [ 1]  139 	CLRA	
   0077 12 26         [ 2]  140 	STA	_SPIL
   0079 00 48         [ 2]  141 	LDA	#0x48
   007B 12 18         [ 2]  142 	STA	_SPIOP
                            143 ;	.line	424; "demoamprec.c"	if(TAG==0xff)
   007D CE            [ 1]  144 	CLRA	
   007E 12 0D         [ 2]  145 	STA	_ROMPL
   0080 00 81         [ 2]  146 	LDA	#0x81
   0082 12 0E         [ 2]  147 	STA	_ROMPH
   0084 0E            [ 2]  148 	LDA	@_ROMPINC
   0085 80 FF         [ 2]  149 	XOR	#0xff
   0087 E4 20         [ 2]  150 	JNZ	_00310_DS_
                            151 ;	.line	426; "demoamprec.c"	TAG=0;
   0089 00 81         [ 2]  152 	LDA	#0x81
   008B 12 0E         [ 2]  153 	STA	_ROMPH
   008D CE            [ 1]  154 	CLRA	
   008E 12 0D         [ 2]  155 	STA	_ROMPL
   0090 1E            [ 2]  156 	STA	@_ROMPINC
                            157 ;	.line	427; "demoamprec.c"	API_SPI_WRITE_PAGE((USHORT)R2_STARTPAGE,1); // write it
   0091 CE            [ 1]  158 	CLRA	
   0092 12 17         [ 2]  159 	STA	_SPIH
   0094 00 80         [ 2]  160 	LDA	#0x80
   0096 12 16         [ 2]  161 	STA	_SPIM
   0098 CE            [ 1]  162 	CLRA	
   0099 12 26         [ 2]  163 	STA	_SPIL
   009B 00 01         [ 2]  164 	LDA	#0x01
   009D 12 18         [ 2]  165 	STA	_SPIOP
   009F 00 44         [ 2]  166 	LDA	#0x44
   00A1 12 18         [ 2]  167 	STA	_SPIOP
                            168 ;	.line	428; "demoamprec.c"	enter_play_mode(0);
   00A3 CE            [ 1]  169 	CLRA	
   00A4 1C            [ 2]  170 	PUSH	
   00A5 B2 A6         [ 3]  171 	CALL	_enter_play_mode
   00A7 F0 B2         [ 2]  172 	JMP	_00316_DS_
   00A9                     173 _00310_DS_:
                            174 ;	.line	431; "demoamprec.c"	enter_play_mode(1);
   00A9 00 01         [ 2]  175 	LDA	#0x01
   00AB 1C            [ 2]  176 	PUSH	
   00AC B2 A6         [ 3]  177 	CALL	_enter_play_mode
                            178 ;	.line	434; "demoamprec.c"	break;
   00AE F0 B2         [ 2]  179 	JMP	_00316_DS_
   00B0                     180 _00312_DS_:
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 7.



                            181 ;	.line	436; "demoamprec.c"	enter_amp_mode();
   00B0 B1 2E         [ 3]  182 	CALL	_enter_amp_mode
   00B2                     183 _00316_DS_:
                            184 ;	.line	439; "demoamprec.c"	key_code=0;
   00B2 CE            [ 1]  185 	CLRA	
   00B3 13 07         [ 2]  186 	STA	_key_code
   00B5                     187 _00319_DS_:
                            188 ;	.line	449; "demoamprec.c"	else */  if(sys_state==SYS_AMP|| sys_state==SYS_AMP_REC)
   00B5 03 05         [ 2]  189 	LDA	_sys_state
   00B7 80 02         [ 2]  190 	XOR	#0x02
   00B9 E6 06         [ 2]  191 	JZ	_00332_DS_
   00BB 03 05         [ 2]  192 	LDA	_sys_state
   00BD 80 03         [ 2]  193 	XOR	#0x03
   00BF E4 04         [ 2]  194 	JNZ	_00333_DS_
   00C1                     195 _00332_DS_:
                            196 ;	.line	451; "demoamprec.c"	sys_amp();
   00C1 B0 F6         [ 3]  197 	CALL	_sys_amp
   00C3 F0 30         [ 2]  198 	JMP	_00337_DS_
   00C5                     199 _00333_DS_:
                            200 ;	.line	453; "demoamprec.c"	else if(sys_state==SYS_PLAY)
   00C5 03 05         [ 2]  201 	LDA	_sys_state
   00C7 80 01         [ 2]  202 	XOR	#0x01
   00C9 E4 04         [ 2]  203 	JNZ	_00330_DS_
                            204 ;	.line	454; "demoamprec.c"	sys_play();
   00CB B1 D0         [ 3]  205 	CALL	_sys_play
   00CD F0 30         [ 2]  206 	JMP	_00337_DS_
   00CF                     207 _00330_DS_:
                            208 ;	.line	455; "demoamprec.c"	else if(!sleep_timer && key_state==KEYS_NOKEY)
   00CF 03 0B         [ 2]  209 	LDA	_sleep_timer
   00D1 E4 08         [ 2]  210 	JNZ	_00326_DS_
   00D3 03 04         [ 2]  211 	LDA	_key_state
   00D5 E4 04         [ 2]  212 	JNZ	_00326_DS_
                            213 ;	.line	456; "demoamprec.c"	api_enter_dsleep_mode();
   00D7 B7 9B         [ 3]  214 	CALL	_api_enter_dsleep_mode
   00D9 F0 30         [ 2]  215 	JMP	_00337_DS_
   00DB                     216 _00326_DS_:
                            217 ;	.line	460; "demoamprec.c"	if(key_state)
   00DB 03 04         [ 2]  218 	LDA	_key_state
   00DD E6 08         [ 2]  219 	JZ	_00321_DS_
                            220 ;	.line	461; "demoamprec.c"	api_enter_stdby_mode(0 ,0,0); // use tmr wk
   00DF CE            [ 1]  221 	CLRA	
   00E0 1C            [ 2]  222 	PUSH	
   00E1 1C            [ 2]  223 	PUSH	
   00E2 1C            [ 2]  224 	PUSH	
   00E3 B7 4A         [ 3]  225 	CALL	_api_enter_stdby_mode
   00E5 F0 EF         [ 2]  226 	JMP	_00322_DS_
   00E7                     227 _00321_DS_:
                            228 ;	.line	463; "demoamprec.c"	api_enter_stdby_mode(IO_KEY_ALL,0,0); //use tmr+io wk
   00E7 CE            [ 1]  229 	CLRA	
   00E8 1C            [ 2]  230 	PUSH	
   00E9 1C            [ 2]  231 	PUSH	
   00EA 00 07         [ 2]  232 	LDA	#0x07
   00EC 1C            [ 2]  233 	PUSH	
   00ED B7 4A         [ 3]  234 	CALL	_api_enter_stdby_mode
   00EF                     235 _00322_DS_:
                            236 ;	.line	464; "demoamprec.c"	if(!TOV)
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 8.



   00EF DC            [ 1]  237 	LDC	_TOV
   00F0 E3 3E         [ 2]  238 	JC	_00337_DS_
                            239 ;	.line	465; "demoamprec.c"	key_machine(); // wake up by IO, we get keycode first
   00F2 B3 49         [ 3]  240 	CALL	_key_machine
   00F4 F0 30         [ 2]  241 	JMP	_00337_DS_
                            242 
                            243 ;***
                            244 ;  pBlock Stats: dbName = C
                            245 ;***
                            246 ;entry:  _sys_amp:	;Function start
                            247 ; 0 exit points
                            248 ;highest stack level is: 1
                            249 ;functions called:
                            250 ;   _api_amp_start
                            251 ;   _api_rec_job
                            252 ;   _api_amp_rec_stop
                            253 ;   _api_enter_stdby_mode
                            254 ;; Starting pCode block
   00F6                     255 _sys_amp:	;Function start
                            256 ; 0 exit points
                            257 ;	.line	375; "demoamprec.c"	if(rec_stage==0 && !beep_timer)
   00F6 03 0A         [ 2]  258 	LDA	_rec_stage
   00F8 E4 0A         [ 2]  259 	JNZ	_00290_DS_
   00FA 03 09         [ 2]  260 	LDA	_beep_timer
   00FC E4 06         [ 2]  261 	JNZ	_00290_DS_
                            262 ;	.line	377; "demoamprec.c"	rec_stage=1;
   00FE 00 01         [ 2]  263 	LDA	#0x01
   0100 13 0A         [ 2]  264 	STA	_rec_stage
                            265 ;	.line	378; "demoamprec.c"	api_amp_start();
   0102 B3 E3         [ 3]  266 	CALL	_api_amp_start
   0104                     267 _00290_DS_:
                            268 ;	.line	380; "demoamprec.c"	if(sys_state==SYS_AMP_REC)
   0104 03 05         [ 2]  269 	LDA	_sys_state
   0106 80 03         [ 2]  270 	XOR	#0x03
   0108 E4 0C         [ 2]  271 	JNZ	_00295_DS_
                            272 ;	.line	382; "demoamprec.c"	if(!api_amp_rec_job())
   010A B6 60         [ 3]  273 	CALL	_api_rec_job
   010C E4 08         [ 2]  274 	JNZ	_00295_DS_
                            275 ;	.line	384; "demoamprec.c"	api_amp_rec_stop(0);
   010E CE            [ 1]  276 	CLRA	
   010F 1C            [ 2]  277 	PUSH	
   0110 B6 E1         [ 3]  278 	CALL	_api_amp_rec_stop
                            279 ;	.line	385; "demoamprec.c"	sys_state=SYS_AMP; // back to amp mode
   0112 00 02         [ 2]  280 	LDA	#0x02
   0114 13 05         [ 2]  281 	STA	_sys_state
   0116                     282 _00295_DS_:
                            283 ;	.line	388; "demoamprec.c"	if(key_state || beep_timer)
   0116 03 04         [ 2]  284 	LDA	_key_state
   0118 E4 04         [ 2]  285 	JNZ	_00296_DS_
   011A 03 09         [ 2]  286 	LDA	_beep_timer
   011C E6 06         [ 2]  287 	JZ	_00297_DS_
   011E                     288 _00296_DS_:
                            289 ;	.line	389; "demoamprec.c"	api_enter_stdby_mode(0 ,0,0); // use tmr wk
   011E CE            [ 1]  290 	CLRA	
   011F 1C            [ 2]  291 	PUSH	
   0120 1C            [ 2]  292 	PUSH	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 9.



   0121 1C            [ 2]  293 	PUSH	
   0122 F7 4A         [ 2]  294 	JMP	_api_enter_stdby_mode
   0124                     295 _00297_DS_:
                            296 ;	.line	391; "demoamprec.c"	api_enter_stdby_mode(IO_KEY_ALL,0,1); //use IO wk
   0124 00 01         [ 2]  297 	LDA	#0x01
   0126 1C            [ 2]  298 	PUSH	
   0127 CE            [ 1]  299 	CLRA	
   0128 1C            [ 2]  300 	PUSH	
   0129 00 07         [ 2]  301 	LDA	#0x07
   012B 1C            [ 2]  302 	PUSH	
   012C F7 4A         [ 2]  303 	JMP	_api_enter_stdby_mode
                            304 
                            305 ;***
                            306 ;  pBlock Stats: dbName = C
                            307 ;***
                            308 ;entry:  _enter_amp_mode:	;Function start
                            309 ; 0 exit points
                            310 ;highest stack level is: 1
                            311 ;functions called:
                            312 ;   _api_set_vol
                            313 ;   _api_amp_prepare
                            314 ;; Starting pCode block
   012E                     315 _enter_amp_mode:	;Function start
                            316 ; 0 exit points
                            317 ;	.line	366; "demoamprec.c"	api_set_vol(API_PAGV_DEFAULT,API_PLAYG_DEFAULT);
   012E 00 78         [ 2]  318 	LDA	#0x78
   0130 1C            [ 2]  319 	PUSH	
   0131 00 3F         [ 2]  320 	LDA	#0x3f
   0133 1C            [ 2]  321 	PUSH	
   0134 B7 83         [ 3]  322 	CALL	_api_set_vol
                            323 ;	.line	367; "demoamprec.c"	api_amp_prepare(0x3f, 0x80, 0x60, API_EN5K_ON, 0,6,callbackchk) ; // analog mode
   0136 00 57         [ 2]  324 	LDA	#(_callbackchk+0)
   0138 1C            [ 2]  325 	PUSH	
   0139 00 02         [ 2]  326 	LDA	#>(_callbackchk+0)
   013B 1C            [ 2]  327 	PUSH	
   013C 00 06         [ 2]  328 	LDA	#0x06
   013E 1C            [ 2]  329 	PUSH	
   013F CE            [ 1]  330 	CLRA	
   0140 1C            [ 2]  331 	PUSH	
   0141 00 10         [ 2]  332 	LDA	#0x10
   0143 1C            [ 2]  333 	PUSH	
   0144 00 60         [ 2]  334 	LDA	#0x60
   0146 1C            [ 2]  335 	PUSH	
   0147 00 80         [ 2]  336 	LDA	#0x80
   0149 1C            [ 2]  337 	PUSH	
   014A 00 3F         [ 2]  338 	LDA	#0x3f
   014C 1C            [ 2]  339 	PUSH	
   014D B3 E8         [ 3]  340 	CALL	_api_amp_prepare
                            341 ;	.line	368; "demoamprec.c"	sys_state=SYS_AMP;
   014F 00 02         [ 2]  342 	LDA	#0x02
   0151 13 05         [ 2]  343 	STA	_sys_state
                            344 ;	.line	369; "demoamprec.c"	rec_stage=0;
   0153 CE            [ 1]  345 	CLRA	
   0154 13 0A         [ 2]  346 	STA	_rec_stage
                            347 ;	.line	370; "demoamprec.c"	beep_timer=50;
   0156 00 32         [ 2]  348 	LDA	#0x32
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 10.



   0158 13 09         [ 2]  349 	STA	_beep_timer
   015A C0            [ 1]  350 	RET	
                            351 
                            352 ;***
                            353 ;  pBlock Stats: dbName = C
                            354 ;***
                            355 ;entry:  _simple_speech_check:	;Function start
                            356 ; 2 exit points
                            357 ;highest stack level is: 0
                            358 ;has an exit
                            359 ;; Starting pCode block
   015B                     360 _simple_speech_check:	;Function start
                            361 ; 2 exit points
                            362 ;	.line	267; "demoamprec.c"	BYTE simple_speech_check(void) // if 4 frame power no change (lot)
   015B 02 09         [ 2]  363 	LDA	_RAMP1L
   015D 1C            [ 2]  364 	PUSH	
   015E C8            [ 1]  365 	P02P1	
   015F 00 05         [ 2]  366 	LDA	#0x05
   0161 B8 3D         [ 3]  367 	CALL	__sp_inc
                            368 ;	.line	272; "demoamprec.c"	for(i=0;i<4;i++)
   0163 CE            [ 1]  369 	CLRA	
   0164 11 03         [ 2]  370 	STA	@P1,3
   0166                     371 _00261_DS_:
                            372 ;	.line	274; "demoamprec.c"	j=oldpwr[i];
   0166 01 03         [ 2]  373 	LDA	@P1,3
   0168 90            [ 1]  374 	SHL	
   0169 11 01         [ 2]  375 	STA	@P1,1
   016B CE            [ 1]  376 	CLRA	
   016C 91            [ 1]  377 	ROL	
   016D 11 02         [ 2]  378 	STA	@P1,2
   016F 00 18         [ 2]  379 	LDA	#(_oldpwr + 0)
   0171 51 01         [ 2]  380 	ADD	@P1,1
   0173 15            [ 2]  381 	STA	@_RAMP1
   0174 00 80         [ 2]  382 	LDA	#> (_oldpwr + 0)
   0176 41 02         [ 2]  383 	ADDC	@P1,2
   0178 11 04         [ 2]  384 	STA	@P1,4
   017A 05            [ 2]  385 	LDA	@_RAMP1
   017B 12 0D         [ 2]  386 	STA	_ROMPL
   017D 01 04         [ 2]  387 	LDA	@P1,4
   017F 12 0E         [ 2]  388 	STA	_ROMPH
   0181 0E            [ 2]  389 	LDA	@_ROMPINC
   0182 11 01         [ 2]  390 	STA	@P1,1
   0184 0E            [ 2]  391 	LDA	@_ROMPINC
                            392 ;	.line	275; "demoamprec.c"	if((j-(j>>3))>pwravg) // here must use > not >=, incase 0
   0185 11 02         [ 2]  393 	STA	@P1,2
   0187 92            [ 1]  394 	SHR	
   0188 11 04         [ 2]  395 	STA	@P1,4
   018A 01 01         [ 2]  396 	LDA	@P1,1
   018C 93            [ 1]  397 	ROR	
   018D 15            [ 2]  398 	STA	@_RAMP1
   018E 01 04         [ 2]  399 	LDA	@P1,4
   0190 92            [ 1]  400 	SHR	
   0191 11 04         [ 2]  401 	STA	@P1,4
   0193 05            [ 2]  402 	LDA	@_RAMP1
   0194 93            [ 1]  403 	ROR	
   0195 15            [ 2]  404 	STA	@_RAMP1
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 11.



   0196 01 04         [ 2]  405 	LDA	@P1,4
   0198 92            [ 1]  406 	SHR	
   0199 11 04         [ 2]  407 	STA	@P1,4
   019B 05            [ 2]  408 	LDA	@_RAMP1
   019C 93            [ 1]  409 	ROR	
   019D 15            [ 2]  410 	STA	@_RAMP1
   019E 2F            [ 2]  411 	SETB	_C
   019F 01 01         [ 2]  412 	LDA	@P1,1
   01A1 49 00         [ 2]  413 	SUBB	@P1,0
   01A3 11 01         [ 2]  414 	STA	@P1,1
   01A5 01 02         [ 2]  415 	LDA	@P1,2
   01A7 49 04         [ 2]  416 	SUBB	@P1,4
   01A9 11 02         [ 2]  417 	STA	@P1,2
   01AB 2F            [ 2]  418 	SETB	_C
   01AC 03 23         [ 2]  419 	LDA	_pwravg
   01AE 49 01         [ 2]  420 	SUBB	@P1,1
   01B0 03 24         [ 2]  421 	LDA	(_pwravg + 1)
   01B2 49 02         [ 2]  422 	SUBB	@P1,2
                            423 ;	.line	276; "demoamprec.c"	return 1;
   01B4 E2 04         [ 2]  424 	JC	_00262_DS_
   01B6 00 01         [ 2]  425 	LDA	#0x01
   01B8 F1 C4         [ 2]  426 	JMP	_00263_DS_
   01BA                     427 _00262_DS_:
                            428 ;	.line	272; "demoamprec.c"	for(i=0;i<4;i++)
   01BA 01 03         [ 2]  429 	LDA	@P1,3
   01BC CC            [ 1]  430 	INCA	
   01BD 11 03         [ 2]  431 	STA	@P1,3
   01BF 50 FC         [ 2]  432 	ADD	#0xfc
   01C1 E1 A3         [ 2]  433 	JNC	_00261_DS_
                            434 ;	.line	278; "demoamprec.c"	return 0;
   01C3 CE            [ 1]  435 	CLRA	
   01C4                     436 _00263_DS_:
   01C4 12 0B         [ 2]  437 	STA	_PTRCL
   01C6 00 FB         [ 2]  438 	LDA	#0xFB
   01C8 B7 76         [ 3]  439 	CALL	__sp_dec
   01CA C4            [ 1]  440 	POP	
   01CB 12 09         [ 2]  441 	STA	_RAMP1L
   01CD 02 0B         [ 2]  442 	LDA	_PTRCL
   01CF C0            [ 1]  443 	RET	
                            444 ;; end of function simple_speech_check
                            445 ; exit point of _simple_speech_check
                            446 
                            447 ;***
                            448 ;  pBlock Stats: dbName = C
                            449 ;***
                            450 ;entry:  _sys_play:	;Function start
                            451 ; 0 exit points
                            452 ;highest stack level is: 1
                            453 ;functions called:
                            454 ;   _api_play_job
                            455 ;   _api_play_stop
                            456 ;   _enter_play_mode
                            457 ;   _enter_idle_mode
                            458 ;   _api_enter_stdby_mode
                            459 ;; Starting pCode block
   01D0                     460 _sys_play:	;Function start
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 12.



                            461 ; 0 exit points
                            462 ;	.line	242; "demoamprec.c"	if(!api_play_job())
   01D0 B5 86         [ 3]  463 	CALL	_api_play_job
   01D2 E4 0F         [ 2]  464 	JNZ	_00240_DS_
                            465 ;	.line	244; "demoamprec.c"	api_play_stop();
   01D4 B6 5C         [ 3]  466 	CALL	_api_play_stop
                            467 ;	.line	246; "demoamprec.c"	if(playing_seg!=2)
   01D6 03 2D         [ 2]  468 	LDA	_playing_seg
   01D8 80 02         [ 2]  469 	XOR	#0x02
                            470 ;	.line	247; "demoamprec.c"	enter_play_mode(2);
   01DA E6 05         [ 2]  471 	JZ	_00234_DS_
   01DC 00 02         [ 2]  472 	LDA	#0x02
   01DE 1C            [ 2]  473 	PUSH	
   01DF F2 A6         [ 2]  474 	JMP	_enter_play_mode
   01E1                     475 _00234_DS_:
                            476 ;	.line	249; "demoamprec.c"	enter_idle_mode();
   01E1 F1 F7         [ 2]  477 	JMP	_enter_idle_mode
   01E3                     478 _00240_DS_:
                            479 ;	.line	253; "demoamprec.c"	if(key_state==KEYS_NOKEY)
   01E3 03 04         [ 2]  480 	LDA	_key_state
   01E5 E4 0A         [ 2]  481 	JNZ	_00237_DS_
                            482 ;	.line	256; "demoamprec.c"	api_enter_stdby_mode(IO_KEY_ALL, 0, 1);
   01E7 00 01         [ 2]  483 	LDA	#0x01
   01E9 1C            [ 2]  484 	PUSH	
   01EA CE            [ 1]  485 	CLRA	
   01EB 1C            [ 2]  486 	PUSH	
   01EC 00 07         [ 2]  487 	LDA	#0x07
   01EE 1C            [ 2]  488 	PUSH	
   01EF F7 4A         [ 2]  489 	JMP	_api_enter_stdby_mode
   01F1                     490 _00237_DS_:
                            491 ;	.line	259; "demoamprec.c"	api_enter_stdby_mode(0,0,0);
   01F1 CE            [ 1]  492 	CLRA	
   01F2 1C            [ 2]  493 	PUSH	
   01F3 1C            [ 2]  494 	PUSH	
   01F4 1C            [ 2]  495 	PUSH	
   01F5 F7 4A         [ 2]  496 	JMP	_api_enter_stdby_mode
                            497 
                            498 ;***
                            499 ;  pBlock Stats: dbName = C
                            500 ;***
                            501 ;entry:  _enter_idle_mode:	;Function start
                            502 ; 0 exit points
                            503 ;highest stack level is: 2
                            504 ;functions called:
                            505 ;   _api_amp_rec_stop
                            506 ;   _api_amp_stop
                            507 ;   _api_play_stop
                            508 ;; Starting pCode block
   01F7                     509 _enter_idle_mode:	;Function start
                            510 ; 0 exit points
                            511 ;	.line	227; "demoamprec.c"	if(sys_state==SYS_AMP_REC)
   01F7 03 05         [ 2]  512 	LDA	_sys_state
   01F9 80 03         [ 2]  513 	XOR	#0x03
   01FB E4 05         [ 2]  514 	JNZ	_00226_DS_
                            515 ;	.line	229; "demoamprec.c"	api_amp_rec_stop(1);
   01FD 00 01         [ 2]  516 	LDA	#0x01
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 13.



   01FF 1C            [ 2]  517 	PUSH	
   0200 B6 E1         [ 3]  518 	CALL	_api_amp_rec_stop
   0202                     519 _00226_DS_:
                            520 ;	.line	231; "demoamprec.c"	if(sys_state==SYS_AMP)
   0202 03 05         [ 2]  521 	LDA	_sys_state
   0204 80 02         [ 2]  522 	XOR	#0x02
   0206 E4 02         [ 2]  523 	JNZ	_00228_DS_
                            524 ;	.line	232; "demoamprec.c"	api_amp_stop();
   0208 B3 DD         [ 3]  525 	CALL	_api_amp_stop
   020A                     526 _00228_DS_:
                            527 ;	.line	233; "demoamprec.c"	api_play_stop();
   020A B6 5C         [ 3]  528 	CALL	_api_play_stop
                            529 ;	.line	235; "demoamprec.c"	sys_state=SYS_IDLE;
   020C CE            [ 1]  530 	CLRA	
   020D 13 05         [ 2]  531 	STA	_sys_state
                            532 ;	.line	236; "demoamprec.c"	sleep_timer=KEY_WAIT;
   020F 00 05         [ 2]  533 	LDA	#0x05
   0211 13 0B         [ 2]  534 	STA	_sleep_timer
                            535 ;	.line	237; "demoamprec.c"	IO=0xff;
   0213 00 FF         [ 2]  536 	LDA	#0xff
   0215 12 02         [ 2]  537 	STA	_IO
   0217 C0            [ 1]  538 	RET	
                            539 
                            540 ;***
                            541 ;  pBlock Stats: dbName = C
                            542 ;***
                            543 ;entry:  _enter_rec_mode:	;Function start
                            544 ; 0 exit points
                            545 ;highest stack level is: 1
                            546 ;functions called:
                            547 ;   _api_amp_rec_start
                            548 ;   _api_amp_rec_stop
                            549 ;; Starting pCode block
   0218                     550 _enter_rec_mode:	;Function start
                            551 ; 0 exit points
                            552 ;	.line	197; "demoamprec.c"	key_code=0;
   0218 CE            [ 1]  553 	CLRA	
   0219 13 07         [ 2]  554 	STA	_key_code
                            555 ;	.line	207; "demoamprec.c"	if(sys_state==SYS_AMP)
   021B 03 05         [ 2]  556 	LDA	_sys_state
   021D 80 02         [ 2]  557 	XOR	#0x02
   021F E4 18         [ 2]  558 	JNZ	_00218_DS_
                            559 ;	.line	209; "demoamprec.c"	api_amp_rec_start(R3_STARTPAGE, R3_ENDPAGE);
   0221 CE            [ 1]  560 	CLRA	
   0222 1C            [ 2]  561 	PUSH	
   0223 00 02         [ 2]  562 	LDA	#0x02
   0225 1C            [ 2]  563 	PUSH	
   0226 00 90         [ 2]  564 	LDA	#0x90
   0228 1C            [ 2]  565 	PUSH	
   0229 CE            [ 1]  566 	CLRA	
   022A 1C            [ 2]  567 	PUSH	
   022B B7 12         [ 3]  568 	CALL	_api_amp_rec_start
                            569 ;	.line	210; "demoamprec.c"	IO&=LED_IO_REC;
   022D 02 02         [ 2]  570 	LDA	_IO
   022F 70 40         [ 2]  571 	AND	#0x40
   0231 12 02         [ 2]  572 	STA	_IO
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 14.



                            573 ;	.line	211; "demoamprec.c"	sys_state=SYS_AMP_REC;
   0233 00 03         [ 2]  574 	LDA	#0x03
   0235 13 05         [ 2]  575 	STA	_sys_state
   0237 F2 51         [ 2]  576 	JMP	_00219_DS_
   0239                     577 _00218_DS_:
                            578 ;	.line	213; "demoamprec.c"	else if(sys_state==SYS_AMP_REC)
   0239 03 05         [ 2]  579 	LDA	_sys_state
   023B 80 03         [ 2]  580 	XOR	#0x03
   023D E4 11         [ 2]  581 	JNZ	_00215_DS_
                            582 ;	.line	215; "demoamprec.c"	IO|=LED_IO_REC;
   023F 02 02         [ 2]  583 	LDA	_IO
   0241 60 40         [ 2]  584 	ORA	#0x40
   0243 12 02         [ 2]  585 	STA	_IO
                            586 ;	.line	216; "demoamprec.c"	api_amp_rec_stop(1);
   0245 00 01         [ 2]  587 	LDA	#0x01
   0247 1C            [ 2]  588 	PUSH	
   0248 B6 E1         [ 3]  589 	CALL	_api_amp_rec_stop
                            590 ;	.line	217; "demoamprec.c"	sys_state=SYS_AMP;
   024A 00 02         [ 2]  591 	LDA	#0x02
   024C 13 05         [ 2]  592 	STA	_sys_state
   024E F2 51         [ 2]  593 	JMP	_00219_DS_
   0250                     594 _00215_DS_:
                            595 ;	.line	219; "demoamprec.c"	return;
   0250 C0            [ 1]  596 	RET	
   0251                     597 _00219_DS_:
                            598 ;	.line	220; "demoamprec.c"	rec_stage=0;
   0251 CE            [ 1]  599 	CLRA	
                            600 ;	.line	221; "demoamprec.c"	rindex=0;
   0252 13 0A         [ 2]  601 	STA	_rec_stage
   0254 13 20         [ 2]  602 	STA	_rindex
   0256 C0            [ 1]  603 	RET	
                            604 
                            605 ;***
                            606 ;  pBlock Stats: dbName = C
                            607 ;***
                            608 ;entry:  _callbackchk:	;Function start
                            609 ; 2 exit points
                            610 ;highest stack level is: 0
                            611 ;has an exit
                            612 ;functions called:
                            613 ;   _api_enter_stdby_mode
                            614 ;   _key_machine
                            615 ;   _timer_routine
                            616 ;; Starting pCode block
   0257                     617 _callbackchk:	;Function start
                            618 ; 2 exit points
                            619 ;	.line	182; "demoamprec.c"	if(!key_state)
   0257 03 04         [ 2]  620 	LDA	_key_state
   0259 E4 0C         [ 2]  621 	JNZ	_00203_DS_
                            622 ;	.line	183; "demoamprec.c"	api_enter_stdby_mode(IO_KEY_ALL,0,1);
   025B 00 01         [ 2]  623 	LDA	#0x01
   025D 1C            [ 2]  624 	PUSH	
   025E CE            [ 1]  625 	CLRA	
   025F 1C            [ 2]  626 	PUSH	
   0260 00 07         [ 2]  627 	LDA	#0x07
   0262 1C            [ 2]  628 	PUSH	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 15.



   0263 B7 4A         [ 3]  629 	CALL	_api_enter_stdby_mode
   0265 F2 6D         [ 2]  630 	JMP	_00204_DS_
   0267                     631 _00203_DS_:
                            632 ;	.line	185; "demoamprec.c"	api_enter_stdby_mode(0,0,0);
   0267 CE            [ 1]  633 	CLRA	
   0268 1C            [ 2]  634 	PUSH	
   0269 1C            [ 2]  635 	PUSH	
   026A 1C            [ 2]  636 	PUSH	
   026B B7 4A         [ 3]  637 	CALL	_api_enter_stdby_mode
   026D                     638 _00204_DS_:
                            639 ;	.line	186; "demoamprec.c"	if(!TOV)
   026D DC            [ 1]  640 	LDC	_TOV
   026E E2 02         [ 2]  641 	JC	_00206_DS_
                            642 ;	.line	187; "demoamprec.c"	key_machine();
   0270 B3 49         [ 3]  643 	CALL	_key_machine
   0272                     644 _00206_DS_:
                            645 ;	.line	188; "demoamprec.c"	timer_routine();
   0272 B3 34         [ 3]  646 	CALL	_timer_routine
                            647 ;	.line	189; "demoamprec.c"	if(key_code)
   0274 03 07         [ 2]  648 	LDA	_key_code
   0276 E6 03         [ 2]  649 	JZ	_00208_DS_
                            650 ;	.line	190; "demoamprec.c"	return 1;
   0278 00 01         [ 2]  651 	LDA	#0x01
   027A C0            [ 1]  652 	RET	
   027B                     653 _00208_DS_:
                            654 ;	.line	191; "demoamprec.c"	return 0;
   027B CE            [ 1]  655 	CLRA	
   027C C0            [ 1]  656 	RET	
                            657 
                            658 ;***
                            659 ;  pBlock Stats: dbName = C
                            660 ;***
                            661 ;entry:  _wait_beep:	;Function start
                            662 ; 0 exit points
                            663 ;highest stack level is: 0
                            664 ;functions called:
                            665 ;   _timer_routine
                            666 ;   _api_enter_stdby_mode
                            667 ;; Starting pCode block
   027D                     668 _wait_beep:	;Function start
                            669 ; 0 exit points
                            670 ;	.line	163; "demoamprec.c"	void wait_beep(BYTE count)
   027D 02 09         [ 2]  671 	LDA	_RAMP1L
   027F 1C            [ 2]  672 	PUSH	
   0280 C8            [ 1]  673 	P02P1	
   0281 01 FE         [ 2]  674 	LDA	@P1,-2
   0283 13 09         [ 2]  675 	STA	_beep_timer
   0285                     676 _00194_DS_:
                            677 ;	.line	166; "demoamprec.c"	while(beep_timer)
   0285 03 09         [ 2]  678 	LDA	_beep_timer
   0287 E6 18         [ 2]  679 	JZ	_00197_DS_
                            680 ;	.line	168; "demoamprec.c"	timer_routine();
   0289 B3 34         [ 3]  681 	CALL	_timer_routine
                            682 ;	.line	169; "demoamprec.c"	if(key_state)
   028B 03 04         [ 2]  683 	LDA	_key_state
   028D E6 08         [ 2]  684 	JZ	_00192_DS_
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 16.



                            685 ;	.line	170; "demoamprec.c"	api_enter_stdby_mode(0 ,0,0); // use tmr wk
   028F CE            [ 1]  686 	CLRA	
   0290 1C            [ 2]  687 	PUSH	
   0291 1C            [ 2]  688 	PUSH	
   0292 1C            [ 2]  689 	PUSH	
   0293 B7 4A         [ 3]  690 	CALL	_api_enter_stdby_mode
   0295 F2 85         [ 2]  691 	JMP	_00194_DS_
   0297                     692 _00192_DS_:
                            693 ;	.line	172; "demoamprec.c"	api_enter_stdby_mode(IO_KEY_ALL,0,0); //use tmr+io wk
   0297 CE            [ 1]  694 	CLRA	
   0298 1C            [ 2]  695 	PUSH	
   0299 1C            [ 2]  696 	PUSH	
   029A 00 07         [ 2]  697 	LDA	#0x07
   029C 1C            [ 2]  698 	PUSH	
   029D B7 4A         [ 3]  699 	CALL	_api_enter_stdby_mode
   029F F2 85         [ 2]  700 	JMP	_00194_DS_
   02A1                     701 _00197_DS_:
   02A1 C4            [ 1]  702 	POP	
   02A2 12 09         [ 2]  703 	STA	_RAMP1L
   02A4 C4            [ 1]  704 	POP	
   02A5 C0            [ 1]  705 	RET	
                            706 
                            707 ;***
                            708 ;  pBlock Stats: dbName = C
                            709 ;***
                            710 ;entry:  _enter_play_mode:	;Function start
                            711 ; 2 exit points
                            712 ;highest stack level is: 2
                            713 ;has an exit
                            714 ;functions called:
                            715 ;   _api_set_vol
                            716 ;   _api_play_start
                            717 ;; Starting pCode block
   02A6                     718 _enter_play_mode:	;Function start
                            719 ; 2 exit points
                            720 ;	.line	141; "demoamprec.c"	BYTE enter_play_mode(BYTE seg)
   02A6 02 09         [ 2]  721 	LDA	_RAMP1L
   02A8 1C            [ 2]  722 	PUSH	
   02A9 C8            [ 1]  723 	P02P1	
   02AA 1C            [ 2]  724 	PUSH	
                            725 ;	.line	143; "demoamprec.c"	BYTE try_play=0;
   02AB CE            [ 1]  726 	CLRA	
   02AC 15            [ 2]  727 	STA	@_RAMP1
                            728 ;	.line	144; "demoamprec.c"	api_set_vol(API_PAGV_DEFAULT,API_PLAYG_DEFAULT);
   02AD 00 78         [ 2]  729 	LDA	#0x78
   02AF 1C            [ 2]  730 	PUSH	
   02B0 00 3F         [ 2]  731 	LDA	#0x3f
   02B2 1C            [ 2]  732 	PUSH	
   02B3 B7 83         [ 3]  733 	CALL	_api_set_vol
                            734 ;	.line	145; "demoamprec.c"	switch(seg)
   02B5 2F            [ 2]  735 	SETB	_C
   02B6 00 02         [ 2]  736 	LDA	#0x02
   02B8 49 FE         [ 2]  737 	SUBB	@P1,-2
   02BA E0 62         [ 2]  738 	JNC	_00174_DS_
   02BC 01 FE         [ 2]  739 	LDA	@P1,-2
   02BE B2 C0         [ 3]  740 	CALL	_00185_DS_
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 17.



   02C0                     741 _00185_DS_:
   02C0 90            [ 1]  742 	SHL	
   02C1 50 CB         [ 2]  743 	ADD	#_00186_DS_
   02C3 12 11         [ 2]  744 	STA	_STACKL
   02C5 CE            [ 1]  745 	CLRA	
   02C6 40 02         [ 2]  746 	ADDC	#>(_00186_DS_)
   02C8 12 12         [ 2]  747 	STA	_STACKH
   02CA C0            [ 1]  748 	RET	
   02CB                     749 _00186_DS_:
   02CB F2 D1         [ 2]  750 	JMP	_00171_DS_
   02CD F2 EB         [ 2]  751 	JMP	_00172_DS_
   02CF F3 06         [ 2]  752 	JMP	_00173_DS_
   02D1                     753 _00171_DS_:
                            754 ;	.line	148; "demoamprec.c"	try_play=API_PSTARTH(P0);
   02D1 00 04         [ 2]  755 	LDA	#0x04
   02D3 1C            [ 2]  756 	PUSH	
   02D4 CE            [ 1]  757 	CLRA	
   02D5 1C            [ 2]  758 	PUSH	
   02D6 00 70         [ 2]  759 	LDA	#0x70
   02D8 1C            [ 2]  760 	PUSH	
   02D9 00 02         [ 2]  761 	LDA	#0x02
   02DB 1C            [ 2]  762 	PUSH	
   02DC 00 1D         [ 2]  763 	LDA	#0x1d
   02DE 1C            [ 2]  764 	PUSH	
   02DF CE            [ 1]  765 	CLRA	
   02E0 1C            [ 2]  766 	PUSH	
   02E1 00 10         [ 2]  767 	LDA	#0x10
   02E3 1C            [ 2]  768 	PUSH	
   02E4 CE            [ 1]  769 	CLRA	
   02E5 1C            [ 2]  770 	PUSH	
   02E6 B8 49         [ 3]  771 	CALL	_api_play_start
   02E8 15            [ 2]  772 	STA	@_RAMP1
                            773 ;	.line	149; "demoamprec.c"	break;
   02E9 F3 1E         [ 2]  774 	JMP	_00174_DS_
   02EB                     775 _00172_DS_:
                            776 ;	.line	151; "demoamprec.c"	try_play=API_PSTARTH(P1);
   02EB 00 04         [ 2]  777 	LDA	#0x04
   02ED 1C            [ 2]  778 	PUSH	
   02EE 00 01         [ 2]  779 	LDA	#0x01
   02F0 1C            [ 2]  780 	PUSH	
   02F1 00 C4         [ 2]  781 	LDA	#0xc4
   02F3 1C            [ 2]  782 	PUSH	
   02F4 00 01         [ 2]  783 	LDA	#0x01
   02F6 1C            [ 2]  784 	PUSH	
   02F7 00 76         [ 2]  785 	LDA	#0x76
   02F9 1C            [ 2]  786 	PUSH	
   02FA CE            [ 1]  787 	CLRA	
   02FB 1C            [ 2]  788 	PUSH	
   02FC 00 1D         [ 2]  789 	LDA	#0x1d
   02FE 1C            [ 2]  790 	PUSH	
   02FF CE            [ 1]  791 	CLRA	
   0300 1C            [ 2]  792 	PUSH	
   0301 B8 49         [ 3]  793 	CALL	_api_play_start
   0303 15            [ 2]  794 	STA	@_RAMP1
                            795 ;	.line	152; "demoamprec.c"	break;
   0304 F3 1E         [ 2]  796 	JMP	_00174_DS_
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 18.



   0306                     797 _00173_DS_:
                            798 ;	.line	154; "demoamprec.c"	try_play= API_PSTARTH(R3);
   0306 00 04         [ 2]  799 	LDA	#0x04
   0308 1C            [ 2]  800 	PUSH	
   0309 CE            [ 1]  801 	CLRA	
   030A 1C            [ 2]  802 	PUSH	
   030B 00 FF         [ 2]  803 	LDA	#0xff
   030D 1C            [ 2]  804 	PUSH	
   030E 00 01         [ 2]  805 	LDA	#0x01
   0310 1C            [ 2]  806 	PUSH	
   0311 CE            [ 1]  807 	CLRA	
   0312 1C            [ 2]  808 	PUSH	
   0313 00 02         [ 2]  809 	LDA	#0x02
   0315 1C            [ 2]  810 	PUSH	
   0316 00 90         [ 2]  811 	LDA	#0x90
   0318 1C            [ 2]  812 	PUSH	
   0319 CE            [ 1]  813 	CLRA	
   031A 1C            [ 2]  814 	PUSH	
   031B B8 49         [ 3]  815 	CALL	_api_play_start
   031D 15            [ 2]  816 	STA	@_RAMP1
   031E                     817 _00174_DS_:
                            818 ;	.line	158; "demoamprec.c"	if(try_play)
   031E 05            [ 2]  819 	LDA	@_RAMP1
   031F E6 04         [ 2]  820 	JZ	_00176_DS_
                            821 ;	.line	159; "demoamprec.c"	sys_state=SYS_PLAY;
   0321 00 01         [ 2]  822 	LDA	#0x01
   0323 13 05         [ 2]  823 	STA	_sys_state
   0325                     824 _00176_DS_:
                            825 ;	.line	160; "demoamprec.c"	playing_seg=seg;
   0325 01 FE         [ 2]  826 	LDA	@P1,-2
   0327 13 2D         [ 2]  827 	STA	_playing_seg
                            828 ;	.line	161; "demoamprec.c"	return try_play; // return the result
   0329 05            [ 2]  829 	LDA	@_RAMP1
   032A 12 0B         [ 2]  830 	STA	_PTRCL
   032C C4            [ 1]  831 	POP	
   032D C4            [ 1]  832 	POP	
   032E 12 09         [ 2]  833 	STA	_RAMP1L
   0330 C4            [ 1]  834 	POP	
   0331 02 0B         [ 2]  835 	LDA	_PTRCL
   0333 C0            [ 1]  836 	RET	
                            837 ;; end of function enter_play_mode
                            838 ; exit point of _enter_play_mode
                            839 
                            840 ;***
                            841 ;  pBlock Stats: dbName = C
                            842 ;***
                            843 ;entry:  _timer_routine:	;Function start
                            844 ; 0 exit points
                            845 ;highest stack level is: 1
                            846 ;functions called:
                            847 ;   _key_machine
                            848 ;; Starting pCode block
   0334                     849 _timer_routine:	;Function start
                            850 ; 0 exit points
                            851 ;	.line	129; "demoamprec.c"	if(!TOV)
   0334 DC            [ 1]  852 	LDC	_TOV
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 19.



                            853 ;	.line	130; "demoamprec.c"	return ;
   0335 E0 11         [ 2]  854 	JNC	_00166_DS_
                            855 ;	.line	131; "demoamprec.c"	TOV=0;
   0337 3C            [ 2]  856 	CLRB	_TOV
                            857 ;	.line	132; "demoamprec.c"	if(sleep_timer)
   0338 03 0B         [ 2]  858 	LDA	_sleep_timer
                            859 ;	.line	133; "demoamprec.c"	sleep_timer--;
   033A E6 03         [ 2]  860 	JZ	_00163_DS_
   033C CD            [ 1]  861 	DECA	
   033D 13 0B         [ 2]  862 	STA	_sleep_timer
   033F                     863 _00163_DS_:
                            864 ;	.line	134; "demoamprec.c"	if(beep_timer)
   033F 03 09         [ 2]  865 	LDA	_beep_timer
                            866 ;	.line	135; "demoamprec.c"	beep_timer--;
   0341 E6 03         [ 2]  867 	JZ	_00165_DS_
   0343 CD            [ 1]  868 	DECA	
   0344 13 09         [ 2]  869 	STA	_beep_timer
   0346                     870 _00165_DS_:
                            871 ;	.line	137; "demoamprec.c"	key_machine();
   0346 B3 49         [ 3]  872 	CALL	_key_machine
   0348                     873 _00166_DS_:
   0348 C0            [ 1]  874 	RET	
                            875 
                            876 ;***
                            877 ;  pBlock Stats: dbName = C
                            878 ;***
                            879 ;entry:  _key_machine:	;Function start
                            880 ; 0 exit points
                            881 ;highest stack level is: 2
                            882 ;functions called:
                            883 ;   _get_key
                            884 ;; Starting pCode block
   0349                     885 _key_machine:	;Function start
                            886 ; 0 exit points
                            887 ;	.line	93; "demoamprec.c"	void key_machine(void)
   0349 02 09         [ 2]  888 	LDA	_RAMP1L
   034B 1C            [ 2]  889 	PUSH	
   034C C8            [ 1]  890 	P02P1	
   034D 1C            [ 2]  891 	PUSH	
                            892 ;	.line	96; "demoamprec.c"	k=get_key();
   034E B3 C1         [ 3]  893 	CALL	_get_key
   0350 15            [ 2]  894 	STA	@_RAMP1
                            895 ;	.line	97; "demoamprec.c"	switch(key_state)
   0351 2F            [ 2]  896 	SETB	_C
   0352 00 02         [ 2]  897 	LDA	#0x02
   0354 4B 04         [ 2]  898 	SUBB	_key_state
   0356 E0 49         [ 2]  899 	JNC	_00133_DS_
   0358 03 04         [ 2]  900 	LDA	_key_state
   035A B3 5C         [ 3]  901 	CALL	_00153_DS_
   035C                     902 _00153_DS_:
   035C 90            [ 1]  903 	SHL	
   035D 50 67         [ 2]  904 	ADD	#_00154_DS_
   035F 12 11         [ 2]  905 	STA	_STACKL
   0361 CE            [ 1]  906 	CLRA	
   0362 40 03         [ 2]  907 	ADDC	#>(_00154_DS_)
   0364 12 12         [ 2]  908 	STA	_STACKH
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 20.



   0366 C0            [ 1]  909 	RET	
   0367                     910 _00154_DS_:
   0367 F3 6D         [ 2]  911 	JMP	_00120_DS_
   0369 F3 80         [ 2]  912 	JMP	_00124_DS_
   036B F3 9B         [ 2]  913 	JMP	_00129_DS_
   036D                     914 _00120_DS_:
                            915 ;	.line	100; "demoamprec.c"	if(!key_code && k)
   036D 03 07         [ 2]  916 	LDA	_key_code
   036F E4 30         [ 2]  917 	JNZ	_00133_DS_
                            918 ;	.line	102; "demoamprec.c"	last_stroke=k;
   0371 05            [ 2]  919 	LDA	@_RAMP1
   0372 E6 2D         [ 2]  920 	JZ	_00133_DS_
   0374 13 06         [ 2]  921 	STA	_last_stroke
                            922 ;	.line	103; "demoamprec.c"	key_state=KEYS_DEB;
   0376 00 01         [ 2]  923 	LDA	#0x01
   0378 13 04         [ 2]  924 	STA	_key_state
                            925 ;	.line	104; "demoamprec.c"	key_timer=KEY_WAIT;
   037A 00 05         [ 2]  926 	LDA	#0x05
   037C 13 08         [ 2]  927 	STA	_key_timer
                            928 ;	.line	106; "demoamprec.c"	break;
   037E F3 A1         [ 2]  929 	JMP	_00133_DS_
   0380                     930 _00124_DS_:
                            931 ;	.line	108; "demoamprec.c"	if(k!=last_stroke)
   0380 03 06         [ 2]  932 	LDA	_last_stroke
   0382 85            [ 2]  933 	XOR	@_RAMP1
                            934 ;	.line	110; "demoamprec.c"	key_state=KEYS_NOKEY;
   0383 E6 05         [ 2]  935 	JZ	_00126_DS_
   0385 CE            [ 1]  936 	CLRA	
   0386 13 04         [ 2]  937 	STA	_key_state
                            938 ;	.line	111; "demoamprec.c"	break;
   0388 F3 A1         [ 2]  939 	JMP	_00133_DS_
   038A                     940 _00126_DS_:
                            941 ;	.line	113; "demoamprec.c"	if(!--key_timer)
   038A 03 08         [ 2]  942 	LDA	_key_timer
   038C CD            [ 1]  943 	DECA	
   038D 13 08         [ 2]  944 	STA	_key_timer
   038F E4 10         [ 2]  945 	JNZ	_00133_DS_
                            946 ;	.line	115; "demoamprec.c"	key_code=last_stroke;
   0391 03 06         [ 2]  947 	LDA	_last_stroke
   0393 13 07         [ 2]  948 	STA	_key_code
                            949 ;	.line	116; "demoamprec.c"	key_state=KEYS_WAITRELEASE;
   0395 00 02         [ 2]  950 	LDA	#0x02
   0397 13 04         [ 2]  951 	STA	_key_state
                            952 ;	.line	118; "demoamprec.c"	break;
   0399 F3 A1         [ 2]  953 	JMP	_00133_DS_
   039B                     954 _00129_DS_:
                            955 ;	.line	120; "demoamprec.c"	if(!k)
   039B 05            [ 2]  956 	LDA	@_RAMP1
   039C E4 03         [ 2]  957 	JNZ	_00133_DS_
                            958 ;	.line	121; "demoamprec.c"	key_state=KEYS_NOKEY;
   039E CE            [ 1]  959 	CLRA	
   039F 13 04         [ 2]  960 	STA	_key_state
   03A1                     961 _00133_DS_:
                            962 ;	.line	124; "demoamprec.c"	};
   03A1 C4            [ 1]  963 	POP	
   03A2 C4            [ 1]  964 	POP	
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 21.



   03A3 12 09         [ 2]  965 	STA	_RAMP1L
   03A5 C0            [ 1]  966 	RET	
                            967 
                            968 ;***
                            969 ;  pBlock Stats: dbName = C
                            970 ;***
                            971 ;entry:  _init:	;Function start
                            972 ; 0 exit points
                            973 ;highest stack level is: 1
                            974 ;functions called:
                            975 ;   _api_timer_on
                            976 ;; Starting pCode block
   03A6                     977 _init:	;Function start
                            978 ; 0 exit points
                            979 ;	.line	84; "demoamprec.c"	IODIR=0xc0;
   03A6 00 C0         [ 2]  980 	LDA	#0xc0
   03A8 12 01         [ 2]  981 	STA	_IODIR
                            982 ;	.line	85; "demoamprec.c"	IO=0xFF; // all high
   03AA 00 FF         [ 2]  983 	LDA	#0xff
   03AC 12 02         [ 2]  984 	STA	_IO
                            985 ;	.line	86; "demoamprec.c"	IOWK=0; // deep sleep mode no use wk
   03AE CE            [ 1]  986 	CLRA	
   03AF 12 03         [ 2]  987 	STA	_IOWK
                            988 ;	.line	87; "demoamprec.c"	sleep_timer=KEY_WAIT;
   03B1 00 05         [ 2]  989 	LDA	#0x05
   03B3 13 0B         [ 2]  990 	STA	_sleep_timer
                            991 ;	.line	88; "demoamprec.c"	new_end_page=R3_ENDPAGE;
   03B5 CE            [ 1]  992 	CLRA	
   03B6 13 28         [ 2]  993 	STA	_new_end_page
   03B8 00 02         [ 2]  994 	LDA	#0x02
   03BA 13 29         [ 2]  995 	STA	(_new_end_page + 1)
                            996 ;	.line	90; "demoamprec.c"	api_timer_on(TMR_RLD);
   03BC 00 E0         [ 2]  997 	LDA	#0xe0
   03BE 1C            [ 2]  998 	PUSH	
   03BF F6 D0         [ 2]  999 	JMP	_api_timer_on
                           1000 
                           1001 ;***
                           1002 ;  pBlock Stats: dbName = C
                           1003 ;***
                           1004 ;entry:  _get_key:	;Function start
                           1005 ; 2 exit points
                           1006 ;highest stack level is: 3
                           1007 ;has an exit
                           1008 ;; Starting pCode block
   03C1                    1009 _get_key:	;Function start
                           1010 ; 2 exit points
                           1011 ;	.line	72; "demoamprec.c"	if(!(IO&IO_PLAY))
   03C1 00 02         [ 2] 1012 	LDA	#0x02
   03C3 72 02         [ 2] 1013 	AND	_IO
   03C5 E4 03         [ 2] 1014 	JNZ	_00106_DS_
                           1015 ;	.line	73; "demoamprec.c"	return KEY_CODE_PLAY;
   03C7 00 01         [ 2] 1016 	LDA	#0x01
   03C9 C0            [ 1] 1017 	RET	
   03CA                    1018 _00106_DS_:
                           1019 ;	.line	74; "demoamprec.c"	if(!(IO&IO_AMP))
   03CA 00 04         [ 2] 1020 	LDA	#0x04
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 22.



   03CC 72 02         [ 2] 1021 	AND	_IO
   03CE E4 03         [ 2] 1022 	JNZ	_00108_DS_
                           1023 ;	.line	75; "demoamprec.c"	return KEY_CODE_AMP;
   03D0 00 03         [ 2] 1024 	LDA	#0x03
   03D2 C0            [ 1] 1025 	RET	
   03D3                    1026 _00108_DS_:
                           1027 ;	.line	76; "demoamprec.c"	if(!(IO&IO_REC))
   03D3 02 02         [ 2] 1028 	LDA	_IO
   03D5 92            [ 1] 1029 	SHR	
   03D6 E2 03         [ 2] 1030 	JC	_00110_DS_
                           1031 ;	.line	77; "demoamprec.c"	return KEY_CODE_REC;
   03D8 00 02         [ 2] 1032 	LDA	#0x02
   03DA C0            [ 1] 1033 	RET	
   03DB                    1034 _00110_DS_:
                           1035 ;	.line	78; "demoamprec.c"	return 0;
   03DB CE            [ 1] 1036 	CLRA	
   03DC C0            [ 1] 1037 	RET	
                           1038 
                           1039 
                           1040 ;	code size estimation:
                           1041 ;	  598+  389 =   987 instructions (  987 byte)
                           1042 
                           1043 ;--------------------------------------------------------
                           1044 ; compiler-defined variables
                           1045 ;--------------------------------------------------------
                           1046 ;--------------------------------------------------------
                           1047 ; initialized data - shadow
                           1048 ;--------------------------------------------------------
                           1049 ;--------------------------------------------------------
                           1050 ; initialized data
                           1051 ;--------------------------------------------------------
                           1052 	.globl __PARA_STK
                           1053 	.area SSEG (DATA,OVR)
   8039                    1054 __PARA_STK:	.ds 1
                           1055 ;--------------------------------------------------------
                           1056 ; external declarations
                           1057 ;--------------------------------------------------------
                           1058 	.globl	_api_rec_job
                           1059 	.globl	_api_set_vol
                           1060 	.globl	_api_play_start
                           1061 	.globl	_api_play_job
                           1062 	.globl	_api_play_stop
                           1063 	.globl	_api_timer_on
                           1064 	.globl	_api_enter_stdby_mode
                           1065 	.globl	_api_enter_dsleep_mode
                           1066 	.globl	_api_amp_prepare
                           1067 	.globl	_api_amp_start
                           1068 	.globl	_api_amp_stop
                           1069 	.globl	_api_amp_rec_start
                           1070 	.globl	_api_amp_rec_stop
                           1071 	.globl	_IOR
                           1072 	.globl	_IODIR
                           1073 	.globl	_IO
                           1074 	.globl	_IOWK
                           1075 	.globl	_IOWKDR
                           1076 	.globl	_TIMERC
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 23.



                           1077 	.globl	_THRLD
                           1078 	.globl	_RAMP0L
                           1079 	.globl	_RAMP0H
                           1080 	.globl	_RAMP1L
                           1081 	.globl	_RAMP1H
                           1082 	.globl	_PTRCL
                           1083 	.globl	_PTRCH
                           1084 	.globl	_ROMPL
                           1085 	.globl	_ROMPH
                           1086 	.globl	_BEEPC
                           1087 	.globl	_FILTERG
                           1088 	.globl	_ULAWC
                           1089 	.globl	_STACKL
                           1090 	.globl	_STACKH
                           1091 	.globl	_ADCON
                           1092 	.globl	_DACON
                           1093 	.globl	_SYSC
                           1094 	.globl	_SPIM
                           1095 	.globl	_SPIH
                           1096 	.globl	_SPIOP
                           1097 	.globl	_SPI_BANK
                           1098 	.globl	_ADP_IND
                           1099 	.globl	_ADP_VPL
                           1100 	.globl	_ADP_VPH
                           1101 	.globl	_ADL
                           1102 	.globl	_ADH
                           1103 	.globl	_ZC
                           1104 	.globl	_ADCG
                           1105 	.globl	_DAC_PL
                           1106 	.globl	_DAC_PH
                           1107 	.globl	_PAG
                           1108 	.globl	_DMAL
                           1109 	.globl	_DMAH
                           1110 	.globl	_SPIL
                           1111 	.globl	_IOMASK
                           1112 	.globl	_IOCMP
                           1113 	.globl	_IOCNT
                           1114 	.globl	_LVDCON
                           1115 	.globl	_LVRCON
                           1116 	.globl	_OFFSETL
                           1117 	.globl	_OFFSETH
                           1118 	.globl	_RCCON
                           1119 	.globl	_BGCON
                           1120 	.globl	_PWRL
                           1121 	.globl	_CRYPT
                           1122 	.globl	_PWRH
                           1123 	.globl	_PWRHL
                           1124 	.globl	_IROMDL
                           1125 	.globl	_IROMDH
                           1126 	.globl	_IROMDLH
                           1127 	.globl	_RECMUTE
                           1128 	.globl	_SPKC
                           1129 	.globl	_DCLAMP
                           1130 	.globl	_SSPIC
                           1131 	.globl	_SSPIL
                           1132 	.globl	_SSPIM
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 24.



                           1133 	.globl	_SSPIH
                           1134 	.globl	_RAMP0
                           1135 	.globl	_RAMP0LH
                           1136 	.globl	_RAMP1LH
                           1137 	.globl	_RAMP0INC
                           1138 	.globl	_RAMP1
                           1139 	.globl	_DMAHL
                           1140 	.globl	_RAMP1INC
                           1141 	.globl	_RAMP1INC2
                           1142 	.globl	_ROMP
                           1143 	.globl	_ROMPINC
                           1144 	.globl	_ROMPLH
                           1145 	.globl	_ROMPINC2
                           1146 	.globl	_ACC
                           1147 	.globl	_RAMP0UW
                           1148 	.globl	_RAMP1UW
                           1149 	.globl	_ROMPUW
                           1150 	.globl	_SPIMH
                           1151 	.globl	_OFFSETLH
                           1152 	.globl	_ADP_VPLH
                           1153 	.globl	_ICE0
                           1154 	.globl	_ICE1
                           1155 	.globl	_ICE2
                           1156 	.globl	_ICE3
                           1157 	.globl	_ICE4
                           1158 	.globl	_TOV
                           1159 	.globl	_init_io_state
                           1160 ;--------------------------------------------------------
                           1161 ; global -1 declarations
                           1162 ;--------------------------------------------------------
                           1163 	.globl	_get_key
                           1164 	.globl	_init
                           1165 	.globl	_key_machine
                           1166 	.globl	_timer_routine
                           1167 	.globl	_enter_play_mode
                           1168 	.globl	_wait_beep
                           1169 	.globl	_callbackchk
                           1170 	.globl	_enter_rec_mode
                           1171 	.globl	_enter_idle_mode
                           1172 	.globl	_sys_play
                           1173 	.globl	_simple_speech_check
                           1174 	.globl	_enter_amp_mode
                           1175 	.globl	_sys_amp
                           1176 	.globl	_main
                           1177 	.globl	_key_state
                           1178 	.globl	_sys_state
                           1179 	.globl	_last_stroke
                           1180 	.globl	_key_code
                           1181 	.globl	_key_timer
                           1182 	.globl	_beep_timer
                           1183 	.globl	_rec_stage
                           1184 	.globl	_sleep_timer
                           1185 	.globl	_oldindex
                           1186 	.globl	_oldpredict
                           1187 	.globl	_oldpwr
                           1188 	.globl	_rindex
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 25.



                           1189 	.globl	_newpwr
                           1190 	.globl	_pwravg
                           1191 	.globl	_the_pred
                           1192 	.globl	_the_index
                           1193 	.globl	_new_end_page
                           1194 	.globl	_the_state
                           1195 	.globl	_playing_seg
                           1196 	.globl	__sp_inc
                           1197 	.globl	__sp_dec
                           1198 
                           1199 	.globl STK02
                           1200 	.globl STK01
                           1201 	.globl STK00
                           1202 	.globl _init_io_state
                           1203 	 .area sharebank (DATA,OVR)
   8000                    1204 _init_io_state:	.ds 1
   8001                    1205 STK02:	.ds 1
   8002                    1206 STK01:	.ds 1
   8003                    1207 STK00:	.ds 1
                           1208 
                           1209 ;--------------------------------------------------------
                           1210 ; global -2 definitions
                           1211 ;--------------------------------------------------------
                           1212 	.area DSEG(data)
   8004                    1213 _key_state:	.ds	1
                           1214 
                           1215 	.area DSEG(data)
   8005                    1216 _sys_state:	.ds	1
                           1217 
                           1218 	.area DSEG(data)
   8006                    1219 _last_stroke:	.ds	1
                           1220 
                           1221 	.area DSEG(data)
   8007                    1222 _key_code:	.ds	1
                           1223 
                           1224 	.area DSEG(data)
   8008                    1225 _key_timer:	.ds	1
                           1226 
                           1227 	.area DSEG(data)
   8009                    1228 _beep_timer:	.ds	1
                           1229 
                           1230 	.area DSEG(data)
   800A                    1231 _rec_stage:	.ds	1
                           1232 
                           1233 	.area DSEG(data)
   800B                    1234 _sleep_timer:	.ds	1
                           1235 
                           1236 	.area DSEG(data)
   800C                    1237 _oldindex:	.ds	4
                           1238 
                           1239 	.area DSEG(data)
   8010                    1240 _oldpredict:	.ds	8
                           1241 
                           1242 	.area DSEG(data)
   8018                    1243 _oldpwr:	.ds	8
                           1244 
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (MS311 Series), page 26.



                           1245 	.area DSEG(data)
   8020                    1246 _rindex:	.ds	1
                           1247 
                           1248 	.area DSEG(data)
   8021                    1249 _newpwr:	.ds	2
                           1250 
                           1251 	.area DSEG(data)
   8023                    1252 _pwravg:	.ds	2
                           1253 
                           1254 	.area DSEG(data)
   8025                    1255 _the_pred:	.ds	2
                           1256 
                           1257 	.area DSEG(data)
   8027                    1258 _the_index:	.ds	1
                           1259 
                           1260 	.area DSEG(data)
   8028                    1261 _new_end_page:	.ds	2
                           1262 
                           1263 	.area DSEG(data)
   802A                    1264 _the_state:	.ds	3
                           1265 
                           1266 	.area DSEG(data)
   802D                    1267 _playing_seg:	.ds	1
                           1268 
                           1269 ;--------------------------------------------------------
                           1270 ; absolute symbol definitions
                           1271 ;--------------------------------------------------------
                           1272 	;end
