/*
  Rob Verdon
  rob.verdon@gmail.com
  Simstrumentation
  http://simstrumentation.com/

  This script is made to debug the MessagePort Arudino by using a 2nd Arduino to monitor the incoming debug messages.
  This script is set to read the serial messages incoming on Pin2 (don't forget to connect Gnd->Gnd).
  MessagePort Arduino is set to tx the serial messages on.
  Open the serial monitor in Arduino IDE, making sure the com port is selected for this Arduino, to see the incoming messages.

  Version1: 10/04/2021 Initial Script
  Version2: 12/16/2022  Optimized and cleaned code
  
*/
#include <SoftwareSerial.h>

SoftwareSerial Serial1(2, 3); //first number is rx pin for receiving serial debugging for tx of MessagePort Arduino. 

void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600); //begin serial connection to PC over USB
  Serial1.begin(9600); //begin software serial connection from Pin on board
  Serial.println("Started"); //Send word "Started" to serial 
}

// the loop routine runs over and over again forever:
void loop() {
   Serial1.listen();
   while (Serial1.available() > 0) {
    char inByte = Serial1.read();
    Serial.write(inByte);
  }
}
