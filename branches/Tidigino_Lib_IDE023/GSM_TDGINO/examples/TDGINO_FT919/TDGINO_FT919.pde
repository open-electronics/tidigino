/* TDGino example 
Use with I/O shield FT919

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


// Variables will change:
int in=0;             
int out=0;
int an=0;
int inByte=0;


// the follow variables is a long because the time, measured in miliseconds,
// will quickly become a bigger number than can be stored in an int.
long interval = 1000;           // interval at which to blink (milliseconds)



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
  
    // start serial port at 9600 bps:
  Serial.begin(9600);


  // set the digital pin as output:
  for (int out=8; out<=13; out++){
    pinMode(out, OUTPUT);      
  }
}

void loop()
{
  // here is where you'd put code that needs to be running all the time.

  // check to see if it's time to blink the LED; that is, if the 
  // difference between the current time and last time you blinked 
  // the LED is bigger than the interval at which you want to 
  // blink the LED.
 
  if (Serial.available() > 0) {
    protocollo();
  }
  
     
}


void protocollo()
{
  inByte = Serial.read();
    switch (inByte) 
    {
        case 79: //O  out
          
          
          Serial.println("Out number? (1 to 6)");   // send an initial string
            while (Serial.available() <= 0) 
            {
              delay(300);
            }
            
            out = Serial.read()-48;
            Serial.println("ricevuto ");
            Serial.print(out);
            if (out>=1&&out<=6)
            {
              out=out+7;
              if (!digitalRead(out))
                digitalWrite(out, HIGH);
              else
                digitalWrite(out, LOW);
                
              Serial.print("Out ");
              Serial.print(out-7);
              Serial.print(" = ");
              Serial.println(digitalRead(out));
            }
          
          break;
          
        case 73: //I
          //input
          
          Serial.println("In number? (1 to 6)");   // send an initial string
       
            while (Serial.available() <= 0) 
            {
              delay(300);
            }
            
            in = Serial.read()-48;
            if (in>=1&&in<=6){
            in=in+1;
            
            Serial.print("In ");
            Serial.print(in-1);
            Serial.print(" = ");
            Serial.println(digitalRead(in));
            }
          break;
          
          case 65: //A
          //analog
          
          Serial.println("Analog number? (1 to 6)");   // send an initial string
       
            while (Serial.available() <= 0) 
            {
              delay(300);
            }
            
            an = Serial.read()-48;
            if (an>=1&&an<=6){
            an=an-1;     
            

            Serial.print("Analog ");
            Serial.print(an+1);
            Serial.print(" = ");
            Serial.println(analogRead(an));
            }
          break;

          
        //default: 
          // if nothing else matches, do the default
          // default is optional
     
    } 
 
   
}




    
