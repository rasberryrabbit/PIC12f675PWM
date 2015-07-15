
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,77 :: 		begin
;12f675-PwmFet.mpas,78 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,80 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,81 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,82 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,83 :: 		TMR0:=ON_PWM
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,84 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,85 :: 		TMR0:=PWM_MAX-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,86 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,87 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,88 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,89 :: 		TMR0:=ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,90 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,91 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,92 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,93 :: 		end;
L__Interrupt2:
;12f675-PwmFet.mpas,94 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,95 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,96 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      56
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,97 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,98 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,99 :: 		end;
L__Interrupt11:
;12f675-PwmFet.mpas,100 :: 		end;
L_end_Interrupt:
L__Interrupt87:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Delay1ms:

;12f675-PwmFet.mpas,105 :: 		begin
;12f675-PwmFet.mpas,106 :: 		if limit>0 then begin
	MOVF       FARG_Delay1ms_limit+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__Delay1ms15
;12f675-PwmFet.mpas,107 :: 		ts:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      R2+0
;12f675-PwmFet.mpas,108 :: 		if t<=ts then
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      _TICK_1000+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__Delay1ms18
;12f675-PwmFet.mpas,109 :: 		ts:=ts-t
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBWF      R2+0, 1
	GOTO       L__Delay1ms19
;12f675-PwmFet.mpas,110 :: 		else
L__Delay1ms18:
;12f675-PwmFet.mpas,111 :: 		ts:=255-t+1+ts;
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	SUBLW      255
	MOVWF      R0+0
	INCF       R0+0, 1
	MOVF       R0+0, 0
	ADDWF      R2+0, 1
L__Delay1ms19:
;12f675-PwmFet.mpas,112 :: 		Result:=ts>=limit;
	MOVF       FARG_Delay1ms_limit+0, 0
	SUBWF      R2+0, 0
	MOVLW      255
	BTFSS      STATUS+0, 0
	MOVLW      0
	MOVWF      R1+0
;12f675-PwmFet.mpas,113 :: 		end else
	GOTO       L__Delay1ms16
L__Delay1ms15:
;12f675-PwmFet.mpas,114 :: 		Result:=True;
	MOVLW      255
	MOVWF      R1+0
L__Delay1ms16:
;12f675-PwmFet.mpas,115 :: 		if Result then
	MOVF       R1+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__Delay1ms21
;12f675-PwmFet.mpas,116 :: 		t:=TICK_1000;
	MOVF       FARG_Delay1ms_t+0, 0
	MOVWF      FSR
	MOVF       _TICK_1000+0, 0
	MOVWF      INDF+0
L__Delay1ms21:
;12f675-PwmFet.mpas,117 :: 		end;
	MOVF       R1+0, 0
	MOVWF      R0+0
L_end_Delay1ms:
	RETURN
; end of _Delay1ms

_main:

;12f675-PwmFet.mpas,119 :: 		begin
;12f675-PwmFet.mpas,120 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,121 :: 		ANSEL:=%00000010;
	MOVLW      2
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,123 :: 		TRISIO0_bit:=0;
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,124 :: 		TRISIO1_bit:=1;
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,125 :: 		TRISIO2_bit:=0;
	BCF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,126 :: 		TRISIO5_bit:=0;  // Sig_VSE
	BCF        TRISIO5_bit+0, BitPos(TRISIO5_bit+0)
;12f675-PwmFet.mpas,127 :: 		LED1:=0;
	BCF        GP2_bit+0, BitPos(GP2_bit+0)
;12f675-PwmFet.mpas,128 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,129 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,130 :: 		LED1_Toggle:=True;
	MOVLW      255
	MOVWF      _LED1_Toggle+0
;12f675-PwmFet.mpas,131 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,132 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,133 :: 		out_short:=False;
	CLRF       _out_short+0
;12f675-PwmFet.mpas,134 :: 		short_count:=cShort_Recover*2;
	MOVLW      56
	MOVWF      _short_count+0
;12f675-PwmFet.mpas,135 :: 		short_check:=False;
	CLRF       _short_check+0
;12f675-PwmFet.mpas,136 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,137 :: 		LED_TMCount:=0;
	CLRF       _LED_TMCount+0
;12f675-PwmFet.mpas,138 :: 		VSE_LO_HIT:=0;
	CLRF       _VSE_LO_HIT+0
;12f675-PwmFet.mpas,140 :: 		OPTION_REG:=%01010001;        // ~1KHz @ 4MHz, enable weak pull-up
	MOVLW      81
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,142 :: 		WPU4_bit:=1;
	BSF        WPU4_bit+0, BitPos(WPU4_bit+0)
;12f675-PwmFet.mpas,144 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,145 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,146 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,147 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,148 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      56
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,149 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,150 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,151 :: 		GIE_bit:=1;      // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,153 :: 		LED1_Timer:=TICK_1000;
	CLRF       _LED1_Timer+0
;12f675-PwmFet.mpas,154 :: 		ADC_Timer:=TICK_1000;
	CLRF       _ADC_Timer+0
;12f675-PwmFet.mpas,155 :: 		short_Timer:=TICK_1000;
	CLRF       _short_Timer+0
;12f675-PwmFet.mpas,156 :: 		VSE_Timer:=TICK_1000;
	CLRF       _VSE_Timer+0
;12f675-PwmFet.mpas,157 :: 		VSE_Lo_Reset:=0;
	CLRF       _VSE_Lo_Reset+0
;12f675-PwmFet.mpas,158 :: 		Sig_VSE:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,159 :: 		VSE_CONN:=False;
	CLRF       _VSE_CONN+0
;12f675-PwmFet.mpas,161 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,163 :: 		while True do begin
L__main25:
;12f675-PwmFet.mpas,164 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main30
;12f675-PwmFet.mpas,165 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,166 :: 		VSE_HI:=c051;
	MOVLW      41
	MOVWF      _VSE_HI+0
	MOVLW      1
	MOVWF      _VSE_HI+1
;12f675-PwmFet.mpas,167 :: 		end else begin
	GOTO       L__main31
L__main30:
;12f675-PwmFet.mpas,168 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,169 :: 		VSE_HI:=c138;
	MOVLW      35
	MOVWF      _VSE_HI+0
	MOVLW      3
	MOVWF      _VSE_HI+1
;12f675-PwmFet.mpas,170 :: 		end;
L__main31:
;12f675-PwmFet.mpas,178 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,179 :: 		if adc_vol>=VSE_HI then
	MOVF       _VSE_HI+1, 0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main90
	MOVF       _VSE_HI+0, 0
	SUBWF      R0+0, 0
L__main90:
	BTFSS      STATUS+0, 0
	GOTO       L__main33
;12f675-PwmFet.mpas,180 :: 		Sig_VSE:=1
	BSF        GP5_bit+0, BitPos(GP5_bit+0)
	GOTO       L__main34
;12f675-PwmFet.mpas,181 :: 		else
L__main33:
;12f675-PwmFet.mpas,182 :: 		Sig_VSE:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
L__main34:
;12f675-PwmFet.mpas,184 :: 		if (not out_short) and Delay1ms(ADC_Timer,1) then begin
	COMF       _out_short+0, 0
	MOVWF      FLOC__main+0
	MOVLW      _ADC_Timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVLW      1
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       FLOC__main+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main36
;12f675-PwmFet.mpas,185 :: 		adc_vol:=ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_vol+0
	MOVF       R0+1, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,186 :: 		if (VOL_PWM>PWM_LOW) and (adc_vol<cLow) and short_check then begin
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R3+0
	MOVLW      0
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main91
	MOVLW      17
	SUBWF      R0+0, 0
L__main91:
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
	GOTO       L__main39
;12f675-PwmFet.mpas,187 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,188 :: 		out_short:=True;
	MOVLW      255
	MOVWF      _out_short+0
;12f675-PwmFet.mpas,189 :: 		out_timer:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _out_timer+0
;12f675-PwmFet.mpas,190 :: 		out_488:=10;         // 2 seconds
	MOVLW      10
	MOVWF      _out_488+0
;12f675-PwmFet.mpas,191 :: 		end else begin
	GOTO       L__main40
L__main39:
;12f675-PwmFet.mpas,192 :: 		if adc_vol<vTarget then begin
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main92
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main92:
	BTFSC      STATUS+0, 0
	GOTO       L__main42
;12f675-PwmFet.mpas,193 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main45
;12f675-PwmFet.mpas,194 :: 		Inc(VOL_PWM);
	INCF       _VOL_PWM+0, 1
L__main45:
;12f675-PwmFet.mpas,195 :: 		end else if adc_vol>vTarget then begin
	GOTO       L__main43
L__main42:
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main93
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main93:
	BTFSC      STATUS+0, 0
	GOTO       L__main48
;12f675-PwmFet.mpas,196 :: 		if VOL_PWM>0 then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main51
;12f675-PwmFet.mpas,197 :: 		Dec(VOL_PWM);
	DECF       _VOL_PWM+0, 1
L__main51:
;12f675-PwmFet.mpas,198 :: 		if VCharge=0 then
	BTFSC      GP4_bit+0, BitPos(GP4_bit+0)
	GOTO       L__main54
;12f675-PwmFet.mpas,199 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
L__main54:
;12f675-PwmFet.mpas,200 :: 		end;
L__main48:
L__main43:
;12f675-PwmFet.mpas,201 :: 		short_check:=Delay1ms(short_Timer,short_count);
	MOVLW      _short_Timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVF       _short_count+0, 0
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       R0+0, 0
	MOVWF      _short_check+0
;12f675-PwmFet.mpas,202 :: 		if short_check then
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main57
;12f675-PwmFet.mpas,203 :: 		short_count:=0;
	CLRF       _short_count+0
L__main57:
;12f675-PwmFet.mpas,204 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,205 :: 		end;
L__main40:
;12f675-PwmFet.mpas,206 :: 		end else
	GOTO       L__main37
L__main36:
;12f675-PwmFet.mpas,207 :: 		if out_short then begin
	MOVF       _out_short+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main60
;12f675-PwmFet.mpas,208 :: 		Sig_VSE:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,209 :: 		if Delay1ms(out_timer,100) then begin
	MOVLW      _out_timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVLW      100
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main63
;12f675-PwmFet.mpas,210 :: 		Dec(out_488);
	DECF       _out_488+0, 1
;12f675-PwmFet.mpas,211 :: 		if out_488=0 then begin
	MOVF       _out_488+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
;12f675-PwmFet.mpas,212 :: 		out_short:=False;
	CLRF       _out_short+0
;12f675-PwmFet.mpas,213 :: 		short_Timer:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _short_Timer+0
;12f675-PwmFet.mpas,214 :: 		short_count:=cShort_Recover;
	MOVLW      28
	MOVWF      _short_count+0
;12f675-PwmFet.mpas,215 :: 		short_check:=False;
	CLRF       _short_check+0
;12f675-PwmFet.mpas,216 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,217 :: 		end;
L__main66:
;12f675-PwmFet.mpas,218 :: 		end;
L__main63:
;12f675-PwmFet.mpas,219 :: 		end;
L__main60:
L__main37:
;12f675-PwmFet.mpas,221 :: 		if (VOL_PWM=PWM_MAX) or (VOL_PWM=0) then begin
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
	GOTO       L__main69
;12f675-PwmFet.mpas,222 :: 		if (VCharge=0) and (VOL_PWM=0) then begin
	BTFSC      GP4_bit+0, BitPos(GP4_bit+0)
	GOTO       L__main94
	BSF        84, 0
	GOTO       L__main95
L__main94:
	BCF        84, 0
L__main95:
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
	GOTO       L__main72
;12f675-PwmFet.mpas,223 :: 		LED_TMCount:=1;
	MOVLW      1
	MOVWF      _LED_TMCount+0
;12f675-PwmFet.mpas,224 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,225 :: 		end else
	GOTO       L__main73
L__main72:
;12f675-PwmFet.mpas,226 :: 		LED1_tm:=128;
	MOVLW      128
	MOVWF      _LED1_tm+0
L__main73:
;12f675-PwmFet.mpas,227 :: 		end;
L__main69:
;12f675-PwmFet.mpas,229 :: 		if not LED1_Toggle then begin
	COMF       _LED1_Toggle+0, 0
	MOVWF      R0+0
	BTFSC      STATUS+0, 2
	GOTO       L__main75
;12f675-PwmFet.mpas,230 :: 		LED1_Toggle:=True;
	MOVLW      255
	MOVWF      _LED1_Toggle+0
;12f675-PwmFet.mpas,231 :: 		LED1_Timer:=TICK_1000;
	MOVF       _TICK_1000+0, 0
	MOVWF      _LED1_Timer+0
;12f675-PwmFet.mpas,232 :: 		end;
L__main75:
;12f675-PwmFet.mpas,233 :: 		if LED1_Toggle and Delay1ms(LED1_Timer,LED1_tm) then begin
	MOVLW      _LED1_Timer+0
	MOVWF      FARG_Delay1ms_t+0
	MOVF       _LED1_tm+0, 0
	MOVWF      FARG_Delay1ms_limit+0
	CALL       _Delay1ms+0
	MOVF       _LED1_Toggle+0, 0
	ANDWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L__main78
;12f675-PwmFet.mpas,234 :: 		if LED_TMCount>0 then
	MOVF       _LED_TMCount+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main81
;12f675-PwmFet.mpas,235 :: 		Dec(LED_TMCount);
	DECF       _LED_TMCount+0, 1
L__main81:
;12f675-PwmFet.mpas,236 :: 		if LED_TMCount=0 then
	MOVF       _LED_TMCount+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
;12f675-PwmFet.mpas,237 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP2_bit+0, 1
L__main84:
;12f675-PwmFet.mpas,238 :: 		end;
L__main78:
;12f675-PwmFet.mpas,240 :: 		end;
	GOTO       L__main25
;12f675-PwmFet.mpas,241 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
