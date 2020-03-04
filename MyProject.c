//variabile pt afisarea pe 7 segmente
int digit=0;
int digit1=0;
int digit2=0;

//variabile ceas si data
int ms=0;
int s=0;
int m=0;
int ho=0;
int month=1;
int day=1;
int year=2019;

//variabile stari butoane
int starePB0 = 0;
int starePB1 = 0;
int starePB2 = 0;
int starePB3 = 0;
int starePB4 = 0;

//variabile trecere afisare intre ceas,data,temperatura
int optiune=0;
int valid=0;

//variabila pt citire senzor temperatura
int value=0;

int adc=0,T=0;

//variabile convertor ADC
char adclow=0, adchigh=0;

float Vin, tmp;


void init_timer()
{
      SREG |= 1<<7; //activam intreruperile
      TCCR0 = 0b00001011; //CTC-3,6, Prescaler-0,1,2
      TCNT0 = 0;
      OCR0 = 125;
      TIMSK |= 0b00000010;//set interrupt OCM
      //timer care numara ms
}


void Init_adc(){
      ADMUX = 0b01000000; //Referin.a - AVCC
      ADCSRA = 0b10000111; //Activare ADC; Prescaler = 128;
}

int readADC(char ch){
      ADMUX &= 0b11100000;
      ADMUX |= ch;
      ADCSRA |= 1<<6;
   //   while(ADCSRA & (1<<6));
      adclow = ADCL;
      adchigh = ADCH;
      return  adchigh<<8 | adclow;   //Returneaza rezultatul conversiei
}


void readADC_interrupt(char ch){
      ADMUX &= 0b11100000; //Reseteazã canalul de conversie
      ADMUX |= ch; //Seteazã canalul
      ADCSRA |= (1<<6); //Începe conversia
}

void display(char p, char c)
  {
   PORTA&=0b11000000; //linii selectie oprite
   PORTC&=0b00000000; //initializare 7 segmente cu toate segmentele oprite
   switch(c)
   {
    case 0:
         PORTC|=0b00111111;
         break;
    case 1:
         PORTC|=0b00000110;
         break;
    case 2:
         PORTC|=0b01011011;
         break;
    case 3:
         PORTC|=0b01001111;
         break;
    case 4:
         PORTC|=0b01100110;
         break;
    case 5:
         PORTC|=0b01101101;
         break;
    case 6:
         PORTC|=0b01111101;
         break;
    case 7:
         PORTC|=0b00000111;
         break;
    case 8:
         PORTC|=0b01111111;
         break;
    case 9:
         PORTC|=0b01101111;
         break;
    case 10:
         PORTC|=0b01100011;
         break;
    case 11:
         PORTC|=0b0111001;
         break;

   }
   switch(p)
   {
      case 6:
         PORTA|=0b00110111;
         break;
     case 5:
         PORTA|=0b00111011;
         break;
    case 4:
         PORTA|=0b00111101;
         break;
    case 3:
         PORTA|=0b00111110;
         break;
    case 2:
         PORTA|=0b00101111;
         break;
    case 1:
         PORTA|=0b00011111;
         break;
   }
  }

void ADC_Completed() iv IVT_ADDR_ADC{
      adclow = ADCL;
      adchigh = ADCH;
      adc = (adchigh << 8) | adclow;
      Vin = ((float)adc*5)/1024;
      tmp = Vin*1000;
      T = (int)tmp;
}





void Timer0_ISR() iv IVT_ADDR_TIMER0_COMP
{

 if(optiune==0 && valid==0)//afisare ora cu minute si secunde
 {
 digit++;
 switch(digit){
 case 1: display(1,s%10); break;
 case 2: display(2,(s/10)%10); break;
 case 3: display(3,m%10); break;
 case 4: display(4,(m/10)%10); break;
 case 5: display(5,ho%10); break;
 case 6: display(6,(ho/10)%10); digit=0; break;
 }
 }
 if(optiune==1 && valid==0)  //afisare data
 {
  digit1++;
 switch(digit1){
 case 1: display(1,year%10); break;
 case 2: display(2,(year/10)%10); break;
 case 3: display(3,month%10); break;
 case 4: display(4,(month/10)%10); break;
 case 5: display(5,day%10); break;
 case 6: display(6,(day/10)%10); digit1=0; break;
 }
 }
 if(valid==1)   //afisare temperatura
{
    digit2++;
    switch(digit2)
    {
        case 1: display(1,11); break;
        case 2: display(2,10);break;
        case 3: display(3,(value/2)%10); break;
        case 4: display(4,((value/2)/10)%10);  digit2=0;  break;
    }
    if(ms==999)
    {
        value=readADC(7);  //citire senzor temperatura din secunda in secunda
    }

}
//logica ceas si data
 if (ms == 999){
 s++;
 ms = 0;
 if(s == 60){
 s = 0;
 m++;
 if(m==60)
 {
  m=0;
  ho++;
  if(ho==24)
  {
   day++;
   ho=0;
   if(day>31)
   {
    day=1;
    month++;
    if(month>12)
    {
     year++;
     month=1;
    }
   }
  }
 }
 }
 }

else ms++;


}
void main() {
      DDRA |= 0b00111111;   //PA0-PA6 – Iesiri
      DDRC |= 0b11111111;  //PC0-PC7 – Iesiri
      DDRB |= 0b00000000; //PB0-PB7- Iesiri

      init_timer(); //Initializare timer
      Init_adc();  //Initializare convertor Analog Digital

      for(;;)
      {

      if(PINB & (1<<0))  //testare pin PB0
      {
      if(starePB0 == 0) //variabila va tine minte starea
      { starePB0 = 1; //anterioara a pin-ului PB0
        if(optiune==0)
        {
        ho++; //se incrementeaza ora
        if(ho==24)
           ho=0;
        }
        if(optiune==1)
        {
         day++; //se incrementeaza ziua
         if(day>31)
            day=1;
        }
      }
      }else  starePB0 = 0;

      if(PINB & (1<<1))
      {
      if(starePB1 == 0)
      { starePB1 = 1;
        if(optiune==0)
        {
        m++;  //se incrementeaza minutele
        if(m==60)
           m=0;
        }
        if(optiune==1)
        {
         month++;     //se incrementeaza luna
         if(month>12)
           month=1;
        }
      }
      }else  starePB1 = 0;

      if(PINB & (1<<2)) //buton selectie ora sau data
      {
      if(starePB2 == 0)
      { starePB2 = 1;
        optiune++;
        if(optiune>1)
          optiune=0;
      }
      }else  starePB2 = 0;

      if(PINB & (1<<3))
      {
      if(starePB3 == 0)
      { starePB3 = 1;
        if(optiune==1)
        {
         year++;  //se incrementeaza anul
         if(year>2025) //resetare an daca trece de 2025
           year=2019;
        }
      }
      }else  starePB3 = 0;
      
      if(PINB & (1<<4))
      {
      if(starePB4 == 0)
      { starePB4 = 1;
            valid++; //pt afisare temperatura
            if(valid>1)
             valid=0;
      }
      }else  starePB4 = 0;


      }
}