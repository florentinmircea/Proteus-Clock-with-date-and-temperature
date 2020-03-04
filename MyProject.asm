
_init_timer:

;MyProject.c,37 :: 		void init_timer()
;MyProject.c,39 :: 		SREG |= 1<<7; //activam intreruperile
	IN         R27, SREG+0
	SBR        R27, 128
	OUT        SREG+0, R27
;MyProject.c,40 :: 		TCCR0 = 0b00001011; //CTC-3,6, Prescaler-0,1,2
	LDI        R27, 11
	OUT        TCCR0+0, R27
;MyProject.c,41 :: 		TCNT0 = 0;
	LDI        R27, 0
	OUT        TCNT0+0, R27
;MyProject.c,42 :: 		OCR0 = 125;
	LDI        R27, 125
	OUT        OCR0+0, R27
;MyProject.c,43 :: 		TIMSK |= 0b00000010;//set interrupt OCM
	IN         R16, TIMSK+0
	ORI        R16, 2
	OUT        TIMSK+0, R16
;MyProject.c,45 :: 		}
L_end_init_timer:
	RET
; end of _init_timer

_Init_adc:

;MyProject.c,48 :: 		void Init_adc(){
;MyProject.c,49 :: 		ADMUX = 0b01000000; //Referin.a - AVCC
	LDI        R27, 64
	OUT        ADMUX+0, R27
;MyProject.c,50 :: 		ADCSRA = 0b10000111; //Activare ADC; Prescaler = 128;
	LDI        R27, 135
	OUT        ADCSRA+0, R27
;MyProject.c,51 :: 		}
L_end_Init_adc:
	RET
; end of _Init_adc

_readADC:

;MyProject.c,53 :: 		int readADC(char ch){
;MyProject.c,54 :: 		ADMUX &= 0b11100000;
	IN         R16, ADMUX+0
	ANDI       R16, 224
	OUT        ADMUX+0, R16
;MyProject.c,55 :: 		ADMUX |= ch;
	OR         R16, R2
	OUT        ADMUX+0, R16
;MyProject.c,56 :: 		ADCSRA |= 1<<6;
	IN         R27, ADCSRA+0
	SBR        R27, 64
	OUT        ADCSRA+0, R27
;MyProject.c,58 :: 		adclow = ADCL;
	IN         R16, ADCL+0
	STS        _adclow+0, R16
;MyProject.c,59 :: 		adchigh = ADCH;
	IN         R16, ADCH+0
	STS        _adchigh+0, R16
;MyProject.c,60 :: 		return  adchigh<<8 | adclow;   //Returneaza rezultatul conversiei
	LDS        R16, _adchigh+0
	MOV        R19, R16
	CLR        R18
	LDS        R16, _adclow+0
	LDI        R17, 0
	OR         R16, R18
	OR         R17, R19
;MyProject.c,61 :: 		}
L_end_readADC:
	RET
; end of _readADC

_readADC_interrupt:

;MyProject.c,64 :: 		void readADC_interrupt(char ch){
;MyProject.c,65 :: 		ADMUX &= 0b11100000; //Reseteazã canalul de conversie
	IN         R16, ADMUX+0
	ANDI       R16, 224
	OUT        ADMUX+0, R16
;MyProject.c,66 :: 		ADMUX |= ch; //Seteazã canalul
	OR         R16, R2
	OUT        ADMUX+0, R16
;MyProject.c,67 :: 		ADCSRA |= (1<<6); //Începe conversia
	IN         R27, ADCSRA+0
	SBR        R27, 64
	OUT        ADCSRA+0, R27
;MyProject.c,68 :: 		}
L_end_readADC_interrupt:
	RET
; end of _readADC_interrupt

_display:

;MyProject.c,70 :: 		void display(char p, char c)
;MyProject.c,72 :: 		PORTA&=0b11000000; //linii selectie oprite
	IN         R16, PORTA+0
	ANDI       R16, 192
	OUT        PORTA+0, R16
;MyProject.c,73 :: 		PORTC&=0b00000000; //initializare 7 segmente cu toate segmentele oprite
	IN         R16, PORTC+0
	ANDI       R16, 0
	OUT        PORTC+0, R16
;MyProject.c,74 :: 		switch(c)
	JMP        L_display0
;MyProject.c,76 :: 		case 0:
L_display2:
;MyProject.c,77 :: 		PORTC|=0b00111111;
	IN         R16, PORTC+0
	ORI        R16, 63
	OUT        PORTC+0, R16
;MyProject.c,78 :: 		break;
	JMP        L_display1
;MyProject.c,79 :: 		case 1:
L_display3:
;MyProject.c,80 :: 		PORTC|=0b00000110;
	IN         R16, PORTC+0
	ORI        R16, 6
	OUT        PORTC+0, R16
;MyProject.c,81 :: 		break;
	JMP        L_display1
;MyProject.c,82 :: 		case 2:
L_display4:
;MyProject.c,83 :: 		PORTC|=0b01011011;
	IN         R16, PORTC+0
	ORI        R16, 91
	OUT        PORTC+0, R16
;MyProject.c,84 :: 		break;
	JMP        L_display1
;MyProject.c,85 :: 		case 3:
L_display5:
;MyProject.c,86 :: 		PORTC|=0b01001111;
	IN         R16, PORTC+0
	ORI        R16, 79
	OUT        PORTC+0, R16
;MyProject.c,87 :: 		break;
	JMP        L_display1
;MyProject.c,88 :: 		case 4:
L_display6:
;MyProject.c,89 :: 		PORTC|=0b01100110;
	IN         R16, PORTC+0
	ORI        R16, 102
	OUT        PORTC+0, R16
;MyProject.c,90 :: 		break;
	JMP        L_display1
;MyProject.c,91 :: 		case 5:
L_display7:
;MyProject.c,92 :: 		PORTC|=0b01101101;
	IN         R16, PORTC+0
	ORI        R16, 109
	OUT        PORTC+0, R16
;MyProject.c,93 :: 		break;
	JMP        L_display1
;MyProject.c,94 :: 		case 6:
L_display8:
;MyProject.c,95 :: 		PORTC|=0b01111101;
	IN         R16, PORTC+0
	ORI        R16, 125
	OUT        PORTC+0, R16
;MyProject.c,96 :: 		break;
	JMP        L_display1
;MyProject.c,97 :: 		case 7:
L_display9:
;MyProject.c,98 :: 		PORTC|=0b00000111;
	IN         R16, PORTC+0
	ORI        R16, 7
	OUT        PORTC+0, R16
;MyProject.c,99 :: 		break;
	JMP        L_display1
;MyProject.c,100 :: 		case 8:
L_display10:
;MyProject.c,101 :: 		PORTC|=0b01111111;
	IN         R16, PORTC+0
	ORI        R16, 127
	OUT        PORTC+0, R16
;MyProject.c,102 :: 		break;
	JMP        L_display1
;MyProject.c,103 :: 		case 9:
L_display11:
;MyProject.c,104 :: 		PORTC|=0b01101111;
	IN         R16, PORTC+0
	ORI        R16, 111
	OUT        PORTC+0, R16
;MyProject.c,105 :: 		break;
	JMP        L_display1
;MyProject.c,106 :: 		case 10:
L_display12:
;MyProject.c,107 :: 		PORTC|=0b01100011;
	IN         R16, PORTC+0
	ORI        R16, 99
	OUT        PORTC+0, R16
;MyProject.c,108 :: 		break;
	JMP        L_display1
;MyProject.c,109 :: 		case 11:
L_display13:
;MyProject.c,110 :: 		PORTC|=0b0111001;
	IN         R16, PORTC+0
	ORI        R16, 57
	OUT        PORTC+0, R16
;MyProject.c,111 :: 		break;
	JMP        L_display1
;MyProject.c,113 :: 		}
L_display0:
	LDI        R27, 0
	CP         R3, R27
	BRNE       L__display100
	JMP        L_display2
L__display100:
	LDI        R27, 1
	CP         R3, R27
	BRNE       L__display101
	JMP        L_display3
L__display101:
	LDI        R27, 2
	CP         R3, R27
	BRNE       L__display102
	JMP        L_display4
L__display102:
	LDI        R27, 3
	CP         R3, R27
	BRNE       L__display103
	JMP        L_display5
L__display103:
	LDI        R27, 4
	CP         R3, R27
	BRNE       L__display104
	JMP        L_display6
L__display104:
	LDI        R27, 5
	CP         R3, R27
	BRNE       L__display105
	JMP        L_display7
L__display105:
	LDI        R27, 6
	CP         R3, R27
	BRNE       L__display106
	JMP        L_display8
L__display106:
	LDI        R27, 7
	CP         R3, R27
	BRNE       L__display107
	JMP        L_display9
L__display107:
	LDI        R27, 8
	CP         R3, R27
	BRNE       L__display108
	JMP        L_display10
L__display108:
	LDI        R27, 9
	CP         R3, R27
	BRNE       L__display109
	JMP        L_display11
L__display109:
	LDI        R27, 10
	CP         R3, R27
	BRNE       L__display110
	JMP        L_display12
L__display110:
	LDI        R27, 11
	CP         R3, R27
	BRNE       L__display111
	JMP        L_display13
L__display111:
L_display1:
;MyProject.c,114 :: 		switch(p)
	JMP        L_display14
;MyProject.c,116 :: 		case 6:
L_display16:
;MyProject.c,117 :: 		PORTA|=0b00110111;
	IN         R16, PORTA+0
	ORI        R16, 55
	OUT        PORTA+0, R16
;MyProject.c,118 :: 		break;
	JMP        L_display15
;MyProject.c,119 :: 		case 5:
L_display17:
;MyProject.c,120 :: 		PORTA|=0b00111011;
	IN         R16, PORTA+0
	ORI        R16, 59
	OUT        PORTA+0, R16
;MyProject.c,121 :: 		break;
	JMP        L_display15
;MyProject.c,122 :: 		case 4:
L_display18:
;MyProject.c,123 :: 		PORTA|=0b00111101;
	IN         R16, PORTA+0
	ORI        R16, 61
	OUT        PORTA+0, R16
;MyProject.c,124 :: 		break;
	JMP        L_display15
;MyProject.c,125 :: 		case 3:
L_display19:
;MyProject.c,126 :: 		PORTA|=0b00111110;
	IN         R16, PORTA+0
	ORI        R16, 62
	OUT        PORTA+0, R16
;MyProject.c,127 :: 		break;
	JMP        L_display15
;MyProject.c,128 :: 		case 2:
L_display20:
;MyProject.c,129 :: 		PORTA|=0b00101111;
	IN         R16, PORTA+0
	ORI        R16, 47
	OUT        PORTA+0, R16
;MyProject.c,130 :: 		break;
	JMP        L_display15
;MyProject.c,131 :: 		case 1:
L_display21:
;MyProject.c,132 :: 		PORTA|=0b00011111;
	IN         R16, PORTA+0
	ORI        R16, 31
	OUT        PORTA+0, R16
;MyProject.c,133 :: 		break;
	JMP        L_display15
;MyProject.c,134 :: 		}
L_display14:
	LDI        R27, 6
	CP         R2, R27
	BRNE       L__display112
	JMP        L_display16
L__display112:
	LDI        R27, 5
	CP         R2, R27
	BRNE       L__display113
	JMP        L_display17
L__display113:
	LDI        R27, 4
	CP         R2, R27
	BRNE       L__display114
	JMP        L_display18
L__display114:
	LDI        R27, 3
	CP         R2, R27
	BRNE       L__display115
	JMP        L_display19
L__display115:
	LDI        R27, 2
	CP         R2, R27
	BRNE       L__display116
	JMP        L_display20
L__display116:
	LDI        R27, 1
	CP         R2, R27
	BRNE       L__display117
	JMP        L_display21
L__display117:
L_display15:
;MyProject.c,135 :: 		}
L_end_display:
	RET
; end of _display

_ADC_Completed:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;MyProject.c,137 :: 		void ADC_Completed() iv IVT_ADDR_ADC{
;MyProject.c,138 :: 		adclow = ADCL;
	IN         R16, ADCL+0
	STS        _adclow+0, R16
;MyProject.c,139 :: 		adchigh = ADCH;
	IN         R16, ADCH+0
	STS        _adchigh+0, R16
;MyProject.c,140 :: 		adc = (adchigh << 8) | adclow;
	LDS        R16, _adchigh+0
	MOV        R19, R16
	CLR        R18
	LDS        R16, _adclow+0
	LDI        R17, 0
	OR         R16, R18
	OR         R17, R19
	STS        _adc+0, R16
	STS        _adc+1, R17
;MyProject.c,141 :: 		Vin = ((float)adc*5)/1024;
	LDI        R18, 0
	SBRC       R17, 7
	LDI        R18, 255
	MOV        R19, R18
	CALL       _float_slong2fp+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 160
	LDI        R23, 64
	CALL       _float_fpmul1+0
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 128
	LDI        R23, 68
	CALL       _float_fpdiv1+0
	STS        _Vin+0, R16
	STS        _Vin+1, R17
	STS        _Vin+2, R18
	STS        _Vin+3, R19
;MyProject.c,142 :: 		tmp = Vin*1000;
	LDI        R20, 0
	LDI        R21, 0
	LDI        R22, 122
	LDI        R23, 68
	CALL       _float_fpmul1+0
	STS        _tmp+0, R16
	STS        _tmp+1, R17
	STS        _tmp+2, R18
	STS        _tmp+3, R19
;MyProject.c,143 :: 		T = (int)tmp;
	CALL       _float_fpint+0
	STS        _T+0, R16
	STS        _T+1, R17
;MyProject.c,144 :: 		}
L_end_ADC_Completed:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _ADC_Completed

_Timer0_ISR:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;MyProject.c,150 :: 		void Timer0_ISR() iv IVT_ADDR_TIMER0_COMP
;MyProject.c,153 :: 		if(optiune==0 && valid==0)//afisare ora cu minute si secunde
	PUSH       R2
	PUSH       R3
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR120
	CPI        R16, 0
L__Timer0_ISR120:
	BREQ       L__Timer0_ISR121
	JMP        L__Timer0_ISR92
L__Timer0_ISR121:
	LDS        R16, _valid+0
	LDS        R17, _valid+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR122
	CPI        R16, 0
L__Timer0_ISR122:
	BREQ       L__Timer0_ISR123
	JMP        L__Timer0_ISR91
L__Timer0_ISR123:
L__Timer0_ISR90:
;MyProject.c,155 :: 		digit++;
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _digit+0, R16
	STS        _digit+1, R17
;MyProject.c,156 :: 		switch(digit){
	JMP        L_Timer0_ISR25
;MyProject.c,157 :: 		case 1: display(1,s%10); break;
L_Timer0_ISR27:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _s+0
	LDS        R17, _s+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR26
;MyProject.c,158 :: 		case 2: display(2,(s/10)%10); break;
L_Timer0_ISR28:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _s+0
	LDS        R17, _s+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR26
;MyProject.c,159 :: 		case 3: display(3,m%10); break;
L_Timer0_ISR29:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _m+0
	LDS        R17, _m+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 3
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR26
;MyProject.c,160 :: 		case 4: display(4,(m/10)%10); break;
L_Timer0_ISR30:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _m+0
	LDS        R17, _m+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 4
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR26
;MyProject.c,161 :: 		case 5: display(5,ho%10); break;
L_Timer0_ISR31:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _ho+0
	LDS        R17, _ho+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR26
;MyProject.c,162 :: 		case 6: display(6,(ho/10)%10); digit=0; break;
L_Timer0_ISR32:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _ho+0
	LDS        R17, _ho+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _display+0
	LDI        R27, 0
	STS        _digit+0, R27
	STS        _digit+1, R27
	JMP        L_Timer0_ISR26
;MyProject.c,163 :: 		}
L_Timer0_ISR25:
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR124
	CPI        R16, 1
L__Timer0_ISR124:
	BRNE       L__Timer0_ISR125
	JMP        L_Timer0_ISR27
L__Timer0_ISR125:
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR126
	CPI        R16, 2
L__Timer0_ISR126:
	BRNE       L__Timer0_ISR127
	JMP        L_Timer0_ISR28
L__Timer0_ISR127:
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR128
	CPI        R16, 3
L__Timer0_ISR128:
	BRNE       L__Timer0_ISR129
	JMP        L_Timer0_ISR29
L__Timer0_ISR129:
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR130
	CPI        R16, 4
L__Timer0_ISR130:
	BRNE       L__Timer0_ISR131
	JMP        L_Timer0_ISR30
L__Timer0_ISR131:
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR132
	CPI        R16, 5
L__Timer0_ISR132:
	BRNE       L__Timer0_ISR133
	JMP        L_Timer0_ISR31
L__Timer0_ISR133:
	LDS        R16, _digit+0
	LDS        R17, _digit+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR134
	CPI        R16, 6
L__Timer0_ISR134:
	BRNE       L__Timer0_ISR135
	JMP        L_Timer0_ISR32
L__Timer0_ISR135:
L_Timer0_ISR26:
;MyProject.c,153 :: 		if(optiune==0 && valid==0)//afisare ora cu minute si secunde
L__Timer0_ISR92:
L__Timer0_ISR91:
;MyProject.c,165 :: 		if(optiune==1 && valid==0)  //afisare data
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR136
	CPI        R16, 1
L__Timer0_ISR136:
	BREQ       L__Timer0_ISR137
	JMP        L__Timer0_ISR94
L__Timer0_ISR137:
	LDS        R16, _valid+0
	LDS        R17, _valid+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR138
	CPI        R16, 0
L__Timer0_ISR138:
	BREQ       L__Timer0_ISR139
	JMP        L__Timer0_ISR93
L__Timer0_ISR139:
L__Timer0_ISR89:
;MyProject.c,167 :: 		digit1++;
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _digit1+0, R16
	STS        _digit1+1, R17
;MyProject.c,168 :: 		switch(digit1){
	JMP        L_Timer0_ISR36
;MyProject.c,169 :: 		case 1: display(1,year%10); break;
L_Timer0_ISR38:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _year+0
	LDS        R17, _year+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 1
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR37
;MyProject.c,170 :: 		case 2: display(2,(year/10)%10); break;
L_Timer0_ISR39:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _year+0
	LDS        R17, _year+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 2
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR37
;MyProject.c,171 :: 		case 3: display(3,month%10); break;
L_Timer0_ISR40:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _month+0
	LDS        R17, _month+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 3
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR37
;MyProject.c,172 :: 		case 4: display(4,(month/10)%10); break;
L_Timer0_ISR41:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _month+0
	LDS        R17, _month+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 4
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR37
;MyProject.c,173 :: 		case 5: display(5,day%10); break;
L_Timer0_ISR42:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _day+0
	LDS        R17, _day+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 5
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR37
;MyProject.c,174 :: 		case 6: display(6,(day/10)%10); digit1=0; break;
L_Timer0_ISR43:
	LDI        R20, 10
	LDI        R21, 0
	LDS        R16, _day+0
	LDS        R17, _day+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 6
	MOV        R2, R27
	CALL       _display+0
	LDI        R27, 0
	STS        _digit1+0, R27
	STS        _digit1+1, R27
	JMP        L_Timer0_ISR37
;MyProject.c,175 :: 		}
L_Timer0_ISR36:
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR140
	CPI        R16, 1
L__Timer0_ISR140:
	BRNE       L__Timer0_ISR141
	JMP        L_Timer0_ISR38
L__Timer0_ISR141:
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR142
	CPI        R16, 2
L__Timer0_ISR142:
	BRNE       L__Timer0_ISR143
	JMP        L_Timer0_ISR39
L__Timer0_ISR143:
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR144
	CPI        R16, 3
L__Timer0_ISR144:
	BRNE       L__Timer0_ISR145
	JMP        L_Timer0_ISR40
L__Timer0_ISR145:
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR146
	CPI        R16, 4
L__Timer0_ISR146:
	BRNE       L__Timer0_ISR147
	JMP        L_Timer0_ISR41
L__Timer0_ISR147:
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR148
	CPI        R16, 5
L__Timer0_ISR148:
	BRNE       L__Timer0_ISR149
	JMP        L_Timer0_ISR42
L__Timer0_ISR149:
	LDS        R16, _digit1+0
	LDS        R17, _digit1+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR150
	CPI        R16, 6
L__Timer0_ISR150:
	BRNE       L__Timer0_ISR151
	JMP        L_Timer0_ISR43
L__Timer0_ISR151:
L_Timer0_ISR37:
;MyProject.c,165 :: 		if(optiune==1 && valid==0)  //afisare data
L__Timer0_ISR94:
L__Timer0_ISR93:
;MyProject.c,177 :: 		if(valid==1)   //afisare temperatura
	LDS        R16, _valid+0
	LDS        R17, _valid+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR152
	CPI        R16, 1
L__Timer0_ISR152:
	BREQ       L__Timer0_ISR153
	JMP        L_Timer0_ISR44
L__Timer0_ISR153:
;MyProject.c,179 :: 		digit2++;
	LDS        R16, _digit2+0
	LDS        R17, _digit2+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _digit2+0, R16
	STS        _digit2+1, R17
;MyProject.c,180 :: 		switch(digit2)
	JMP        L_Timer0_ISR45
;MyProject.c,182 :: 		case 1: display(1,11); break;
L_Timer0_ISR47:
	LDI        R27, 11
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR46
;MyProject.c,183 :: 		case 2: display(2,10);break;
L_Timer0_ISR48:
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR46
;MyProject.c,184 :: 		case 3: display(3,(value/2)%10); break;
L_Timer0_ISR49:
	LDI        R20, 2
	LDI        R21, 0
	LDS        R16, _value+0
	LDS        R17, _value+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 3
	MOV        R2, R27
	CALL       _display+0
	JMP        L_Timer0_ISR46
;MyProject.c,185 :: 		case 4: display(4,((value/2)/10)%10);  digit2=0;  break;
L_Timer0_ISR50:
	LDI        R20, 2
	LDI        R21, 0
	LDS        R16, _value+0
	LDS        R17, _value+1
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	MOV        R3, R16
	LDI        R27, 4
	MOV        R2, R27
	CALL       _display+0
	LDI        R27, 0
	STS        _digit2+0, R27
	STS        _digit2+1, R27
	JMP        L_Timer0_ISR46
;MyProject.c,186 :: 		}
L_Timer0_ISR45:
	LDS        R16, _digit2+0
	LDS        R17, _digit2+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR154
	CPI        R16, 1
L__Timer0_ISR154:
	BRNE       L__Timer0_ISR155
	JMP        L_Timer0_ISR47
L__Timer0_ISR155:
	LDS        R16, _digit2+0
	LDS        R17, _digit2+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR156
	CPI        R16, 2
L__Timer0_ISR156:
	BRNE       L__Timer0_ISR157
	JMP        L_Timer0_ISR48
L__Timer0_ISR157:
	LDS        R16, _digit2+0
	LDS        R17, _digit2+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR158
	CPI        R16, 3
L__Timer0_ISR158:
	BRNE       L__Timer0_ISR159
	JMP        L_Timer0_ISR49
L__Timer0_ISR159:
	LDS        R16, _digit2+0
	LDS        R17, _digit2+1
	CPI        R17, 0
	BRNE       L__Timer0_ISR160
	CPI        R16, 4
L__Timer0_ISR160:
	BRNE       L__Timer0_ISR161
	JMP        L_Timer0_ISR50
L__Timer0_ISR161:
L_Timer0_ISR46:
;MyProject.c,187 :: 		if(ms==999)
	LDS        R16, _ms+0
	LDS        R17, _ms+1
	CPI        R17, 3
	BRNE       L__Timer0_ISR162
	CPI        R16, 231
L__Timer0_ISR162:
	BREQ       L__Timer0_ISR163
	JMP        L_Timer0_ISR51
L__Timer0_ISR163:
;MyProject.c,189 :: 		value=readADC(7);  //citire senzor temperatura din secunda in secunda
	LDI        R27, 7
	MOV        R2, R27
	CALL       _readADC+0
	STS        _value+0, R16
	STS        _value+1, R17
;MyProject.c,190 :: 		}
L_Timer0_ISR51:
;MyProject.c,192 :: 		}
L_Timer0_ISR44:
;MyProject.c,194 :: 		if (ms == 999){
	LDS        R16, _ms+0
	LDS        R17, _ms+1
	CPI        R17, 3
	BRNE       L__Timer0_ISR164
	CPI        R16, 231
L__Timer0_ISR164:
	BREQ       L__Timer0_ISR165
	JMP        L_Timer0_ISR52
L__Timer0_ISR165:
;MyProject.c,195 :: 		s++;
	LDS        R16, _s+0
	LDS        R17, _s+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _s+0, R16
	STS        _s+1, R17
;MyProject.c,196 :: 		ms = 0;
	LDI        R27, 0
	STS        _ms+0, R27
	STS        _ms+1, R27
;MyProject.c,197 :: 		if(s == 60){
	CPI        R17, 0
	BRNE       L__Timer0_ISR166
	CPI        R16, 60
L__Timer0_ISR166:
	BREQ       L__Timer0_ISR167
	JMP        L_Timer0_ISR53
L__Timer0_ISR167:
;MyProject.c,198 :: 		s = 0;
	LDI        R27, 0
	STS        _s+0, R27
	STS        _s+1, R27
;MyProject.c,199 :: 		m++;
	LDS        R16, _m+0
	LDS        R17, _m+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _m+0, R16
	STS        _m+1, R17
;MyProject.c,200 :: 		if(m==60)
	CPI        R17, 0
	BRNE       L__Timer0_ISR168
	CPI        R16, 60
L__Timer0_ISR168:
	BREQ       L__Timer0_ISR169
	JMP        L_Timer0_ISR54
L__Timer0_ISR169:
;MyProject.c,202 :: 		m=0;
	LDI        R27, 0
	STS        _m+0, R27
	STS        _m+1, R27
;MyProject.c,203 :: 		ho++;
	LDS        R16, _ho+0
	LDS        R17, _ho+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _ho+0, R16
	STS        _ho+1, R17
;MyProject.c,204 :: 		if(ho==24)
	CPI        R17, 0
	BRNE       L__Timer0_ISR170
	CPI        R16, 24
L__Timer0_ISR170:
	BREQ       L__Timer0_ISR171
	JMP        L_Timer0_ISR55
L__Timer0_ISR171:
;MyProject.c,206 :: 		day++;
	LDS        R16, _day+0
	LDS        R17, _day+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _day+0, R18
	STS        _day+1, R19
;MyProject.c,207 :: 		ho=0;
	LDI        R27, 0
	STS        _ho+0, R27
	STS        _ho+1, R27
;MyProject.c,208 :: 		if(day>31)
	LDI        R16, 31
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__Timer0_ISR172
	JMP        L_Timer0_ISR56
L__Timer0_ISR172:
;MyProject.c,210 :: 		day=1;
	LDI        R27, 1
	STS        _day+0, R27
	LDI        R27, 0
	STS        _day+1, R27
;MyProject.c,211 :: 		month++;
	LDS        R16, _month+0
	LDS        R17, _month+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _month+0, R18
	STS        _month+1, R19
;MyProject.c,212 :: 		if(month>12)
	LDI        R16, 12
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__Timer0_ISR173
	JMP        L_Timer0_ISR57
L__Timer0_ISR173:
;MyProject.c,214 :: 		year++;
	LDS        R16, _year+0
	LDS        R17, _year+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _year+0, R16
	STS        _year+1, R17
;MyProject.c,215 :: 		month=1;
	LDI        R27, 1
	STS        _month+0, R27
	LDI        R27, 0
	STS        _month+1, R27
;MyProject.c,216 :: 		}
L_Timer0_ISR57:
;MyProject.c,217 :: 		}
L_Timer0_ISR56:
;MyProject.c,218 :: 		}
L_Timer0_ISR55:
;MyProject.c,219 :: 		}
L_Timer0_ISR54:
;MyProject.c,220 :: 		}
L_Timer0_ISR53:
;MyProject.c,221 :: 		}
	JMP        L_Timer0_ISR58
L_Timer0_ISR52:
;MyProject.c,223 :: 		else ms++;
	LDS        R16, _ms+0
	LDS        R17, _ms+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _ms+0, R16
	STS        _ms+1, R17
L_Timer0_ISR58:
;MyProject.c,226 :: 		}
L_end_Timer0_ISR:
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _Timer0_ISR

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;MyProject.c,227 :: 		void main() {
;MyProject.c,228 :: 		DDRA |= 0b00111111;   //PA0-PA6 – Iesiri
	IN         R16, DDRA+0
	ORI        R16, 63
	OUT        DDRA+0, R16
;MyProject.c,229 :: 		DDRC |= 0b11111111;  //PC0-PC7 – Iesiri
	IN         R16, DDRC+0
	ORI        R16, 255
	OUT        DDRC+0, R16
;MyProject.c,230 :: 		DDRB |= 0b00000000; //PB0-PB7- Iesiri
;MyProject.c,232 :: 		init_timer(); //Initializare timer
	CALL       _init_timer+0
;MyProject.c,233 :: 		Init_adc();  //Initializare convertor Analog Digital
	CALL       _Init_adc+0
;MyProject.c,235 :: 		for(;;)
L_main59:
;MyProject.c,238 :: 		if(PINB & (1<<0))  //testare pin PB0
	IN         R16, PINB+0
	SBRS       R16, 0
	JMP        L_main62
;MyProject.c,240 :: 		if(starePB0 == 0) //variabila va tine minte starea
	LDS        R16, _starePB0+0
	LDS        R17, _starePB0+1
	CPI        R17, 0
	BRNE       L__main175
	CPI        R16, 0
L__main175:
	BREQ       L__main176
	JMP        L_main63
L__main176:
;MyProject.c,241 :: 		{ starePB0 = 1; //anterioara a pin-ului PB0
	LDI        R27, 1
	STS        _starePB0+0, R27
	LDI        R27, 0
	STS        _starePB0+1, R27
;MyProject.c,242 :: 		if(optiune==0)
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__main177
	CPI        R16, 0
L__main177:
	BREQ       L__main178
	JMP        L_main64
L__main178:
;MyProject.c,244 :: 		ho++; //se incrementeaza ora
	LDS        R16, _ho+0
	LDS        R17, _ho+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _ho+0, R16
	STS        _ho+1, R17
;MyProject.c,245 :: 		if(ho==24)
	CPI        R17, 0
	BRNE       L__main179
	CPI        R16, 24
L__main179:
	BREQ       L__main180
	JMP        L_main65
L__main180:
;MyProject.c,246 :: 		ho=0;
	LDI        R27, 0
	STS        _ho+0, R27
	STS        _ho+1, R27
L_main65:
;MyProject.c,247 :: 		}
L_main64:
;MyProject.c,248 :: 		if(optiune==1)
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__main181
	CPI        R16, 1
L__main181:
	BREQ       L__main182
	JMP        L_main66
L__main182:
;MyProject.c,250 :: 		day++; //se incrementeaza ziua
	LDS        R16, _day+0
	LDS        R17, _day+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _day+0, R18
	STS        _day+1, R19
;MyProject.c,251 :: 		if(day>31)
	LDI        R16, 31
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main183
	JMP        L_main67
L__main183:
;MyProject.c,252 :: 		day=1;
	LDI        R27, 1
	STS        _day+0, R27
	LDI        R27, 0
	STS        _day+1, R27
L_main67:
;MyProject.c,253 :: 		}
L_main66:
;MyProject.c,254 :: 		}
L_main63:
;MyProject.c,255 :: 		}else  starePB0 = 0;
	JMP        L_main68
L_main62:
	LDI        R27, 0
	STS        _starePB0+0, R27
	STS        _starePB0+1, R27
L_main68:
;MyProject.c,257 :: 		if(PINB & (1<<1))
	IN         R16, PINB+0
	SBRS       R16, 1
	JMP        L_main69
;MyProject.c,259 :: 		if(starePB1 == 0)
	LDS        R16, _starePB1+0
	LDS        R17, _starePB1+1
	CPI        R17, 0
	BRNE       L__main184
	CPI        R16, 0
L__main184:
	BREQ       L__main185
	JMP        L_main70
L__main185:
;MyProject.c,260 :: 		{ starePB1 = 1;
	LDI        R27, 1
	STS        _starePB1+0, R27
	LDI        R27, 0
	STS        _starePB1+1, R27
;MyProject.c,261 :: 		if(optiune==0)
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__main186
	CPI        R16, 0
L__main186:
	BREQ       L__main187
	JMP        L_main71
L__main187:
;MyProject.c,263 :: 		m++;  //se incrementeaza minutele
	LDS        R16, _m+0
	LDS        R17, _m+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _m+0, R16
	STS        _m+1, R17
;MyProject.c,264 :: 		if(m==60)
	CPI        R17, 0
	BRNE       L__main188
	CPI        R16, 60
L__main188:
	BREQ       L__main189
	JMP        L_main72
L__main189:
;MyProject.c,265 :: 		m=0;
	LDI        R27, 0
	STS        _m+0, R27
	STS        _m+1, R27
L_main72:
;MyProject.c,266 :: 		}
L_main71:
;MyProject.c,267 :: 		if(optiune==1)
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__main190
	CPI        R16, 1
L__main190:
	BREQ       L__main191
	JMP        L_main73
L__main191:
;MyProject.c,269 :: 		month++;     //se incrementeaza luna
	LDS        R16, _month+0
	LDS        R17, _month+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _month+0, R18
	STS        _month+1, R19
;MyProject.c,270 :: 		if(month>12)
	LDI        R16, 12
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main192
	JMP        L_main74
L__main192:
;MyProject.c,271 :: 		month=1;
	LDI        R27, 1
	STS        _month+0, R27
	LDI        R27, 0
	STS        _month+1, R27
L_main74:
;MyProject.c,272 :: 		}
L_main73:
;MyProject.c,273 :: 		}
L_main70:
;MyProject.c,274 :: 		}else  starePB1 = 0;
	JMP        L_main75
L_main69:
	LDI        R27, 0
	STS        _starePB1+0, R27
	STS        _starePB1+1, R27
L_main75:
;MyProject.c,276 :: 		if(PINB & (1<<2)) //buton selectie ora sau data
	IN         R16, PINB+0
	SBRS       R16, 2
	JMP        L_main76
;MyProject.c,278 :: 		if(starePB2 == 0)
	LDS        R16, _starePB2+0
	LDS        R17, _starePB2+1
	CPI        R17, 0
	BRNE       L__main193
	CPI        R16, 0
L__main193:
	BREQ       L__main194
	JMP        L_main77
L__main194:
;MyProject.c,279 :: 		{ starePB2 = 1;
	LDI        R27, 1
	STS        _starePB2+0, R27
	LDI        R27, 0
	STS        _starePB2+1, R27
;MyProject.c,280 :: 		optiune++;
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _optiune+0, R18
	STS        _optiune+1, R19
;MyProject.c,281 :: 		if(optiune>1)
	LDI        R16, 1
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main195
	JMP        L_main78
L__main195:
;MyProject.c,282 :: 		optiune=0;
	LDI        R27, 0
	STS        _optiune+0, R27
	STS        _optiune+1, R27
L_main78:
;MyProject.c,283 :: 		}
L_main77:
;MyProject.c,284 :: 		}else  starePB2 = 0;
	JMP        L_main79
L_main76:
	LDI        R27, 0
	STS        _starePB2+0, R27
	STS        _starePB2+1, R27
L_main79:
;MyProject.c,286 :: 		if(PINB & (1<<3))
	IN         R16, PINB+0
	SBRS       R16, 3
	JMP        L_main80
;MyProject.c,288 :: 		if(starePB3 == 0)
	LDS        R16, _starePB3+0
	LDS        R17, _starePB3+1
	CPI        R17, 0
	BRNE       L__main196
	CPI        R16, 0
L__main196:
	BREQ       L__main197
	JMP        L_main81
L__main197:
;MyProject.c,289 :: 		{ starePB3 = 1;
	LDI        R27, 1
	STS        _starePB3+0, R27
	LDI        R27, 0
	STS        _starePB3+1, R27
;MyProject.c,290 :: 		if(optiune==1)
	LDS        R16, _optiune+0
	LDS        R17, _optiune+1
	CPI        R17, 0
	BRNE       L__main198
	CPI        R16, 1
L__main198:
	BREQ       L__main199
	JMP        L_main82
L__main199:
;MyProject.c,292 :: 		year++;  //se incrementeaza anul
	LDS        R16, _year+0
	LDS        R17, _year+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _year+0, R18
	STS        _year+1, R19
;MyProject.c,293 :: 		if(year>2025) //resetare an daca trece de 2025
	LDI        R16, 233
	LDI        R17, 7
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main200
	JMP        L_main83
L__main200:
;MyProject.c,294 :: 		year=2019;
	LDI        R27, 227
	STS        _year+0, R27
	LDI        R27, 7
	STS        _year+1, R27
L_main83:
;MyProject.c,295 :: 		}
L_main82:
;MyProject.c,296 :: 		}
L_main81:
;MyProject.c,297 :: 		}else  starePB3 = 0;
	JMP        L_main84
L_main80:
	LDI        R27, 0
	STS        _starePB3+0, R27
	STS        _starePB3+1, R27
L_main84:
;MyProject.c,299 :: 		if(PINB & (1<<4))
	IN         R16, PINB+0
	SBRS       R16, 4
	JMP        L_main85
;MyProject.c,301 :: 		if(starePB4 == 0)
	LDS        R16, _starePB4+0
	LDS        R17, _starePB4+1
	CPI        R17, 0
	BRNE       L__main201
	CPI        R16, 0
L__main201:
	BREQ       L__main202
	JMP        L_main86
L__main202:
;MyProject.c,302 :: 		{ starePB4 = 1;
	LDI        R27, 1
	STS        _starePB4+0, R27
	LDI        R27, 0
	STS        _starePB4+1, R27
;MyProject.c,303 :: 		valid++; //pt afisare temperatura
	LDS        R16, _valid+0
	LDS        R17, _valid+1
	MOVW       R18, R16
	SUBI       R18, 255
	SBCI       R19, 255
	STS        _valid+0, R18
	STS        _valid+1, R19
;MyProject.c,304 :: 		if(valid>1)
	LDI        R16, 1
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLT       L__main203
	JMP        L_main87
L__main203:
;MyProject.c,305 :: 		valid=0;
	LDI        R27, 0
	STS        _valid+0, R27
	STS        _valid+1, R27
L_main87:
;MyProject.c,306 :: 		}
L_main86:
;MyProject.c,307 :: 		}else  starePB4 = 0;
	JMP        L_main88
L_main85:
	LDI        R27, 0
	STS        _starePB4+0, R27
	STS        _starePB4+1, R27
L_main88:
;MyProject.c,310 :: 		}
	JMP        L_main59
;MyProject.c,311 :: 		}
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
