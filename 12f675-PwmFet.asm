
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,68 :: 		begin
;12f675-PwmFet.mpas,69 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,71 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,72 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,73 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,74 :: 		TMR0:=ON_PWM
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,75 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,76 :: 		TMR0:=PWM_MAX-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,77 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,78 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,79 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,80 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,81 :: 		TMR0:=ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,82 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,83 :: 		PWM_SYNC:=1;
	BSF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,84 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,85 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,86 :: 		end;
L__Interrupt2:
;12f675-PwmFet.mpas,87 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,88 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,89 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      56
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,90 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,91 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,92 :: 		end;
L__Interrupt11:
;12f675-PwmFet.mpas,93 :: 		end;
L_end_Interrupt:
L__Interrupt119:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Delay1ms:

;12f675-PwmFet.mpas,98 :: 		begin
;12f675-PwmFet.mpas,99 :: 		if limit>0 then begin
	MOVF       FARG_Delay1ms_limit+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__Delay1ms15
;12f675-PwmFet.mpas,100 :: 		ts:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      R2+0
;12f675-PwmFet.mpas,101 :: 		if t<=ts then
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      _TICK_1000+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__Delay1ms18
;12f675-PwmFet.mpas,102 :: 		ts:=ts-t
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R2+0, 1
	GOTO       L__Delay1ms19
;12f675-PwmFet.mpas,103 :: 		else
L__Delay1ms18:
;12f675-PwmFet.mpas,104 :: 		ts:=255-t+1+ts;
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBLW      255
	MOVWF      R0+0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 1
L__Delay1ms19:
;12f675-PwmFet.mpas,105 :: 		Result:=ts>=limit;
	MOVF       FARG_Delay1ms_limit+0, 0
	SUBWF      R2+0, 0
	MOVLW      255
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
;12f675-PwmFet.mpas,106 :: 		end else
	GOTO       L__Delay1ms16
L__Delay1ms15:
;12f675-PwmFet.mpas,107 :: 		Result:=True;
	MOVLW      255
	MOVWF      R1+0
L__Delay1ms16:
;12f675-PwmFet.mpas,108 :: 		if Result then
	MOVF       R1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__Delay1ms21
;12f675-PwmFet.mpas,109 :: 		t:=TICK_1000;
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       _TICK_1000+0, 0
	MOVWF      INDF+0
L__Delay1ms21:
;12f675-PwmFet.mpas,110 :: 		end;
	MOVF       R1+0, 0
	MOVWF      R0+0
L_end_Delay1ms:
	RETURN
; end of _Delay1ms

_main:

;12f675-PwmFet.mpas,112 :: 		begin
;12f675-PwmFet.mpas,113 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,114 :: 		ANSEL:=%00000010;
	MOVLW      2
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,116 :: 		TRISIO0_bit:=0;
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,117 :: 		TRISIO1_bit:=1;
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,118 :: 		TRISIO2_bit:=0;
	BCF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,119 :: 		TRISIO5_bit:=0;  // PWM_SYNC
	BCF        TRISIO5_bit+0, BitPos(TRISIO5_bit+0)
;12f675-PwmFet.mpas,120 :: 		LED1:=0;
	BCF        GP2_bit+0, BitPos(GP2_bit+0)
;12f675-PwmFet.mpas,121 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,122 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,123 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,124 :: 		LED1_Toggle:=True;
	MOVLW      255
	MOVWF      _LED1_Toggle+0
;12f675-PwmFet.mpas,125 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,126 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,127 :: 		out_short:=False;
	CLRF       _out_short+0
;12f675-PwmFet.mpas,128 :: 		short_count:=cShort_Recover*2;
	MOVLW      20
	MOVWF      _short_count+0
;12f675-PwmFet.mpas,129 :: 		short_check:=False;
	CLRF       _short_check+0
;12f675-PwmFet.mpas,130 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,131 :: 		LED_TMCount:=0;
	CLRF       _LED_TMCount+0
;12f675-PwmFet.mpas,133 :: 		OPTION_REG:=%01010000;        // ~2KHz @ 4MHz, enable weak pull-up
	MOVLW      80
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,135 :: 		WPU4_bit:=1;
	BSF        WPU4_bit+0, BitPos(WPU4_bit+0)
;12f675-PwmFet.mpas,137 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,138 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,139 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,140 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,141 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      56
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,142 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,143 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,144 :: 		GIE_bit:=1;      // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,146 :: 		LED1_Timer:=TICK_1000;
	CLRF       _LED1_Timer+0
;12f675-PwmFet.mpas,147 :: 		short_Timer:=TICK_1000;
	CLRF       _short_Timer+0
;12f675-PwmFet.mpas,149 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,151 :: 		while True do begin
L__main25:
;12f675-PwmFet.mpas,152 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main30
;12f675-PwmFet.mpas,153 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,154 :: 		end else begin
	GOTO       L__main31
L__main30:
;12f675-PwmFet.mpas,155 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,156 :: 		end;
L__main31:
;12f675-PwmFet.mpas,158 :: 		if (not out_short) then begin
	COMF       _out_short+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L__main33
;12f675-PwmFet.mpas,159 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,160 :: 		if (VOL_PWM>PWM_LOW) and (adc_vol<cLow) and short_check then begin
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R3+0
	MOVLW      0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main122
	MOVLW      17
	SUBWF      R0+0, 0
L__main122:
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R2+0
	MOVF       R2+0, 0
	ANDWF      R3+0, 0
	MOVWF      R0+0
	MOVF       _short_check+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main36
;12f675-PwmFet.mpas,161 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,162 :: 		out_short:=True;
	MOVLW      255
	MOVWF      _out_short+0
;12f675-PwmFet.mpas,163 :: 		out_timer:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _out_timer+0
;12f675-PwmFet.mpas,164 :: 		out_488:=10;         // 2 seconds
	MOVLW      10
	MOVWF      _out_488+0
;12f675-PwmFet.mpas,165 :: 		end else begin
	GOTO       L__main37
L__main36:
;12f675-PwmFet.mpas,166 :: 		if adc_vol<vTarget then begin
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main123:
	BTFSC      STATUS+0, 0
	GOTO       L__main39
;12f675-PwmFet.mpas,167 :: 		while adc_vol<vTarget do begin
L__main42:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main124
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main124:
	BTFSC      STATUS+0, 0
	GOTO       L__main43
;12f675-PwmFet.mpas,168 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main47
;12f675-PwmFet.mpas,169 :: 		Inc(VOL_PWM)
	INCF       _VOL_PWM+0, 1
	GOTO       L__main48
;12f675-PwmFet.mpas,170 :: 		else
L__main47:
;12f675-PwmFet.mpas,171 :: 		break;
	GOTO       L__main43
L__main48:
;12f675-PwmFet.mpas,172 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,173 :: 		end;
	GOTO       L__main42
L__main43:
;12f675-PwmFet.mpas,174 :: 		if adc_vol>cLow then begin
	MOVF       _adc_vol+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main125
	MOVF       _adc_vol+0, 0
	SUBLW      17
L__main125:
	BTFSC      STATUS+0, 0
	GOTO       L__main50
;12f675-PwmFet.mpas,175 :: 		while adc_vol>vTarget+cAdc_Limit do begin
L__main53:
	MOVLW      19
	ADDWF      _vTarget+0, 0
	MOVWF      R1+0
	MOVF       _vTarget+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       _adc_vol+1, 0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main126
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main126:
	BTFSC      STATUS+0, 0
	GOTO       L__main54
;12f675-PwmFet.mpas,176 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main58
;12f675-PwmFet.mpas,177 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main59
;12f675-PwmFet.mpas,178 :: 		else
L__main58:
;12f675-PwmFet.mpas,179 :: 		break;
	GOTO       L__main54
L__main59:
;12f675-PwmFet.mpas,180 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,181 :: 		end;
	GOTO       L__main53
L__main54:
;12f675-PwmFet.mpas,182 :: 		if (VCharge=0) and (adc_vol>=vTarget) then
	BTFSC      GP4_bit+0, BitPos(GP4_bit+0)
	GOTO       L__main127
	BSF        84, 0
	GOTO       L__main128
L__main127:
	BCF        84, 0
L__main128:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main129
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main129:
	MOVLW      255
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
	CLRF       R0+0
	BTFSC      84, 0
	INCF       R0+0, 1
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main61
;12f675-PwmFet.mpas,183 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
L__main61:
;12f675-PwmFet.mpas,184 :: 		end;
L__main50:
;12f675-PwmFet.mpas,185 :: 		end else if adc_vol>vTarget then begin
	GOTO       L__main40
L__main39:
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main130
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main130:
	BTFSC      STATUS+0, 0
	GOTO       L__main64
;12f675-PwmFet.mpas,186 :: 		while adc_vol>vTarget do begin
L__main67:
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main131
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main131:
	BTFSC      STATUS+0, 0
	GOTO       L__main68
;12f675-PwmFet.mpas,187 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main72
;12f675-PwmFet.mpas,188 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main73
;12f675-PwmFet.mpas,189 :: 		else
L__main72:
;12f675-PwmFet.mpas,190 :: 		break;
	GOTO       L__main68
L__main73:
;12f675-PwmFet.mpas,191 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,192 :: 		end;
	GOTO       L__main67
L__main68:
;12f675-PwmFet.mpas,193 :: 		if adc_vol>cLow then begin
	MOVF       _adc_vol+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main132
	MOVF       _adc_vol+0, 0
	SUBLW      17
L__main132:
	BTFSC      STATUS+0, 0
	GOTO       L__main75
;12f675-PwmFet.mpas,194 :: 		while adc_vol<vTarget-cAdc_Limit do begin
L__main78:
	MOVLW      19
	SUBWF      _vTarget+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _vTarget+1, 0
	MOVWF      R1+1
	MOVF       R1+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main133
	MOVF       R1+0, 0
	SUBWF      _adc_vol+0, 0
L__main133:
	BTFSC      STATUS+0, 0
	GOTO       L__main79
;12f675-PwmFet.mpas,195 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main83
;12f675-PwmFet.mpas,196 :: 		Inc(VOL_PWM)
	INCF       _VOL_PWM+0, 1
	GOTO       L__main84
;12f675-PwmFet.mpas,197 :: 		else
L__main83:
;12f675-PwmFet.mpas,198 :: 		break;
	GOTO       L__main79
L__main84:
;12f675-PwmFet.mpas,199 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,200 :: 		end;
	GOTO       L__main78
L__main79:
;12f675-PwmFet.mpas,201 :: 		if (VCharge=0) and (adc_vol>=vTarget) then
	BTFSC      GP4_bit+0, BitPos(GP4_bit+0)
	GOTO       L__main134
	BSF        84, 0
	GOTO       L__main135
L__main134:
	BCF        84, 0
L__main135:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main136:
	MOVLW      255
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
	CLRF       R0+0
	BTFSC      84, 0
	INCF       R0+0, 1
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main86
;12f675-PwmFet.mpas,202 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
L__main86:
;12f675-PwmFet.mpas,203 :: 		end;
L__main75:
;12f675-PwmFet.mpas,204 :: 		end;
L__main64:
L__main40:
;12f675-PwmFet.mpas,205 :: 		short_check:=Delay1ms(short_Timer,short_count);
	MOVLW      _short_Timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVF       _short_count+0, 0
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       R0+0, 0
	MOVWF      _short_check+0
;12f675-PwmFet.mpas,206 :: 		if short_check then
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main89
;12f675-PwmFet.mpas,207 :: 		short_count:=0;
	CLRF       _short_count+0
L__main89:
;12f675-PwmFet.mpas,208 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,209 :: 		end;
L__main37:
;12f675-PwmFet.mpas,210 :: 		end else
	GOTO       L__main34
L__main33:
;12f675-PwmFet.mpas,211 :: 		if out_short then begin
	MOVF       _out_short+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main92
;12f675-PwmFet.mpas,212 :: 		if Delay1ms(out_timer,100) then begin
	MOVLW      _out_timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVLW      100
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main95
;12f675-PwmFet.mpas,213 :: 		Dec(out_488);
	DECF       _out_488+0, 1
;12f675-PwmFet.mpas,214 :: 		if out_488=0 then begin
	MOVF       _out_488+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main98
;12f675-PwmFet.mpas,215 :: 		out_short:=False;
	CLRF       _out_short+0
;12f675-PwmFet.mpas,216 :: 		short_Timer:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _short_Timer+0
;12f675-PwmFet.mpas,217 :: 		short_count:=cShort_Recover;
	MOVLW      10
	MOVWF      _short_count+0
;12f675-PwmFet.mpas,218 :: 		short_check:=False;
	CLRF       _short_check+0
;12f675-PwmFet.mpas,219 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,220 :: 		end;
L__main98:
;12f675-PwmFet.mpas,221 :: 		end;
L__main95:
;12f675-PwmFet.mpas,222 :: 		end;
L__main92:
L__main34:
;12f675-PwmFet.mpas,224 :: 		if (VOL_PWM=PWM_MAX) or (VOL_PWM=0) then begin
	MOVF       _VOL_PWM+0, 0
	XORLW      255
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main101
;12f675-PwmFet.mpas,225 :: 		if (VCharge=0) and (VOL_PWM=0) then begin
	BTFSC      GP4_bit+0, BitPos(GP4_bit+0)
	GOTO       L__main137
	BSF        84, 0
	GOTO       L__main138
L__main137:
	BCF        84, 0
L__main138:
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	MOVLW      255
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	CLRF       R0+0
	BTFSC      84, 0
	INCF       R0+0, 1
	MOVF       R1+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main104
;12f675-PwmFet.mpas,226 :: 		LED_TMCount:=1;
	MOVLW      1
	MOVWF      _LED_TMCount+0
;12f675-PwmFet.mpas,227 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,228 :: 		end else
	GOTO       L__main105
L__main104:
;12f675-PwmFet.mpas,229 :: 		LED1_tm:=128;
	MOVLW      128
	MOVWF      _LED1_tm+0
L__main105:
;12f675-PwmFet.mpas,230 :: 		end;
L__main101:
;12f675-PwmFet.mpas,232 :: 		if not LED1_Toggle then begin
	COMF       _LED1_Toggle+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L__main107
;12f675-PwmFet.mpas,233 :: 		LED1_Toggle:=True;
	MOVLW      255
	MOVWF      _LED1_Toggle+0
;12f675-PwmFet.mpas,234 :: 		LED1_Timer:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _LED1_Timer+0
;12f675-PwmFet.mpas,235 :: 		end;
L__main107:
;12f675-PwmFet.mpas,236 :: 		if LED1_Toggle and Delay1ms(LED1_Timer,LED1_tm) then begin
	MOVLW      _LED1_Timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVF       _LED1_tm+0, 0
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       _LED1_Toggle+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main110
;12f675-PwmFet.mpas,237 :: 		if LED_TMCount>0 then
	MOVF       _LED_TMCount+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main113
;12f675-PwmFet.mpas,238 :: 		Dec(LED_TMCount);
	DECF       _LED_TMCount+0, 1
L__main113:
;12f675-PwmFet.mpas,239 :: 		if LED_TMCount=0 then begin
	MOVF       _LED_TMCount+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main116
;12f675-PwmFet.mpas,240 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP2_bit+0, 1
;12f675-PwmFet.mpas,241 :: 		end;
L__main116:
;12f675-PwmFet.mpas,242 :: 		end;
L__main110:
;12f675-PwmFet.mpas,244 :: 		end;
	GOTO       L__main25
;12f675-PwmFet.mpas,245 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
