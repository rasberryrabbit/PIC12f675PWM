EESchema Schematic File Version 2
LIBS:regulator-rescue
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic32mcu
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:Altera
LIBS:analog_devices
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:dspic
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:ir
LIBS:Lattice
LIBS:logo
LIBS:lpc43xx
LIBS:maxim
LIBS:motor_drivers
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:passives
LIBS:pic18
LIBS:Power_Management
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:relays
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:st
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:ttl_ieee
LIBS:video
LIBS:vreg
LIBS:Xicor
LIBS:Zilog
LIBS:regulator-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "PWM Regulator v3"
Date "2015-07-10"
Rev "1.2e"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L PIC12F675-I/P IC1
U 1 1 5562ECDD
P 3200 4350
F 0 "IC1" H 2550 4900 50  0000 L CNN
F 1 "PIC12F675-I/P" H 2550 4800 50  0000 L CNN
F 2 "" H 3200 4350 60  0000 C CNN
F 3 "" H 3200 4350 60  0000 C CNN
	1    3200 4350
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 5562F100
P 4350 4050
F 0 "R1" V 4430 4050 50  0000 C CNN
F 1 "1k" V 4350 4050 50  0000 C CNN
F 2 "" V 4280 4050 30  0000 C CNN
F 3 "" H 4350 4050 30  0000 C CNN
	1    4350 4050
	0    1    1    0   
$EndComp
$Comp
L GND #PWR1
U 1 1 5562F1DC
P 4950 5200
F 0 "#PWR1" H 4950 4950 50  0001 C CNN
F 1 "GND" H 4950 5050 50  0000 C CNN
F 2 "" H 4950 5200 60  0000 C CNN
F 3 "" H 4950 5200 60  0000 C CNN
	1    4950 5200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4950 5000 4950 5200
Wire Wire Line
	2400 5000 2400 4650
Connection ~ 4950 5000
Connection ~ 4950 3150
$Comp
L INDUCTOR L1
U 1 1 5562F5BA
P 7250 3150
F 0 "L1" V 7200 3150 50  0000 C CNN
F 1 "100uH 3A" V 7350 3150 50  0000 C CNN
F 2 "" H 7250 3150 60  0000 C CNN
F 3 "" H 7250 3150 60  0000 C CNN
	1    7250 3150
	0    -1   -1   0   
$EndComp
$Comp
L D_Schottky D1
U 1 1 5562F65F
P 6750 3700
F 0 "D1" H 6750 3800 50  0000 C CNN
F 1 "1N5822" H 6750 3600 50  0000 C CNN
F 2 "" H 6750 3700 60  0000 C CNN
F 3 "" H 6750 3700 60  0000 C CNN
	1    6750 3700
	0    1    1    0   
$EndComp
Wire Wire Line
	6750 5000 6750 3850
Wire Wire Line
	6750 3550 6750 3150
Connection ~ 6750 3150
$Comp
L CP1 C2
U 1 1 5562F717
P 7700 3650
F 0 "C2" H 7725 3750 50  0000 L CNN
F 1 "100u" H 7725 3550 50  0000 L CNN
F 2 "" H 7700 3650 60  0000 C CNN
F 3 "" H 7700 3650 60  0000 C CNN
	1    7700 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7550 3150 10650 3150
Text GLabel 10650 3150 2    60   Output ~ 0
+
$Comp
L LM7805 U1
U 1 1 5562FA2D
P 1500 4100
F 0 "U1" H 1650 3904 60  0000 C CNN
F 1 "LM7805" H 1500 4300 60  0000 C CNN
F 2 "" H 1500 4100 60  0000 C CNN
F 3 "" H 1500 4100 60  0000 C CNN
	1    1500 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 4350 1500 5050
Connection ~ 2400 5000
Wire Wire Line
	1900 4050 2400 4050
$Comp
L CP1 C1
U 1 1 5562FCAD
P 2050 4450
F 0 "C1" H 2075 4550 50  0000 L CNN
F 1 "100uf" H 2075 4350 50  0000 L CNN
F 2 "" H 2050 4450 60  0000 C CNN
F 3 "" H 2050 4450 60  0000 C CNN
	1    2050 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	2050 4600 2050 5000
Connection ~ 2050 5000
$Comp
L R R2
U 1 1 556305A0
P 4600 4550
F 0 "R2" V 4680 4550 50  0000 C CNN
F 1 "10k" V 4600 4550 50  0000 C CNN
F 2 "" V 4530 4550 30  0000 C CNN
F 3 "" H 4600 4550 30  0000 C CNN
	1    4600 4550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 3150 7700 3500
Connection ~ 7700 3150
Wire Wire Line
	7700 5000 7700 3800
Connection ~ 6750 5000
$Comp
L POT RV1
U 1 1 55630C4A
P 8150 4450
F 0 "RV1" H 8150 4350 50  0000 C CNN
F 1 "100k" H 8150 4450 50  0000 C CNN
F 2 "" H 8150 4450 60  0000 C CNN
F 3 "" H 8150 4450 60  0000 C CNN
	1    8150 4450
	0    1    1    0   
$EndComp
$Comp
L R R4
U 1 1 55631075
P 8150 3800
F 0 "R4" V 8230 3800 50  0000 C CNN
F 1 "100k" V 8150 3800 50  0000 C CNN
F 2 "" V 8080 3800 30  0000 C CNN
F 3 "" H 8150 3800 30  0000 C CNN
	1    8150 3800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8150 3150 8150 3650
Connection ~ 8150 3150
Wire Wire Line
	8150 3950 8150 4200
Connection ~ 7700 5000
Wire Wire Line
	4000 4050 4200 4050
Wire Wire Line
	4600 4700 7900 4700
Wire Wire Line
	7900 4700 7900 4100
Wire Wire Line
	7900 4100 8150 4100
Connection ~ 8150 4100
Wire Wire Line
	8300 5000 8300 4450
Text GLabel 10650 5000 2    60   Output ~ 0
-
Connection ~ 8300 5000
$Comp
L Q_NMOS_GDS-RESCUE-regulator Q3
U 1 1 5563B1A2
P 5950 3250
F 0 "Q3" V 6200 3500 50  0000 R CNN
F 1 "BUK9511-55A (Logic Level)" V 6350 3500 50  0000 R CNN
F 2 "" H 6150 3350 29  0000 C CNN
F 3 "" H 5950 3250 60  0000 C CNN
	1    5950 3250
	0    -1   -1   0   
$EndComp
$Comp
L Q_NPN_EBC-RESCUE-regulator Q1
U 1 1 5563BACB
P 5550 3850
F 0 "Q1" H 5850 3900 50  0000 R CNN
F 1 "PN2222A" H 6150 3800 50  0000 R CNN
F 2 "" H 5750 3950 29  0000 C CNN
F 3 "" H 5550 3850 60  0000 C CNN
	1    5550 3850
	1    0    0    -1  
$EndComp
$Comp
L Q_PNP_EBC-RESCUE-regulator Q2
U 1 1 5563BB02
P 5550 4300
F 0 "Q2" H 5850 4350 50  0000 R CNN
F 1 "2N2907A" H 6150 4250 50  0000 R CNN
F 2 "" H 5750 4400 29  0000 C CNN
F 3 "" H 5550 4300 60  0000 C CNN
	1    5550 4300
	1    0    0    1   
$EndComp
Wire Wire Line
	5350 3750 5350 4300
$Comp
L D D2
U 1 1 5563BF9E
P 4250 3350
F 0 "D2" H 4250 3450 50  0000 C CNN
F 1 "1N4004" H 4250 3250 50  0000 C CNN
F 2 "" H 4250 3350 60  0000 C CNN
F 3 "" H 4250 3350 60  0000 C CNN
	1    4250 3350
	-1   0    0    1   
$EndComp
$Comp
L CP C3
U 1 1 5563CD46
P 6200 4050
F 0 "C3" H 6225 4150 50  0000 L CNN
F 1 "1u" H 6225 3950 50  0000 L CNN
F 2 "" H 6238 3900 30  0000 C CNN
F 3 "" H 6200 4050 60  0000 C CNN
	1    6200 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 4150 4600 4150
Wire Wire Line
	4600 4150 4600 4400
$Comp
L Q_NPN_EBC-RESCUE-regulator Q4
U 1 1 55642E1A
P 4700 4050
F 0 "Q4" H 5000 4100 50  0000 R CNN
F 1 "PN2222A" H 5300 4000 50  0000 R CNN
F 2 "" H 4900 4150 29  0000 C CNN
F 3 "" H 4700 4050 60  0000 C CNN
	1    4700 4050
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 55643032
P 5050 3750
F 0 "R5" V 5130 3750 50  0000 C CNN
F 1 "1k" V 5050 3750 50  0000 C CNN
F 2 "" V 4980 3750 30  0000 C CNN
F 3 "" H 5050 3750 30  0000 C CNN
	1    5050 3750
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 556430B0
P 4800 3550
F 0 "R3" V 4880 3550 50  0000 C CNN
F 1 "10k" V 4800 3550 50  0000 C CNN
F 2 "" V 4730 3550 30  0000 C CNN
F 3 "" H 4800 3550 30  0000 C CNN
	1    4800 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 3700 4800 3850
Wire Wire Line
	4800 3400 4800 3350
Wire Wire Line
	4400 3350 6200 3350
Wire Wire Line
	4900 3750 4800 3750
Connection ~ 4800 3750
Wire Wire Line
	4800 5000 4800 4250
Connection ~ 4800 5000
Wire Wire Line
	5200 3750 5350 3750
Connection ~ 5350 3850
Wire Wire Line
	6200 4200 6200 4500
Wire Wire Line
	5950 4050 5950 3450
Connection ~ 4800 3350
Wire Wire Line
	6200 3350 6200 3900
Connection ~ 5650 3350
Wire Wire Line
	5650 3350 5650 3650
Wire Wire Line
	6350 4500 6350 3150
Connection ~ 6350 3150
Wire Wire Line
	1500 5000 10650 5000
Wire Wire Line
	2050 3350 2050 4300
Connection ~ 2050 4050
Wire Wire Line
	5650 4050 5650 4100
Wire Wire Line
	5650 4500 6350 4500
Connection ~ 6200 4500
Wire Wire Line
	5950 4050 5650 4050
Text Label 4050 4050 0    60   ~ 0
PWM
Text Label 5100 3350 0    60   ~ 0
BootStrap
Text Label 5050 4700 0    60   ~ 0
FEEDBACK
$Comp
L D_Schottky D3
U 1 1 55680546
P 6550 3150
F 0 "D3" H 6550 3250 50  0000 C CNN
F 1 "1N5822" H 6550 3050 50  0000 C CNN
F 2 "" H 6550 3150 60  0000 C CNN
F 3 "" H 6550 3150 60  0000 C CNN
	1    6550 3150
	-1   0    0    1   
$EndComp
Wire Wire Line
	6700 3150 6950 3150
Wire Wire Line
	6150 3150 6400 3150
Wire Wire Line
	1100 3150 1100 4050
Text GLabel 1500 2800 0    60   Input ~ 0
Vin(14+)
Wire Wire Line
	4950 2800 4950 3150
Text GLabel 1250 5050 0    60   Input ~ 0
Vin-
Wire Wire Line
	1500 5050 1250 5050
Connection ~ 1500 5000
$Comp
L LED D4
U 1 1 55680B3B
P 4400 4750
F 0 "D4" H 4400 4850 50  0000 C CNN
F 1 "LED" H 4400 4650 50  0000 C CNN
F 2 "" H 4400 4750 60  0000 C CNN
F 3 "" H 4400 4750 60  0000 C CNN
	1    4400 4750
	0    -1   -1   0   
$EndComp
$Comp
L R R6
U 1 1 55680C08
P 4200 4250
F 0 "R6" V 4280 4250 50  0000 C CNN
F 1 "1k" V 4200 4250 50  0000 C CNN
F 2 "" V 4130 4250 30  0000 C CNN
F 3 "" H 4200 4250 30  0000 C CNN
	1    4200 4250
	0    1    1    0   
$EndComp
Wire Wire Line
	4050 4250 4000 4250
Wire Wire Line
	4350 4250 4400 4250
Wire Wire Line
	4400 4250 4400 4550
Wire Wire Line
	4400 4950 4400 5000
Connection ~ 4400 5000
Wire Wire Line
	2050 3350 4100 3350
Wire Wire Line
	2850 3150 5750 3150
$Comp
L D D5
U 1 1 558499A4
P 2700 3150
F 0 "D5" H 2700 3250 50  0000 C CNN
F 1 "1N4007" H 2700 3050 50  0000 C CNN
F 2 "" H 2700 3150 60  0000 C CNN
F 3 "" H 2700 3150 60  0000 C CNN
	1    2700 3150
	1    0    0    1   
$EndComp
Wire Wire Line
	2550 3150 1100 3150
Wire Wire Line
	1500 2800 4950 2800
$Comp
L CP C4
U 1 1 559FC9C7
P 8650 3700
F 0 "C4" H 8675 3800 50  0000 L CNN
F 1 "3300u" H 8675 3600 50  0000 L CNN
F 2 "" H 8688 3550 30  0000 C CNN
F 3 "" H 8650 3700 60  0000 C CNN
	1    8650 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	8650 3550 8650 3150
Connection ~ 8650 3150
Wire Wire Line
	8650 3850 8650 5000
Connection ~ 8650 5000
$Comp
L C C5
U 1 1 559FCBD8
P 9000 3700
F 0 "C5" H 9025 3800 50  0000 L CNN
F 1 "0.01u" H 9025 3600 50  0000 L CNN
F 2 "" H 9038 3550 30  0000 C CNN
F 3 "" H 9000 3700 60  0000 C CNN
	1    9000 3700
	1    0    0    -1  
$EndComp
$Comp
L Q_NMOS_GDS-RESCUE-regulator Q5
U 1 1 559FCD3F
P 9800 4550
F 0 "Q5" H 10100 4500 50  0000 R CNN
F 1 "BUK9511-55A (Logic Level)" H 10400 4850 50  0000 R CNN
F 2 "" H 10000 4650 29  0000 C CNN
F 3 "" H 9800 4550 60  0000 C CNN
	1    9800 4550
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 559FD8A6
P 9400 4550
F 0 "R7" V 9480 4550 50  0000 C CNN
F 1 "1k" V 9400 4550 50  0000 C CNN
F 2 "" V 9330 4550 30  0000 C CNN
F 3 "" H 9400 4550 30  0000 C CNN
	1    9400 4550
	0    1    1    0   
$EndComp
Wire Wire Line
	4200 5500 9250 5500
Wire Wire Line
	9550 4550 9600 4550
Wire Wire Line
	9250 5500 9250 4550
Wire Wire Line
	9900 4750 9900 5000
Connection ~ 9900 5000
Text GLabel 10650 3850 2    60   Output ~ 0
E-
Wire Wire Line
	10650 3850 9900 3850
Wire Wire Line
	9900 3850 9900 4350
Wire Wire Line
	9000 3850 9000 5000
Connection ~ 9000 5000
Wire Wire Line
	9000 3550 9000 3150
Connection ~ 9000 3150
$Comp
L R R8
U 1 1 55A0233C
P 3650 3650
F 0 "R8" V 3730 3650 50  0000 C CNN
F 1 "10k" V 3650 3650 50  0000 C CNN
F 2 "" V 3580 3650 30  0000 C CNN
F 3 "" H 3650 3650 30  0000 C CNN
	1    3650 3650
	0    1    1    0   
$EndComp
Wire Wire Line
	3800 3650 4000 3650
Wire Wire Line
	4000 3650 4000 4350
Wire Wire Line
	3500 3650 3350 3650
Wire Wire Line
	3350 3650 3350 3350
Connection ~ 3350 3350
Wire Wire Line
	4000 4550 4200 4550
Wire Wire Line
	4200 4550 4200 5500
Text Label 4000 3850 2    60   ~ 0
5Vout(GND)
Text Label 4800 5500 2    60   ~ 0
SolarEngine
Text Notes 3900 5250 2    60   ~ 0
GP3 (GND) = 5v\nGP4 (GND) = Check Charging
$EndSCHEMATC
