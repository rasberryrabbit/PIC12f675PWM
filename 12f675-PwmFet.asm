
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,66 :: 		begin
;12f675-PwmFet.mpas,67 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,69 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,70 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,71 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,72 :: 		TMR0:=255-PWM_MAX
	MOVLW      68
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,73 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,74 :: 		TMR0:=255-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,78 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,79 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,80 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,81 :: 		TMR0:=255-PWM_MAX+ON_PWM;
	MOVF       _ON_PWM+0, 0
	ADDLW      68
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,89 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,93 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,94 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,95 :: 		end else
	GOTO       L__Interrupt3
L__Interrupt2:
;12f675-PwmFet.mpas,96 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,97 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,98 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,99 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,100 :: 		if TICK_1000>LED1_Tm then begin
	MOVF       _TICK_1000+0, 0
	SUBWF      _LED1_tm+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__Interrupt14
;12f675-PwmFet.mpas,101 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP4_bit+0, 1
;12f675-PwmFet.mpas,102 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,103 :: 		end;
L__Interrupt14:
;12f675-PwmFet.mpas,115 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,116 :: 		end;
L__Interrupt11:
L__Interrupt3:
;12f675-PwmFet.mpas,117 :: 		if GPIF_bit=1 then begin
	BTFSS      GPIF_bit+0, BitPos(GPIF_bit+0)
	GOTO       L__Interrupt17
;12f675-PwmFet.mpas,118 :: 		if VOut5=0 then
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__Interrupt20
;12f675-PwmFet.mpas,119 :: 		vTarget:=c051
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
	GOTO       L__Interrupt21
;12f675-PwmFet.mpas,120 :: 		else
L__Interrupt20:
;12f675-PwmFet.mpas,121 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
L__Interrupt21:
;12f675-PwmFet.mpas,122 :: 		GPIF_bit:=0;
	BCF        GPIF_bit+0, BitPos(GPIF_bit+0)
;12f675-PwmFet.mpas,123 :: 		end;
L__Interrupt17:
;12f675-PwmFet.mpas,124 :: 		end;
L_end_Interrupt:
L__Interrupt72:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Read_ADC:

;12f675-PwmFet.mpas,127 :: 		begin
;12f675-PwmFet.mpas,128 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,129 :: 		while GO_NOT_DONE_bit=1 do ;
L__Read_ADC24:
	BTFSC      GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
	GOTO       L__Read_ADC24
;12f675-PwmFet.mpas,130 :: 		Hi(adc_vol):=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,131 :: 		Lo(adc_vol):=ADRESL;
	MOVF       ADRESL+0, 0
	MOVWF      _adc_vol+0
;12f675-PwmFet.mpas,132 :: 		end;
L_end_Read_ADC:
	RETURN
; end of _Read_ADC

_main:

;12f675-PwmFet.mpas,134 :: 		begin
;12f675-PwmFet.mpas,138 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,139 :: 		ANSEL:={$ifndef USE_OLD_SCH}%00010100{$else}%00010010{$endif};    // 2us tAD, channel 2
	MOVLW      20
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,141 :: 		TRISIO0_bit:=0;      // PWM
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,142 :: 		TRISIO1_bit:=1;      // VREF or ADC
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,144 :: 		TRISIO2_bit:=1;      // ADC
	BSF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,145 :: 		TRISIO4_bit:=0;      // LED
	BCF        TRISIO4_bit+0, BitPos(TRISIO4_bit+0)
;12f675-PwmFet.mpas,152 :: 		LED1:=0;
	BCF        GP4_bit+0, BitPos(GP4_bit+0)
;12f675-PwmFet.mpas,153 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,157 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,158 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,159 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,160 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,165 :: 		OPTION_REG:=%01010000;        // ~2KHz @ 4MHz, enable weak pull-up
	MOVLW      80
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,166 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,168 :: 		ADCON0:={$ifndef USE_OLD_SCH}%11001001{$else}%10000101{$endif};            // Right Justfied, VREF, Channel 2
	MOVLW      201
	MOVWF      ADCON0+0
;12f675-PwmFet.mpas,170 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,172 :: 		T1CKPS0_bit:=1;               // timer prescaler 1:2
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;12f675-PwmFet.mpas,173 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,174 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,175 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,176 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,178 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;12f675-PwmFet.mpas,180 :: 		IOC3_bit:=1;
	BSF        IOC3_bit+0, BitPos(IOC3_bit+0)
;12f675-PwmFet.mpas,181 :: 		GPIE_bit:=1;
	BSF        GPIE_bit+0, BitPos(GPIE_bit+0)
;12f675-PwmFet.mpas,183 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,185 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,186 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,188 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,190 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,192 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main30
;12f675-PwmFet.mpas,193 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,194 :: 		end else begin
	GOTO       L__main31
L__main30:
;12f675-PwmFet.mpas,195 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,196 :: 		end;
L__main31:
;12f675-PwmFet.mpas,199 :: 		while True do begin
L__main33:
;12f675-PwmFet.mpas,201 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,202 :: 		if (adc_vol>vTarget) then begin
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main75:
	BTFSC      STATUS+0, 0
	GOTO       L__main38
;12f675-PwmFet.mpas,203 :: 		repeat
L__main40:
;12f675-PwmFet.mpas,204 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main46
;12f675-PwmFet.mpas,205 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main47
;12f675-PwmFet.mpas,206 :: 		else break;
L__main46:
	GOTO       L__main42
L__main47:
;12f675-PwmFet.mpas,207 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,208 :: 		if adc_vol>vTarget+29 then begin
	MOVLW      29
	ADDWF      _vTarget+0, 0
	MOVWF      R1+0
	MOVF       _vTarget+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       _adc_vol+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main76:
	BTFSC      STATUS+0, 0
	GOTO       L__main49
;12f675-PwmFet.mpas,209 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,210 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,211 :: 		end;
L__main49:
;12f675-PwmFet.mpas,212 :: 		until adc_vol<=vTarget;
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main77:
	BTFSC      STATUS+0, 0
	GOTO       L__main43
	GOTO       L__main40
L__main43:
L__main42:
;12f675-PwmFet.mpas,213 :: 		end else if (adc_vol<vTarget) then begin
	GOTO       L__main39
L__main38:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main78
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main78:
	BTFSC      STATUS+0, 0
	GOTO       L__main52
;12f675-PwmFet.mpas,214 :: 		repeat
L__main54:
;12f675-PwmFet.mpas,215 :: 		if VOL_PWM<PWM_MAX then begin
	MOVLW      187
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main60
;12f675-PwmFet.mpas,216 :: 		Inc(VOL_PWM);
	INCF       _VOL_PWM+0, 1
;12f675-PwmFet.mpas,220 :: 		end else begin
	GOTO       L__main61
L__main60:
;12f675-PwmFet.mpas,225 :: 		break;
	GOTO       L__main56
;12f675-PwmFet.mpas,226 :: 		end;
L__main61:
;12f675-PwmFet.mpas,227 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,228 :: 		if adc_vol>vTarget+29 then begin
	MOVLW      29
	ADDWF      _vTarget+0, 0
	MOVWF      R1+0
	MOVF       _vTarget+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       _adc_vol+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main79
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main79:
	BTFSC      STATUS+0, 0
	GOTO       L__main63
;12f675-PwmFet.mpas,229 :: 		VOL_PWM:=VOL_PWM shr 3;
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
;12f675-PwmFet.mpas,230 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,231 :: 		end;
L__main63:
;12f675-PwmFet.mpas,232 :: 		until adc_vol>=vTarget;
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main80:
	BTFSC      STATUS+0, 0
	GOTO       L__main57
	GOTO       L__main54
L__main57:
L__main56:
;12f675-PwmFet.mpas,233 :: 		end;
L__main52:
L__main39:
;12f675-PwmFet.mpas,235 :: 		if (Hi(adc_vol)=0) and (Lo(adc_vol)<=cLow) then
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
	GOTO       L__main66
;12f675-PwmFet.mpas,236 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main67
;12f675-PwmFet.mpas,237 :: 		else if VOL_PWM=PWM_MAX then
L__main66:
	MOVF       _VOL_PWM+0, 0
	XORLW      187
	BTFSS      STATUS+0, 2
	GOTO       L__main69
;12f675-PwmFet.mpas,238 :: 		LED1_tm:=128
	MOVLW      128
	MOVWF      _LED1_tm+0
	GOTO       L__main70
;12f675-PwmFet.mpas,239 :: 		else
L__main69:
;12f675-PwmFet.mpas,240 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
L__main70:
L__main67:
;12f675-PwmFet.mpas,241 :: 		end;
	GOTO       L__main33
;12f675-PwmFet.mpas,242 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
