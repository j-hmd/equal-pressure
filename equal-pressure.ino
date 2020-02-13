/*
**** Author: Juliana Hamada ****
**** Date: Feb 12 2020 *********
*
******************** Project: Equal Pressure for Realign ********************
* 
* Inputs: sensor output from flexiforce pressure sensors
* Output: amount of force from both sensors 
*/

const int sensorOut = A0;           // Pin A0 to read anaog input

int pressure=0;                       // Store analog value for pressure

void setup() {
  Serial.begin(9600);               // Start serial communication
}

void loop() {
  // Main //
  pressure = analogRead(sensorOut); // read sensor output
  Serial.println(pressure);         // print pressure value
  delay(100);                       // delay
}
