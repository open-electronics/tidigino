/* TDGino example 
Sketch to test the call function

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
  // if we get a valid byte, read analog ins:
  
  if (digitalRead(in1) == 0 ) {
    digitalWrite(ld1,HIGH); 
    digitalWrite(rele1,HIGH); 
  }
  else
  {
    digitalWrite(ld1,LOW); 
    digitalWrite(rele1,LOW); 
  }
    
  if (digitalRead(in2) == 0 ) {
    digitalWrite(ld2,HIGH); 
    digitalWrite(rele2,HIGH); 
  }
  else
  {
    digitalWrite(ld2,LOW); 
    digitalWrite(rele2,LOW); 
  }
    
    
  if (digitalRead(puls) == 0 ) {
    Serial.println("pulsante premuto");  
     digitalWrite(rele1,HIGH);   
     delay(2000);
     digitalWrite(rele2,HIGH);
     delay(2000);
     digitalWrite(rele1,LOW);   
     delay(2000);
     digitalWrite(rele2,LOW);
     delay(2000);

    response=gsm.DeleteSMS(1);
    Serial.print("Response del "); 
    Serial.println(response); 
    
    for (int i=0; i<=10; i++)
    {
        if (1 == gsm.GetPhoneNumber(i, phone_num)) 
        { 
          // valid phone number on SIM pos. #1  
          // phone number string is copied to the phone_num array 
          #ifdef DEBUG_PRINT 
            sprintf(string, "DEBUG position %i phone number:", i);
            gsm.DebugPrint(string, 0); 
            gsm.DebugPrint(phone_num, 1); 
          #endif 
       }        
        else { 
          // there is not valid phone number on the SIM pos.#1 
          #ifdef DEBUG_PRINT 
            gsm.DebugPrint("DEBUG there is no phone number", 1); 
          #endif 
         }
     }
    
    
    response=gsm.IsSMSPresent(SMS_UNREAD);    
    Serial.print("Response UNREAD "); 
    Serial.println(response); 
    if (response)
    {
      gsm.GetSMS(response, phone_num, string, 160);
      #ifdef DEBUG_PRINT
        gsm.DebugPrint("Numero ",0);
        gsm.DebugPrint(phone_num ,0);        
        gsm.DebugPrint("\r\n  Testo ",0);
        gsm.DebugPrint(string ,0);
      #endif
    }  
    delay (1000);
    
    response=gsm.IsSMSPresent(SMS_READ);    
    Serial.print("Response READ "); 
    Serial.println(response); 
        if (response)
    {
      gsm.GetSMS(response, phone_num, string, 160);
      #ifdef DEBUG_PRINT
        gsm.DebugPrint("Numero ",0);
        gsm.DebugPrint(phone_num ,0);        
        gsm.DebugPrint("\r\n  Testo ",0);
        gsm.DebugPrint(string ,0);
      #endif
    }  
    delay (1000);

    response=gsm.IsSMSPresent(SMS_ALL);    
    Serial.print("Response ALL "); 
    Serial.println(response); 
        if (response)
    {
      response=gsm.GetAuthorizedSMS(2, phone_num, string, 160,1,9);
      #ifdef DEBUG_PRINT
        gsm.DebugPrint("Numero ",0);
        gsm.DebugPrint(phone_num ,0);        
        gsm.DebugPrint("\r\n  Testo ",0);
        gsm.DebugPrint(string ,0);
        gsm.DebugPrint("\r\n  Auth ",0); 
        gsm.DebugPrint(response,0);         
      #endif 
    }  
    delay (1000);
    //gsm.HangUp();
   
  } 
  
    response=gsm.CallStatus();    
    Serial.print("Response "); 
    Serial.println(response); 
    delay (2000);
  

}
    
