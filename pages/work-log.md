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

-------------

Author|Date
------|-----
Juliana | Feb 15 2020

## Milestone: Blynk app connection successful ###
### Wifi ###
After running the new code, still could not connect to the blynk app. I figured through this [post](https://community.blynk.cc/t/nodemcu-wasnt-online-yet/39851/9) that the network has to be 2.4Ghz. Problem fixed, the pressure value form the sensor is now showing on the blynk app.

<p float="left">
  <img src="/assets/blynk-sensor-1.png" width="250" height="400">
</p>

Up next: connecting two sensors to the wifi and showing them in Blynk!

### Milestone: 2 NodeMCUs with Blynk ###
Using the same schematics and same script, I connected the second sensor to Blynk. Now I can see two pressures at once. 

<p float="left">
  <img src="/assets/blynk-sensor-2.png" width="250" height="400">
</p>

### Design Question ###
- How to decide which one is being pressed with more force? Should the user decide?

In order to decide which sensor is being pressed harder, we would need to make that decision in Blynk, since the two NodeMCUs would probably not be able to do that? 

Other design considerations:
- Battery life?
- How to encapsulate product (enclosures)?
- Data accuracy?

Up next: 
- including external battery
- cutting an insole and attching the sensors to the insole
- new [interface](https://randomnerdtutorials.com/esp8266-web-server/). Using a webserver that I can edit might give me more freedom to build custom solutions for the client, and also easier for them to access than to have blynk account. I could also integrate it with my Github Pages?? 


Author|Date
------|-----
Juliana | Feb 26 2020

## Milestone: Web App with Lua ##
The Blynk app was a good first start to the project, but it constrained the display format of the data to the Blynk Widgets. For more freedom in design, the project is starting to switch to an web server created with NodeMCU and LUA scripts. 

I was able to flash NodeMCU, and upload my Lua script to the board, then controlling the built in LED via the web app. See images below:
<p float="left">
  <img src="/assets/web-app-1.PNG" width="250" height="400">&nbsp
  <img src="/assets/built-in-led.JPG" width="250" height="400" style="transform:rotate(90deg);">
</p>

Next:
- Display pressure in the browser
