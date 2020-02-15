# Working Log #
Changes and lessons learned from the design process. This section is divided accorindg to the date of the changes, and all design decisions are further explained. All changes are added to the end of the document, and all the learning along the process is also documented here.

This log is in chronological order.

-----------------------

Author|Date
------|-----
Juliana | Feb 12 2020

The initial schematics of the project includes:
* micro USB
* NodeMCU ESP8266 12E
* Force Sensitive Resistor 0.5''(SparkFUn)
* 3.3k ohm resistor

Objectives of the inital design are:
* Familiarize myself with the Arduino IDE for NodeMCU
* Create environment to develop the project
* "Hello World" for this project is equivalent to obtaining sensor data in the serial port, and the settings used in the Arduino IDE are as follows:
<p float="left">
  <img src="/assets/board-design-1.png" width="350" height="300">
  <img src="/assets/arduino-settings.png" width="350" height="300">
</p>

Up next:
* Connect to Blynk, and show results on blynk

### Choice: Blynk ###
I chose to use the blynk digital dashboard, because the focus of this project for now is focus on nodemcu, the sensors, and programming C++. Therefore, building an UI (user interface) for this project would be out of scope and not a good use of time.
Given the facility and good support/documentation for Blynk, I chose to build my simple interface with it.

------------

Author|Date
------|-----
Juliana | Feb 14 2020

### Solving Issue #1 ###
Trying to run the Blynk app without success, but couldn't find any apparent bugs in the code.
Found out that you can't run reading commands inside the void loop(), because that will flood Blynk cloud.
[(Reference)](http://help.blynk.cc/en/articles/512056-how-to-display-any-sensor-data-in-blynk-app)

Also learning more about Blynk conceps, like [virtual pins](http://help.blynk.cc/en/articles/512061-what-is-virtual-pins). Which is basically if we were extending the number of pins of the hardware, but these pins have no physical properties, they are virtual.

### Choice: PULL sensor data ###
According to the documentation, there are two ways to get data from the sensor:
1. PULL: Blynk will request data from your sensor
2. PUSH: Hardware will constantly send data to the Blynk cloud, and the data will sit waiting.

Decided to try to implement the PULL method. Because there is no need to store data. The user needs to see it and the app can forget about it.

Up next: testing this! 

