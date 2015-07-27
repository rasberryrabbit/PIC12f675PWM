
_Interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;12f675-PwmFet.mpas,56 :: 		begin
;12f675-PwmFet.mpas,57 :: 		if T0IF_bit=1 then begin
	BTFSS      T0IF_bit+0, BitPos(T0IF_bit+0)
	GOTO       L__Interrupt2
;12f675-PwmFet.mpas,59 :: 		if PWM_SIG=1 then begin
	BTFSS      GP0_bit+0, BitPos(GP0_bit+0)
	GOTO       L__Interrupt5
;12f675-PwmFet.mpas,60 :: 		ON_PWM:=VOL_PWM;
	MOVF       _VOL_PWM+0, 0
	MOVWF      _ON_PWM+0
;12f675-PwmFet.mpas,61 :: 		if ON_PWM=0 then
	MOVF       _VOL_PWM+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Interrupt8
;12f675-PwmFet.mpas,62 :: 		TMR0:=ON_PWM
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
	GOTO       L__Interrupt9
;12f675-PwmFet.mpas,63 :: 		else begin
L__Interrupt8:
;12f675-PwmFet.mpas,64 :: 		TMR0:=PWM_MAX-ON_PWM;
	MOVF       _ON_PWM+0, 0
	SUBLW      255
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,65 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,66 :: 		PWM_SIG:=0;
	BCF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,67 :: 		end;
L__Interrupt9:
;12f675-PwmFet.mpas,68 :: 		end else begin
	GOTO       L__Interrupt6
L__Interrupt5:
;12f675-PwmFet.mpas,69 :: 		TMR0:=ON_PWM;
	MOVF       _ON_PWM+0, 0
	MOVWF      TMR0+0
;12f675-PwmFet.mpas,70 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,71 :: 		PWM_SYNC:=1;
	BSF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,72 :: 		end;
L__Interrupt6:
;12f675-PwmFet.mpas,73 :: 		T0IF_bit:=0;
	BCF        T0IF_bit+0, BitPos(T0IF_bit+0)
;12f675-PwmFet.mpas,74 :: 		end;
L__Interrupt2:
;12f675-PwmFet.mpas,75 :: 		if T1IF_bit=1 then begin
	BTFSS      T1IF_bit+0, BitPos(T1IF_bit+0)
	GOTO       L__Interrupt11
;12f675-PwmFet.mpas,76 :: 		Inc(TICK_1000);
	INCF       _TICK_1000+0, 1
;12f675-PwmFet.mpas,77 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,78 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,79 :: 		if TICK_1000>LED1_Tm then begin
	MOVF       _TICK_1000+0, 0
	SUBWF      _LED1_tm+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__Interrupt14
;12f675-PwmFet.mpas,80 :: 		LED1:=not LED1;
	MOVLW
	XORWF      GP2_bit+0, 1
;12f675-PwmFet.mpas,81 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,82 :: 		end;
L__Interrupt14:
;12f675-PwmFet.mpas,83 :: 		T1IF_bit:=0;
	BCF        T1IF_bit+0, BitPos(T1IF_bit+0)
;12f675-PwmFet.mpas,84 :: 		end;
L__Interrupt11:
;12f675-PwmFet.mpas,85 :: 		if GPIF_bit=1 then begin
	BTFSS      GPIF_bit+0, BitPos(GPIF_bit+0)
	GOTO       L__Interrupt17
;12f675-PwmFet.mpas,86 :: 		if VOut5=0 then
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__Interrupt20
;12f675-PwmFet.mpas,87 :: 		vTarget:=c051
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
	GOTO       L__Interrupt21
;12f675-PwmFet.mpas,88 :: 		else
L__Interrupt20:
;12f675-PwmFet.mpas,89 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
L__Interrupt21:
;12f675-PwmFet.mpas,90 :: 		GPIF_bit:=0;
	BCF        GPIF_bit+0, BitPos(GPIF_bit+0)
;12f675-PwmFet.mpas,91 :: 		end;
L__Interrupt17:
;12f675-PwmFet.mpas,92 :: 		end;
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

_Read_ADC:

;12f675-PwmFet.mpas,95 :: 		begin
;12f675-PwmFet.mpas,96 :: 		if ADON_bit=0 then begin
	BTFSC      ADON_bit+0, BitPos(ADON_bit+0)
	GOTO       L__Read_ADC24
;12f675-PwmFet.mpas,97 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,98 :: 		Delay_22us;
	CALL       _Delay_22us+0
;12f675-PwmFet.mpas,99 :: 		end;
L__Read_ADC24:
;12f675-PwmFet.mpas,100 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,101 :: 		while GO_NOT_DONE_bit=1 do ;
L__Read_ADC27:
	BTFSC      GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
	GOTO       L__Read_ADC27
;12f675-PwmFet.mpas,102 :: 		Hi(adc_vol):=ADRESH;
	MOVF       ADRESH+0, 0
	MOVWF      _adc_vol+1
;12f675-PwmFet.mpas,103 :: 		Lo(adc_vol):=ADRESL;
	MOVF       ADRESL+0, 0
	MOVWF      _adc_vol+0
;12f675-PwmFet.mpas,104 :: 		end;
L_end_Read_ADC:
	RETURN
; end of _Read_ADC

_main:

;12f675-PwmFet.mpas,106 :: 		begin
;12f675-PwmFet.mpas,110 :: 		CMCON:=7;
	MOVLW      7
	MOVWF      CMCON+0
;12f675-PwmFet.mpas,111 :: 		ANSEL:=%00000010;
	MOVLW      2
	MOVWF      ANSEL+0
;12f675-PwmFet.mpas,113 :: 		TRISIO0_bit:=0;
	BCF        TRISIO0_bit+0, BitPos(TRISIO0_bit+0)
;12f675-PwmFet.mpas,114 :: 		TRISIO1_bit:=1;
	BSF        TRISIO1_bit+0, BitPos(TRISIO1_bit+0)
;12f675-PwmFet.mpas,115 :: 		TRISIO2_bit:=0;
	BCF        TRISIO2_bit+0, BitPos(TRISIO2_bit+0)
;12f675-PwmFet.mpas,116 :: 		TRISIO5_bit:=0;  // PWM_SYNC
	BCF        TRISIO5_bit+0, BitPos(TRISIO5_bit+0)
;12f675-PwmFet.mpas,117 :: 		LED1:=0;
	BCF        GP2_bit+0, BitPos(GP2_bit+0)
;12f675-PwmFet.mpas,118 :: 		PWM_SIG:=1;
	BSF        GP0_bit+0, BitPos(GP0_bit+0)
;12f675-PwmFet.mpas,119 :: 		PWM_SYNC:=0;
	BCF        GP5_bit+0, BitPos(GP5_bit+0)
;12f675-PwmFet.mpas,120 :: 		LED1_tm:=250;
	MOVLW      250
	MOVWF      _LED1_tm+0
;12f675-PwmFet.mpas,121 :: 		ON_PWM:=0;
	CLRF       _ON_PWM+0
;12f675-PwmFet.mpas,122 :: 		VOL_PWM:=0;
	CLRF       _VOL_PWM+0
;12f675-PwmFet.mpas,123 :: 		TICK_1000:=0;
	CLRF       _TICK_1000+0
;12f675-PwmFet.mpas,125 :: 		OPTION_REG:=%01010000;        // ~2KHz @ 4MHz, enable weak pull-up
	MOVLW      80
	MOVWF      OPTION_REG+0
;12f675-PwmFet.mpas,126 :: 		TMR0IE_bit:=1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;12f675-PwmFet.mpas,128 :: 		ADCON0:=%10000101;            // ADC config
	MOVLW      133
	MOVWF      ADCON0+0
;12f675-PwmFet.mpas,130 :: 		PEIE_bit:=1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;12f675-PwmFet.mpas,132 :: 		T1CKPS0_bit:=1;               // timer prescaler 1:2
	BSF        T1CKPS0_bit+0, BitPos(T1CKPS0_bit+0)
;12f675-PwmFet.mpas,133 :: 		TMR1CS_bit:=0;
	BCF        TMR1CS_bit+0, BitPos(TMR1CS_bit+0)
;12f675-PwmFet.mpas,134 :: 		TMR1IE_bit:=1;
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;12f675-PwmFet.mpas,135 :: 		TMR1L:=TMR1L_LOAD;
	MOVLW      23
	MOVWF      TMR1L+0
;12f675-PwmFet.mpas,136 :: 		TMR1H:=TMR1H_LOAD;
	MOVLW      252
	MOVWF      TMR1H+0
;12f675-PwmFet.mpas,138 :: 		IOC3_bit:=1;
	BSF        IOC3_bit+0, BitPos(IOC3_bit+0)
;12f675-PwmFet.mpas,139 :: 		GPIE_bit:=1;
	BSF        GPIE_bit+0, BitPos(GPIE_bit+0)
;12f675-PwmFet.mpas,141 :: 		adc_vol:=0;
	CLRF       _adc_vol+0
	CLRF       _adc_vol+1
;12f675-PwmFet.mpas,143 :: 		GIE_bit:=1;                   // enable Interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;12f675-PwmFet.mpas,145 :: 		ADON_bit:=1;
	BSF        ADON_bit+0, BitPos(ADON_bit+0)
;12f675-PwmFet.mpas,146 :: 		TMR1ON_bit:=1;
	BSF        TMR1ON_bit+0, BitPos(TMR1ON_bit+0)
;12f675-PwmFet.mpas,148 :: 		GO_NOT_DONE_bit:=1;
	BSF        GO_NOT_DONE_bit+0, BitPos(GO_NOT_DONE_bit+0)
;12f675-PwmFet.mpas,150 :: 		Delay_10ms;
	CALL       _Delay_10ms+0
;12f675-PwmFet.mpas,152 :: 		if VOut5=0 then begin
	BTFSC      GP3_bit+0, BitPos(GP3_bit+0)
	GOTO       L__main33
;12f675-PwmFet.mpas,153 :: 		vTarget:=c051;
	MOVLW      41
	MOVWF      _vTarget+0
	MOVLW      1
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,154 :: 		end else begin
	GOTO       L__main34
L__main33:
;12f675-PwmFet.mpas,155 :: 		vTarget:=c138;
	MOVLW      35
	MOVWF      _vTarget+0
	MOVLW      3
	MOVWF      _vTarget+1
;12f675-PwmFet.mpas,156 :: 		end;
L__main34:
;12f675-PwmFet.mpas,158 :: 		while True do begin
L__main36:
;12f675-PwmFet.mpas,159 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,160 :: 		if (adc_vol>vTarget) then begin
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main74:
	BTFSC      STATUS+0, 0
	GOTO       L__main41
;12f675-PwmFet.mpas,161 :: 		repeat
L__main43:
;12f675-PwmFet.mpas,162 :: 		if VOL_PWM>PWM_LOW then
	MOVF       _VOL_PWM+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L__main49
;12f675-PwmFet.mpas,163 :: 		Dec(VOL_PWM)
	DECF       _VOL_PWM+0, 1
	GOTO       L__main50
;12f675-PwmFet.mpas,164 :: 		else break;
L__main49:
	GOTO       L__main45
L__main50:
;12f675-PwmFet.mpas,165 :: 		Delay_us(PWM_DELAY);
	MOVLW      146
	MOVWF      R13+0
L__main51:
	DECFSZ     R13+0, 1
	GOTO       L__main51
	NOP
;12f675-PwmFet.mpas,166 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,167 :: 		until adc_vol<=vTarget;
	MOVF       _adc_vol+1, 0
	SUBWF      _vTarget+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVF       _adc_vol+0, 0
	SUBWF      _vTarget+0, 0
L__main75:
	BTFSC      STATUS+0, 0
	GOTO       L__main46
	GOTO       L__main43
L__main46:
L__main45:
;12f675-PwmFet.mpas,168 :: 		end else if (adc_vol<vTarget) then begin
	GOTO       L__main42
L__main41:
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main76:
	BTFSC      STATUS+0, 0
	GOTO       L__main53
;12f675-PwmFet.mpas,169 :: 		repeat
L__main55:
;12f675-PwmFet.mpas,170 :: 		if VOL_PWM<PWM_MAX then
	MOVLW      255
	SUBWF      _VOL_PWM+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main61
;12f675-PwmFet.mpas,171 :: 		Inc(VOL_PWM)
	INCF       _VOL_PWM+0, 1
	GOTO       L__main62
;12f675-PwmFet.mpas,172 :: 		else break;
L__main61:
	GOTO       L__main57
L__main62:
;12f675-PwmFet.mpas,173 :: 		Delay_us(PWM_DELAY);
	MOVLW      146
	MOVWF      R13+0
L__main63:
	DECFSZ     R13+0, 1
	GOTO       L__main63
	NOP
;12f675-PwmFet.mpas,174 :: 		Read_ADC;
	CALL       _Read_ADC+0
;12f675-PwmFet.mpas,175 :: 		until adc_vol>=vTarget;
	MOVF       _vTarget+1, 0
	SUBWF      _adc_vol+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main77
	MOVF       _vTarget+0, 0
	SUBWF      _adc_vol+0, 0
L__main77:
	BTFSC      STATUS+0, 0
	GOTO       L__main58
	GOTO       L__main55
L__main58:
L__main57:
;12f675-PwmFet.mpas,176 :: 		end;
L__main53:
L__main42:
;12f675-PwmFet.mpas,178 :: 		if (Hi(adc_vol)=0) and (Lo(adc_vol)<=cLow) then
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
;12f675-PwmFet.mpas,179 :: 		LED1_tm:=64
	MOVLW      64
	MOVWF      _LED1_tm+0
	GOTO       L__main66
;12f675-PwmFet.mpas,180 :: 		else if VOL_PWM=PWM_MAX then
L__main65:
	MOVF       _VOL_PWM+0, 0
	XORLW      255
	BTFSS      STATUS+0, 2
	GOTO       L__main68
;12f675-PwmFet.mpas,181 :: 		LED1_tm:=128
	MOVLW      128
	MOVWF      _LED1_tm+0
	GOTO       L__main69
;12f675-PwmFet.mpas,182 :: 		else
L__main68:
;12f675-PwmFet.mpas,183 :: 		LED1_tm:=240;
	MOVLW      240
	MOVWF      _LED1_tm+0
L__main69:
L__main66:
;12f675-PwmFet.mpas,184 :: 		end;
	GOTO       L__main36
;12f675-PwmFet.mpas,185 :: 		end.
L_end_main:
	GOTO       $+0
; end of _main
