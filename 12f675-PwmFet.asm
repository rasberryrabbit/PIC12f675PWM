
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,64 :: 		begin
;12f675-PwmFet.mpas,65 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,67 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,68 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,69 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,70 :: 		TMR0:=ON_PWM
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,71 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,72 :: 		TMR0:=PWM_MAX-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,73 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,74 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,75 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,76 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,77 :: 		TMR0:=ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,78 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,79 :: 		PWM_SYNC:=1;
	BSF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,80 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,81 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,82 :: 		end;
L__Interrupt2:
;12f675-PwmFet.mpas,83 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,84 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,85 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,86 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,87 :: 		if TICK_1000>LED1_Tm then begin
	MOVF       _TICK_1000+0, 0
	SUBWF      _LED1_tm+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__Interrupt14
;12f675-PwmFet.mpas,88 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP2_bit+0, 1
;12f675-PwmFet.mpas,89 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,90 :: 		end;
L__Interrupt14:
;12f675-PwmFet.mpas,91 :: 		Inc(Tick_512);   // reset PWM every 6 seconds at Maxium PWM. it recover voltage drop on PV.
	INCF       _Tick_512+0, 1
;12f675-PwmFet.mpas,92 :: 		if Tick_512=255 then begin
	MOVF       _Tick_512+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt17
;12f675-PwmFet.mpas,93 :: 		Inc(Tick_512_1);
	INCF       _Tick_512_1+0, 1
;12f675-PwmFet.mpas,94 :: 		if Tick_512_1=12 then begin
	MOVF       _Tick_512_1+0, 0
	XORLW      12
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt20
;12f675-PwmFet.mpas,95 :: 		if MaxLoad_Reset then
	BTFSS      _MaxLoad_Reset+0, BitPos(_MaxLoad_Reset+0)
	GOTO       L__Interrupt23
;12f675-PwmFet.mpas,96 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
L__Interrupt23:
;12f675-PwmFet.mpas,97 :: 		Tick_512_1:=0;
	CLRF       _Tick_512_1+0
;12f675-PwmFet.mpas,98 :: 		end;
L__Interrupt20:
;12f675-PwmFet.mpas,99 :: 		end;
L__Interrupt17:
;12f675-PwmFet.mpas,100 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,101 :: 		end;
L__Interrupt11:
;12f675-PwmFet.mpas,102 :: 		if GPIF_bit=1 then begin
	BTFSS      GPIF_bit+0, BitPos(GPIF_bit+0)
	GOTO       L__Interrupt26
;12f675-PwmFet.mpas,103 :: 		if VOut5=0 then
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__Interrupt29
;12f675-PwmFet.mpas,104 :: 		vTarget:=c051
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
	GOTO       L__Interrupt30
;12f675-PwmFet.mpas,105 :: 		else
L__Interrupt29:
;12f675-PwmFet.mpas,106 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
L__Interrupt30:
;12f675-PwmFet.mpas,107 :: 		GPIF_bit:=0;
	BCF        GPIF_bit+0, BitPos(GPIF_bit+0)
;12f675-PwmFet.mpas,108 :: 		end;
L__Interrupt26:
;12f675-PwmFet.mpas,109 :: 		end;
L_end_Interrupt:
L__Interrupt113:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Read_ADC:

;12f675-PwmFet.mpas,112 :: 		begin
;12f675-PwmFet.mpas,113 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,114 :: 		while GO_NOT_DONE_bit=1 do ;
L__Read_ADC33:
	BTFSC      GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
	GOTO       L__Read_ADC33
;12f675-PwmFet.mpas,115 :: 		Hi(adc_vol):=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,116 :: 		Lo(adc_vol):=ADRESL;
	MOVF       ADRESL+0, 0
	MOVWF      _adc_vol+0
;12f675-PwmFet.mpas,117 :: 		end;
L_end_Read_ADC:
	RETURN
; end of _Read_ADC

_main:

;12f675-PwmFet.mpas,119 :: 		begin
;12f675-PwmFet.mpas,123 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,124 :: 		ANSEL:=%00000010;
	MOVLW      2
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,126 :: 		TRISIO0_bit:=0;
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,127 :: 		TRISIO1_bit:=1;
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,128 :: 		TRISIO2_bit:=0;
	BCF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,129 :: 		TRISIO5_bit:=0;  // PWM_SYNC
	BCF        TRISIO5_bit+0, BitPos(TRISIO5_bit+0)
;12f675-PwmFet.mpas,130 :: 		LED1:=0;
	BCF        GP2_bit+0, BitPos(GP2_bit+0)
;12f675-PwmFet.mpas,131 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,132 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,133 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,134 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,135 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,136 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,137 :: 		MaxLoad_Reset:=0;
	BCF        _MaxLoad_Reset+0, BitPos(_MaxLoad_Reset+0)
;12f675-PwmFet.mpas,139 :: 		OPTION_REG:=%01010000;        // ~2KHz @ 4MHz, enable weak pull-up
	MOVLW      80
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,140 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,142 :: 		ADCON0:=%10000101;            // ADC config
	MOVLW      133
	MOVWF      ADCON0+0
;12f675-PwmFet.mpas,144 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,146 :: 		T1CKPS0_bit:=1;               // timer prescaler 1:2
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;12f675-PwmFet.mpas,147 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,148 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,149 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,150 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,152 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;12f675-PwmFet.mpas,154 :: 		IOC3_bit:=1;
	BSF        IOC3_bit+0, BitPos(IOC3_bit+0)
;12f675-PwmFet.mpas,155 :: 		GPIE_bit:=1;
	BSF        GPIE_bit+0, BitPos(GPIE_bit+0)
;12f675-PwmFet.mpas,157 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,159 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,160 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,162 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,164 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,166 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main39
;12f675-PwmFet.mpas,167 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,168 :: 		end else begin
	GOTO       L__main40
L__main39:
;12f675-PwmFet.mpas,169 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,170 :: 		end;
L__main40:
;12f675-PwmFet.mpas,173 :: 		while True do begin
L__main42:
;12f675-PwmFet.mpas,175 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,176 :: 		if (adc_vol>vTarget) then begin
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main116
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main116:
	BTFSC      STATUS+0, 0
	GOTO       L__main47
;12f675-PwmFet.mpas,177 :: 		repeat
L__main49:
;12f675-PwmFet.mpas,178 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main55
;12f675-PwmFet.mpas,179 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main56
;12f675-PwmFet.mpas,180 :: 		else break;
L__main55:
	GOTO       L__main51
L__main56:
;12f675-PwmFet.mpas,181 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main58
;12f675-PwmFet.mpas,182 :: 		for i:=0 to PWM_DELAY51 do begin
	CLRF       _i+0
L__main61:
;12f675-PwmFet.mpas,183 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,184 :: 		if adc_vol>vTarget+29 then begin
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
	GOTO       L__main117
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main117:
	BTFSC      STATUS+0, 0
	GOTO       L__main66
;12f675-PwmFet.mpas,185 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,186 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,187 :: 		break;
	GOTO       L__main64
;12f675-PwmFet.mpas,188 :: 		end
L__main66:
;12f675-PwmFet.mpas,189 :: 		end;
	MOVF       _i+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__main64
	INCF       _i+0, 1
	GOTO       L__main61
L__main64:
;12f675-PwmFet.mpas,190 :: 		end else begin
	GOTO       L__main59
L__main58:
;12f675-PwmFet.mpas,191 :: 		for i:=0 to PWM_DELAY138 do begin
	CLRF       _i+0
L__main69:
;12f675-PwmFet.mpas,192 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,193 :: 		if adc_vol>vTarget+29 then begin
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
	GOTO       L__main118
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main118:
	BTFSC      STATUS+0, 0
	GOTO       L__main74
;12f675-PwmFet.mpas,194 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,195 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,196 :: 		break;
	GOTO       L__main72
;12f675-PwmFet.mpas,197 :: 		end;
L__main74:
;12f675-PwmFet.mpas,198 :: 		end;
	MOVF       _i+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__main72
	INCF       _i+0, 1
	GOTO       L__main69
L__main72:
;12f675-PwmFet.mpas,199 :: 		end;
L__main59:
;12f675-PwmFet.mpas,200 :: 		until adc_vol<=vTarget;
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main119
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main119:
	BTFSC      STATUS+0, 0
	GOTO       L__main52
	GOTO       L__main49
L__main52:
L__main51:
;12f675-PwmFet.mpas,201 :: 		end else if (adc_vol<vTarget) then begin
	GOTO       L__main48
L__main47:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main120
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main120:
	BTFSC      STATUS+0, 0
	GOTO       L__main77
;12f675-PwmFet.mpas,202 :: 		repeat
L__main79:
;12f675-PwmFet.mpas,203 :: 		if VOL_PWM<PWM_MAX then begin
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main85
;12f675-PwmFet.mpas,204 :: 		Inc(VOL_PWM);
	INCF       _VOL_PWM+0, 1
;12f675-PwmFet.mpas,205 :: 		MaxLoad_Reset:=0;
	BCF        _MaxLoad_Reset+0, BitPos(_MaxLoad_Reset+0)
;12f675-PwmFet.mpas,206 :: 		end else begin
	GOTO       L__main86
L__main85:
;12f675-PwmFet.mpas,207 :: 		MaxLoad_Reset:=1;
	BSF        _MaxLoad_Reset+0, BitPos(_MaxLoad_Reset+0)
;12f675-PwmFet.mpas,208 :: 		break;
	GOTO       L__main81
;12f675-PwmFet.mpas,209 :: 		end;
L__main86:
;12f675-PwmFet.mpas,210 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main88
;12f675-PwmFet.mpas,211 :: 		for i:=0 to PWM_DELAY51 do begin
	CLRF       _i+0
L__main91:
;12f675-PwmFet.mpas,212 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,213 :: 		if adc_vol>vTarget+29 then begin
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
	GOTO       L__main121
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main121:
	BTFSC      STATUS+0, 0
	GOTO       L__main96
;12f675-PwmFet.mpas,214 :: 		VOL_PWM:=VOL_PWM shr 4;
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
;12f675-PwmFet.mpas,215 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,216 :: 		break;
	GOTO       L__main94
;12f675-PwmFet.mpas,217 :: 		end;
L__main96:
;12f675-PwmFet.mpas,218 :: 		end;
	MOVF       _i+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__main94
	INCF       _i+0, 1
	GOTO       L__main91
L__main94:
;12f675-PwmFet.mpas,219 :: 		end else begin
	GOTO       L__main89
L__main88:
;12f675-PwmFet.mpas,220 :: 		for i:=0 to PWM_DELAY138 do begin
	CLRF       _i+0
L__main99:
;12f675-PwmFet.mpas,221 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,222 :: 		if adc_vol>vTarget+29 then begin
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
	GOTO       L__main122
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main122:
	BTFSC      STATUS+0, 0
	GOTO       L__main104
;12f675-PwmFet.mpas,223 :: 		VOL_PWM:=VOL_PWM shr 4;
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
;12f675-PwmFet.mpas,224 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,225 :: 		end;
L__main104:
;12f675-PwmFet.mpas,226 :: 		end;
	MOVF       _i+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L__main102
	INCF       _i+0, 1
	GOTO       L__main99
L__main102:
;12f675-PwmFet.mpas,227 :: 		end;
L__main89:
;12f675-PwmFet.mpas,228 :: 		until adc_vol>=vTarget;
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main123:
	BTFSC      STATUS+0, 0
	GOTO       L__main82
	GOTO       L__main79
L__main82:
L__main81:
;12f675-PwmFet.mpas,229 :: 		end;
L__main77:
L__main48:
;12f675-PwmFet.mpas,231 :: 		if (Hi(adc_vol)=0) and (Lo(adc_vol)<=cLow) then
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
	GOTO       L__main107
;12f675-PwmFet.mpas,232 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main108
;12f675-PwmFet.mpas,233 :: 		else if VOL_PWM=PWM_MAX then
L__main107:
	MOVF       _VOL_PWM+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main110
;12f675-PwmFet.mpas,234 :: 		LED1_tm:=128
	MOVLW      128
	MOVWF      _LED1_tm+0
	GOTO       L__main111
;12f675-PwmFet.mpas,235 :: 		else
L__main110:
;12f675-PwmFet.mpas,236 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
L__main111:
L__main108:
;12f675-PwmFet.mpas,237 :: 		end;
	GOTO       L__main42
;12f675-PwmFet.mpas,238 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
