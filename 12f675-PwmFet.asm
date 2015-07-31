
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,61 :: 		begin
;12f675-PwmFet.mpas,62 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,64 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,65 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,66 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,67 :: 		TMR0:=ON_PWM
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,68 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,69 :: 		TMR0:=PWM_MAX-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,70 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,71 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,72 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,73 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,74 :: 		TMR0:=ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,75 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,76 :: 		PWM_SYNC:=1;
	BSF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,77 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,78 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,79 :: 		end;
L__Interrupt2:
;12f675-PwmFet.mpas,80 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,81 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,82 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,83 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,84 :: 		if TICK_1000>LED1_Tm then begin
	MOVF       _TICK_1000+0, 0
	SUBWF      _LED1_tm+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__Interrupt14
;12f675-PwmFet.mpas,85 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP2_bit+0, 1
;12f675-PwmFet.mpas,86 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,87 :: 		end;
L__Interrupt14:
;12f675-PwmFet.mpas,88 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,89 :: 		end;
L__Interrupt11:
;12f675-PwmFet.mpas,90 :: 		if GPIF_bit=1 then begin
	BTFSS      GPIF_bit+0, BitPos(GPIF_bit+0)
	GOTO       L__Interrupt17
;12f675-PwmFet.mpas,91 :: 		if VOut5=0 then
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__Interrupt20
;12f675-PwmFet.mpas,92 :: 		vTarget:=c051
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
	GOTO       L__Interrupt21
;12f675-PwmFet.mpas,93 :: 		else
L__Interrupt20:
;12f675-PwmFet.mpas,94 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
L__Interrupt21:
;12f675-PwmFet.mpas,95 :: 		GPIF_bit:=0;
	BCF        GPIF_bit+0, BitPos(GPIF_bit+0)
;12f675-PwmFet.mpas,96 :: 		end;
L__Interrupt17:
;12f675-PwmFet.mpas,97 :: 		end;
L_end_Interrupt:
L__Interrupt104:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _Interrupt

_Read_ADC:

;12f675-PwmFet.mpas,100 :: 		begin
;12f675-PwmFet.mpas,101 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,102 :: 		while GO_NOT_DONE_bit=1 do ;
L__Read_ADC24:
	BTFSC      GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
	GOTO       L__Read_ADC24
;12f675-PwmFet.mpas,103 :: 		Hi(adc_vol):=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,104 :: 		Lo(adc_vol):=ADRESL;
	MOVF       ADRESL+0, 0
	MOVWF      _adc_vol+0
;12f675-PwmFet.mpas,105 :: 		end;
L_end_Read_ADC:
	RETURN
; end of _Read_ADC

_main:

;12f675-PwmFet.mpas,107 :: 		begin
;12f675-PwmFet.mpas,111 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,112 :: 		ANSEL:=%00000010;
	MOVLW      2
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,114 :: 		TRISIO0_bit:=0;
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,115 :: 		TRISIO1_bit:=1;
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,116 :: 		TRISIO2_bit:=0;
	BCF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,117 :: 		TRISIO5_bit:=0;  // PWM_SYNC
	BCF        TRISIO5_bit+0, BitPos(TRISIO5_bit+0)
;12f675-PwmFet.mpas,118 :: 		LED1:=0;
	BCF        GP2_bit+0, BitPos(GP2_bit+0)
;12f675-PwmFet.mpas,119 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,120 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,121 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,122 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,123 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,124 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,126 :: 		OPTION_REG:=%01010000;        // ~2KHz @ 4MHz, enable weak pull-up
	MOVLW      80
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,127 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,129 :: 		ADCON0:=%10000101;            // ADC config
	MOVLW      133
	MOVWF      ADCON0+0
;12f675-PwmFet.mpas,131 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,133 :: 		T1CKPS0_bit:=1;               // timer prescaler 1:2
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;12f675-PwmFet.mpas,134 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,135 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,136 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,137 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,139 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;12f675-PwmFet.mpas,141 :: 		IOC3_bit:=1;
	BSF        IOC3_bit+0, BitPos(IOC3_bit+0)
;12f675-PwmFet.mpas,142 :: 		GPIE_bit:=1;
	BSF        GPIE_bit+0, BitPos(GPIE_bit+0)
;12f675-PwmFet.mpas,144 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,146 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,147 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,149 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,151 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,153 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main30
;12f675-PwmFet.mpas,154 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,155 :: 		end else begin
	GOTO       L__main31
L__main30:
;12f675-PwmFet.mpas,156 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,157 :: 		end;
L__main31:
;12f675-PwmFet.mpas,160 :: 		while True do begin
L__main33:
;12f675-PwmFet.mpas,162 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,163 :: 		if (adc_vol>vTarget) then begin
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main107
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main107:
	BTFSC      STATUS+0, 0
	GOTO       L__main38
;12f675-PwmFet.mpas,164 :: 		repeat
L__main40:
;12f675-PwmFet.mpas,165 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main46
;12f675-PwmFet.mpas,166 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main47
;12f675-PwmFet.mpas,167 :: 		else break;
L__main46:
	GOTO       L__main42
L__main47:
;12f675-PwmFet.mpas,168 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main49
;12f675-PwmFet.mpas,169 :: 		for i:=0 to PWM_DELAY51 do begin
	CLRF       _i+0
	CLRF       _i+1
L__main52:
;12f675-PwmFet.mpas,170 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,171 :: 		if adc_vol>vTarget+29 then begin
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
	GOTO       L__main108
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main108:
	BTFSC      STATUS+0, 0
	GOTO       L__main57
;12f675-PwmFet.mpas,172 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,173 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,174 :: 		break;
	GOTO       L__main55
;12f675-PwmFet.mpas,175 :: 		end
L__main57:
;12f675-PwmFet.mpas,176 :: 		end;
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main109
	MOVLW      5
	XORWF      _i+0, 0
L__main109:
	BTFSC      STATUS+0, 2
	GOTO       L__main55
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L__main52
L__main55:
;12f675-PwmFet.mpas,177 :: 		end else begin
	GOTO       L__main50
L__main49:
;12f675-PwmFet.mpas,178 :: 		for i:=0 to PWM_DELAY138 do begin
	CLRF       _i+0
	CLRF       _i+1
L__main60:
;12f675-PwmFet.mpas,179 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,180 :: 		if adc_vol>vTarget+29 then begin
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
	GOTO       L__main110
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main110:
	BTFSC      STATUS+0, 0
	GOTO       L__main65
;12f675-PwmFet.mpas,181 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,182 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,183 :: 		break;
	GOTO       L__main63
;12f675-PwmFet.mpas,184 :: 		end;
L__main65:
;12f675-PwmFet.mpas,185 :: 		end;
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main111
	MOVLW      5
	XORWF      _i+0, 0
L__main111:
	BTFSC      STATUS+0, 2
	GOTO       L__main63
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L__main60
L__main63:
;12f675-PwmFet.mpas,186 :: 		end;
L__main50:
;12f675-PwmFet.mpas,187 :: 		until adc_vol<=vTarget;
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main112
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main112:
	BTFSC      STATUS+0, 0
	GOTO       L__main43
	GOTO       L__main40
L__main43:
L__main42:
;12f675-PwmFet.mpas,188 :: 		end else if (adc_vol<vTarget) then begin
	GOTO       L__main39
L__main38:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main113
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main113:
	BTFSC      STATUS+0, 0
	GOTO       L__main68
;12f675-PwmFet.mpas,189 :: 		repeat
L__main70:
;12f675-PwmFet.mpas,190 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main76
;12f675-PwmFet.mpas,191 :: 		Inc(VOL_PWM)
	INCF       _VOL_PWM+0, 1
	GOTO       L__main77
;12f675-PwmFet.mpas,192 :: 		else break;
L__main76:
	GOTO       L__main72
L__main77:
;12f675-PwmFet.mpas,193 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main79
;12f675-PwmFet.mpas,194 :: 		for i:=0 to PWM_DELAY51 do begin
	CLRF       _i+0
	CLRF       _i+1
L__main82:
;12f675-PwmFet.mpas,195 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,196 :: 		if adc_vol>vTarget+29 then
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
	GOTO       L__main114
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main114:
	BTFSC      STATUS+0, 0
	GOTO       L__main87
;12f675-PwmFet.mpas,197 :: 		VOL_PWM:=VOL_PWM shr 4;
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
L__main87:
;12f675-PwmFet.mpas,198 :: 		end;
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main115
	MOVLW      5
	XORWF      _i+0, 0
L__main115:
	BTFSC      STATUS+0, 2
	GOTO       L__main85
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L__main82
L__main85:
;12f675-PwmFet.mpas,199 :: 		end else begin
	GOTO       L__main80
L__main79:
;12f675-PwmFet.mpas,200 :: 		for i:=0 to PWM_DELAY138 do begin
	CLRF       _i+0
	CLRF       _i+1
L__main90:
;12f675-PwmFet.mpas,201 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,202 :: 		if adc_vol>vTarget+29 then
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
	GOTO       L__main116
	MOVF       _adc_vol+0, 0
	SUBWF      R1+0, 0
L__main116:
	BTFSC      STATUS+0, 0
	GOTO       L__main95
;12f675-PwmFet.mpas,203 :: 		VOL_PWM:=VOL_PWM shr 4;
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
	RRF        _VOL_PWM+0, 1
	BCF        _VOL_PWM+0, 7
L__main95:
;12f675-PwmFet.mpas,204 :: 		end;
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main117
	MOVLW      5
	XORWF      _i+0, 0
L__main117:
	BTFSC      STATUS+0, 2
	GOTO       L__main93
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
	GOTO       L__main90
L__main93:
;12f675-PwmFet.mpas,205 :: 		end;
L__main80:
;12f675-PwmFet.mpas,206 :: 		until adc_vol>=vTarget;
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main118
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main118:
	BTFSC      STATUS+0, 0
	GOTO       L__main73
	GOTO       L__main70
L__main73:
L__main72:
;12f675-PwmFet.mpas,207 :: 		end;
L__main68:
L__main39:
;12f675-PwmFet.mpas,209 :: 		if (Hi(adc_vol)=0) and (Lo(adc_vol)<=cLow) then
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
	GOTO       L__main98
;12f675-PwmFet.mpas,210 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main99
;12f675-PwmFet.mpas,211 :: 		else if VOL_PWM=PWM_MAX then
L__main98:
	MOVF       _VOL_PWM+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main101
;12f675-PwmFet.mpas,212 :: 		LED1_tm:=128
	MOVLW      128
	MOVWF      _LED1_tm+0
	GOTO       L__main102
;12f675-PwmFet.mpas,213 :: 		else
L__main101:
;12f675-PwmFet.mpas,214 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
L__main102:
L__main99:
;12f675-PwmFet.mpas,215 :: 		end;
	GOTO       L__main33
;12f675-PwmFet.mpas,216 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
