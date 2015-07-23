
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,54 :: 		begin
;12f675-PwmFet.mpas,55 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,57 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,58 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,59 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,60 :: 		TMR0:=ON_PWM
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,61 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,62 :: 		TMR0:=PWM_MAX-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,63 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,64 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,65 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,66 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,67 :: 		TMR0:=ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,68 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,69 :: 		PWM_SYNC:=1;
	BSF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,70 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,71 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,72 :: 		end;
L__Interrupt2:
;12f675-PwmFet.mpas,73 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,74 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,75 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,76 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,77 :: 		if TICK_1000>LED1_Tm then begin
	MOVF       _TICK_1000+0, 0
	SUBWF      _LED1_tm+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__Interrupt14
;12f675-PwmFet.mpas,78 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP2_bit+0, 1
;12f675-PwmFet.mpas,79 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,80 :: 		end;
L__Interrupt14:
;12f675-PwmFet.mpas,81 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,82 :: 		end;
L__Interrupt11:
;12f675-PwmFet.mpas,83 :: 		if GPIF_bit=1 then begin
	BTFSS      GPIF_bit+0, BitPos(GPIF_bit+0)
	GOTO       L__Interrupt17
;12f675-PwmFet.mpas,84 :: 		if VOut5=0 then
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__Interrupt20
;12f675-PwmFet.mpas,85 :: 		vTarget:=c051
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
	GOTO       L__Interrupt21
;12f675-PwmFet.mpas,86 :: 		else
L__Interrupt20:
;12f675-PwmFet.mpas,87 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
L__Interrupt21:
;12f675-PwmFet.mpas,88 :: 		GPIF_bit:=0;
	BCF        GPIF_bit+0, BitPos(GPIF_bit+0)
;12f675-PwmFet.mpas,89 :: 		end;
L__Interrupt17:
;12f675-PwmFet.mpas,90 :: 		end;
L_end_Interrupt:
L__Interrupt71:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Delay1ms:

;12f675-PwmFet.mpas,95 :: 		begin
;12f675-PwmFet.mpas,96 :: 		if limit>0 then begin
	MOVF       FARG_Delay1ms_limit+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__Delay1ms24
;12f675-PwmFet.mpas,97 :: 		ts:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      R2+0
;12f675-PwmFet.mpas,98 :: 		if t<=ts then
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      _TICK_1000+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__Delay1ms27
;12f675-PwmFet.mpas,99 :: 		ts:=ts-t
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R2+0, 1
	GOTO       L__Delay1ms28
;12f675-PwmFet.mpas,100 :: 		else
L__Delay1ms27:
;12f675-PwmFet.mpas,101 :: 		ts:=255-t+1+ts;
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBLW      255
	MOVWF      R0+0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 1
L__Delay1ms28:
;12f675-PwmFet.mpas,102 :: 		Result:=ts>=limit;
	MOVF       FARG_Delay1ms_limit+0, 0
	SUBWF      R2+0, 0
	MOVLW      255
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
;12f675-PwmFet.mpas,103 :: 		end else
	GOTO       L__Delay1ms25
L__Delay1ms24:
;12f675-PwmFet.mpas,104 :: 		Result:=True;
	MOVLW      255
	MOVWF      R1+0
L__Delay1ms25:
;12f675-PwmFet.mpas,105 :: 		if Result then
	MOVF       R1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__Delay1ms30
;12f675-PwmFet.mpas,106 :: 		t:=TICK_1000;
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       _TICK_1000+0, 0
	MOVWF      INDF+0
L__Delay1ms30:
;12f675-PwmFet.mpas,107 :: 		end;
	MOVF       R1+0, 0
	MOVWF      R0+0
L_end_Delay1ms:
	RETURN
; end of _Delay1ms

_ADC_Read4:

;12f675-PwmFet.mpas,110 :: 		begin
;12f675-PwmFet.mpas,111 :: 		ADFM_bit:=0;
	BCF        ADFM_bit+0, BitPos(ADFM_bit+0)
;12f675-PwmFet.mpas,112 :: 		CHS1_bit:=channel.B1;
	BTFSC      FARG_ADC_Read4_channel+0, 1
	GOTO       L__ADC_Read474
	BCF        CHS1_bit+0, BitPos(CHS1_bit+0)
	GOTO       L__ADC_Read475
L__ADC_Read474:
	BSF        CHS1_bit+0, BitPos(CHS1_bit+0)
L__ADC_Read475:
;12f675-PwmFet.mpas,113 :: 		CHS0_bit:=channel.B0;
	BTFSC      FARG_ADC_Read4_channel+0, 0
	GOTO       L__ADC_Read476
	BCF        CHS0_bit+0, BitPos(CHS0_bit+0)
	GOTO       L__ADC_Read477
L__ADC_Read476:
	BSF        CHS0_bit+0, BitPos(CHS0_bit+0)
L__ADC_Read477:
;12f675-PwmFet.mpas,114 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,115 :: 		Delay_22us;
	CALL       _Delay_22us+0
;12f675-PwmFet.mpas,116 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,117 :: 		while GO_NOT_DONE_bit=1 do ;
L__ADC_Read434:
	BTFSC      GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
	GOTO       L__ADC_Read434
;12f675-PwmFet.mpas,118 :: 		ADON_bit:=0;
	BCF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,119 :: 		Result:=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      ADC_Read4_local_result+0
;12f675-PwmFet.mpas,120 :: 		end;
	MOVF       ADC_Read4_local_result+0, 0
	MOVWF      R0+0
L_end_ADC_Read4:
	RETURN
; end of _ADC_Read4

_main:

;12f675-PwmFet.mpas,122 :: 		begin
;12f675-PwmFet.mpas,123 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,124 :: 		ANSEL:=%00000010;
	MOVLW      2
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,125 :: 		ADCON0:=%10000101;            // ADC config
	MOVLW      133
	MOVWF      ADCON0+0
;12f675-PwmFet.mpas,127 :: 		TRISIO0_bit:=0;
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,128 :: 		TRISIO1_bit:=1;
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,129 :: 		TRISIO2_bit:=0;
	BCF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,130 :: 		TRISIO5_bit:=0;  // PWM_SYNC
	BCF        TRISIO5_bit+0, BitPos(TRISIO5_bit+0)
;12f675-PwmFet.mpas,131 :: 		LED1:=0;
	BCF        GP2_bit+0, BitPos(GP2_bit+0)
;12f675-PwmFet.mpas,132 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,133 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,134 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,135 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,136 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,137 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,139 :: 		OPTION_REG:=%01010000;        // ~2KHz @ 4MHz, enable weak pull-up
	MOVLW      80
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,140 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,142 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,144 :: 		T1CKPS1_bit:=1;               // timer prescaler 1:4
	BSF        T1CKPS1_bit+0, BitPos(T1CKPS1_bit+0)
;12f675-PwmFet.mpas,145 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,146 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,147 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,148 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,150 :: 		IOC3_bit:=1;
	BSF        IOC3_bit+0, BitPos(IOC3_bit+0)
;12f675-PwmFet.mpas,151 :: 		GPIE_bit:=1;
	BSF        GPIE_bit+0, BitPos(GPIE_bit+0)
;12f675-PwmFet.mpas,153 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;12f675-PwmFet.mpas,155 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,157 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,158 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,160 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,162 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,164 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main40
;12f675-PwmFet.mpas,165 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,166 :: 		end else begin
	GOTO       L__main41
L__main40:
;12f675-PwmFet.mpas,167 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,168 :: 		end;
L__main41:
;12f675-PwmFet.mpas,170 :: 		while True do begin
L__main43:
;12f675-PwmFet.mpas,171 :: 		while GO_NOT_DONE_bit=1 do ;
L__main48:
	BTFSC      GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
	GOTO       L__main48
;12f675-PwmFet.mpas,172 :: 		Hi(adc_vol):=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,173 :: 		Lo(adc_vol):=ADRESL;
	MOVF       ADRESL+0, 0
	MOVWF      _adc_vol+0
;12f675-PwmFet.mpas,174 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,175 :: 		if adc_vol<vTarget then begin
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main79
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main79:
	BTFSC      STATUS+0, 0
	GOTO       L__main53
;12f675-PwmFet.mpas,176 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main56
;12f675-PwmFet.mpas,177 :: 		Inc(VOL_PWM);
	INCF       _VOL_PWM+0, 1
L__main56:
;12f675-PwmFet.mpas,178 :: 		end else if adc_vol>vTarget then begin
	GOTO       L__main54
L__main53:
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main80:
	BTFSC      STATUS+0, 0
	GOTO       L__main59
;12f675-PwmFet.mpas,179 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main62
;12f675-PwmFet.mpas,180 :: 		Dec(VOL_PWM);
	DECF       _VOL_PWM+0, 1
L__main62:
;12f675-PwmFet.mpas,181 :: 		end;
L__main59:
L__main54:
;12f675-PwmFet.mpas,182 :: 		if (Hi(adc_vol)=0) and (Lo(adc_vol)<=cLow) then
	MOVF       _adc_vol+1, 0
	XORLW      0
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVF       _adc_vol+0, 0
	SUBLW      17
	MOVLW      255
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main65
;12f675-PwmFet.mpas,183 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main66
;12f675-PwmFet.mpas,184 :: 		else if VOL_PWM=PWM_MAX then
L__main65:
	MOVF       _VOL_PWM+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main68
;12f675-PwmFet.mpas,185 :: 		LED1_tm:=128
	MOVLW      128
	MOVWF      _LED1_tm+0
	GOTO       L__main69
;12f675-PwmFet.mpas,186 :: 		else
L__main68:
;12f675-PwmFet.mpas,187 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
L__main69:
L__main66:
;12f675-PwmFet.mpas,188 :: 		end;
	GOTO       L__main43
;12f675-PwmFet.mpas,189 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
