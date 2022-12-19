<img align="center" width="100%" src="https://user-images.githubusercontent.com/75218511/147607402-14a0a969-5e23-4b55-b15e-27684508b0ef.png">
<h1 align="center">SIMSTRUMENTATION</h1>
<h2 align="center">DIMMING PHILIPS HUE LIGHTS WITH AMBIENT LIGHT DIMMER</h2>


<h2 align="center">Debugging</h2>

Because Air Manager has control over the serial connection, you can't have the Arduino IDE serial monitor open that is the same com port as the Messsage Port Arduino. Thus one option was to have the arduino open a 2nd comm port and log events to that 2nd comm port. 
To achomplish this, A second arduino is needed. In this test case, a regular Arduino Nano was used. 
The SerialMonitor script is was is uploaded to the 2nd arduino. And you can open the serial monitor in Arduino IDE, making sure the com port is selected for the 2nd Arduino, to see the incoming messages of the MessagePort Arduino.

[Click here for Arduino Serial Monitor Script](https://github.com/Simstrumentation/Air-Manager/blob/main/Ambient_Light_Dimmer/Philips_Hue_Light_Dimming/Debugging/SerialMonitor/SerialMonitor.ino?raw=true)


<img align="center" width="100%" src="https://github.com/Simstrumentation/Air-Manager/blob/main/Ambient_Light_Dimmer/Philips_Hue_Light_Dimming/Debugging/DebugArduino.png">


![Screenshot 2022-12-18 210921](https://user-images.githubusercontent.com/38576265/208334235-f4177b69-dfb7-4413-8fc0-e51db4bd7b59.png)
