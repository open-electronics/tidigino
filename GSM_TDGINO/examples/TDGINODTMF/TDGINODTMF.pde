/* TDGino example 
Sketch to test the DTMF section

 created 2011
 by Boris Landoni

 This example code is in the public domain.

http://www.open-electronics.org

http://www.futurashop.it

 */
 
 
#include <GSM.h>
//for enable disable debug rem or not the string       #define DEBUG_PRINT
// definition of instance of GSM class
GSM gsm;


// Set pin numbers:
const int powergsm =  77;
const int ctsgsm   =  39;
const int rtsgsm   =  29;
const int dcdgsm   =  27;
const int dtrgsm   =  28;
const int reset    =  35;
const int ring     =  34;
const int ld1      =  25;
const int ld2      =  26;
const int stato    =  76;
const int rele1    =  36;
const int rele2    =  37;
const int sda      =  20;
const int scl      =  21;
const int in1      =  84;
const int in2      =  83;
const int stddtmf  =  14;
const int q1dtmf   =  72;
const int q2dtmf   =  73;
const int q3dtmf   =  74;
const int q4dtmf   =  75;
const int puls     =  62;
const int sonda    =  63;

void setup() {
  // set the digital pin as output:
  pinMode(powergsm, OUTPUT);      
  pinMode(rtsgsm, OUTPUT); 
  pinMode(dtrgsm, OUTPUT); 
  pinMode(reset, OUTPUT); 
  pinMode(ld1, OUTPUT); 
  pinMode(ld2, OUTPUT); 
  pinMode(rele1, OUTPUT); 
  pinMode(rele2, OUTPUT); 
  pinMode(sda, OUTPUT); 
  pinMode(scl, OUTPUT); 
  
  // set the digital pin as input:
  pinMode(ctsgsm, INPUT);      
  pinMode(dcdgsm, INPUT); 
  pinMode(ring, INPUT); 
  pinMode(stato, INPUT); 
  pinMode(in1, INPUT); 
  pinMode(in2, INPUT); 
  pinMode(stddtmf, INPUT); 
  pinMode(q1dtmf, INPUT); 
  pinMode(q2dtmf, INPUT); 
  pinMode(q3dtmf, INPUT); 
  pinMode(q4dtmf, INPUT); 
  pinMode(puls, INPUT); 
  pinMode(sonda, INPUT); 
  
  // start serial port at 9600 bps:
  Serial.begin(9600);
  //Serial1.begin(115200);
  Serial.println("system startup"); 
  //gsm.InitSerLine(115200);   //initialize serial 1 
  gsm.TurnOn(115200);              //module power on
  gsm.InitParam(PARAM_SET_1);//configure the module  
  gsm.Echo(1);               //enable AT echo 
}


void loop()
{
  int response=0;
  char phone_num[20]; // array for the phone number string 
  char string[160];
  int tono=0;
  // if we get a valid byte, read analog ins:

    
    switch (gsm.CallStatus())
    {
      case CALL_NONE:
        delay (1000);
        break;
        
      case CALL_INCOM_VOICE:
        Serial.println("Chiamata in arrivo");
        delay (2000);
        gsm.PickUp();
        Serial.println("Risposto");
        break;
        
      case CALL_ACTIVE_VOICE:
        Serial.println("Chiamata attiva");
        for (int i=0;i<100;i++)
        {
          if (digitalRead(stddtmf)==1)
          {
            sprintf(string,"DTMF %d - %d - %d - %d",digitalRead(q1dtmf),digitalRead(q2dtmf),digitalRead(q3dtmf),digitalRead(q4dtmf));
            Serial.println(string);
            tono=0;
            bitWrite(tono, 0, digitalRead(q1dtmf));
            bitWrite(tono, 1, digitalRead(q2dtmf));
            bitWrite(tono, 2, digitalRead(q3dtmf));
            bitWrite(tono, 3, digitalRead(q4dtmf));
            Serial.print("tono = ");
            Serial.println(tono);
            while(digitalRead(stddtmf)==1)
            {
              delay (10);              
            }
            i=0;
          }
          
          delay (10);
        }
        break;
     }   
    
    

    

}
    
