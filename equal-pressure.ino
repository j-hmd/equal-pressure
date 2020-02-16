/*
**** Author: Juliana Hamada ****
**** Date: Feb 12 2020 *********
*
******************** Project: Equal Pressure for Realign ********************
* 
* Inputs: sensor output from flexiforce pressure sensors
* Output: amount of force from both sensors 
*/

#include <Blynk.h>
#include <BlynkSimpleEsp8266.h>
#include <ESP8266WiFi.h>


#define BLYNK_PRINT Serial

const int sensorOut = A0;           // Pin A0 to read anaog input
int pressure = 0;                   // Store analog value for pressure

// Settings to connect to Blynk
char auth[] = "secret";
char ssid[] = "secret";       // Has to be a 2.4Ghz Network
char pass[] = "secret";

BLYNK_READ(V5) // alternatively we could have used BlynkTimer and PUSH
{
  pressure = analogRead(sensorOut); // read sensor value
  Blynk.virtualWrite(V5, pressure); // write sensor value to blynk
}

void setup()
{
  Serial.begin(9600);               // Start serial communication
  Blynk.begin(auth, ssid, pass);    // authentication
}

void loop()
{
  Blynk.run();
}
