<img align="center" width="100%" src="https://user-images.githubusercontent.com/75218511/147607402-14a0a969-5e23-4b55-b15e-27684508b0ef.png">
<h1 align="center">SIMSTRUMENTATION</h1>
<h2 align="center">DIMMING PHILIPS HUE LIGHTS WITH AMBIENT LIGHT DIMMER</h2>

The Ambient Light Dimmer (ALD) has built in functionality to dim a Philips Hue Group using a WiFi Arduino.

The most stable Arduino tested is the Arduino Nano 33 IOT. The Arduino Script is built for that model Arduino, other models may need adjusting.

There are debugging features, and because the Nano 33 IOT has a second UART Serial onboard, debug messages are set to that, and you may listen to them using a PC serial port, or second Arduino. In the debugging folder the second Arduino tested was the original Arduino Nano. There is also a wiring diagram provided.

___
<h2 align="center">Instructions</h2>

## Philips Hue Setup
+ You must have a Philips Hue Bridge (either 1st or 2nd Generation should work).
+ From the Philips Hue App, make sure your bridge is registered.
+ You must either reserve the DHCP address of your Philis Hue Bridge in your Router, or to set it to a static IP in the Hue App. For the short term, can you see what the IP is in the Hue App.
  + To see the Hue Bridge IP, go to *Settings*, choose your Hue Bridge, click the "i" icon.
  + To set a static IP address on your bridge, go to *Settings*, scroll down to *Bridge settings*, choose *Network settings*, unselect *DHCP*, and enter a static IP Address. 
+ The Arduino script was wrote with groups, or "Rooms" as it's called in the Hue App, in mind as what you'd like to control. This allows multiple Hue Lights to be controlled at the same time. You'll see that this script was tested with 2 Hue Play lights in a room called "FlightSim".  
+ Make sure the Hue Lights you'd like to control are in a Room. A Zone should also work. The Arduino script will control the room or zone by it's ID number.
##### Creating a API Key
+ You need to create an API Key (also called username) to make sure the requests that the Arduino does are authenticated.
+ Once you know the Hue Hub IP address, on a computer browse your hub webpage http://192.168.1.117/debug/clip.html (replacing 192.168.1.117 with your Hub IP Address).
+ Click *Get* and you should see some generic information in the Response.
+ Enter in `/api/ArduinoAM` in the *URL* and `{"devicetype":"my_hue_app#ArduinoAM app"}` into the *Message Body*. 
  + Press *Put* and you should receieve an error message saying "link button not pressed" or "unauthorized user".
  + Go to your Hue Hub and physically press the top link button.
  + Now press *Put* again, and you should see a success message with a new API Key. **COPY THIS KEY AND SAVE IT TO A TEXT FILE FOR REFERENCE.**
##### Getting Hue Room ID Number
+ Now that you have a API Key, replace *ArduinoAM* in the *URL* line with your new API Key, clear the text out of the *Message Body* and press *Get*.
  + You should get a response in JSON format that includes all of your Hue Hub and Hue Lights information.
  + To find your group (either a Room or a Zone) ID Number, the easist thing to do is do a search (CTRL-F) for the name of your room. In this example, my room is named "FlightSim" and you'll see the ID Number above the name, my example is ID "3".
  + If you'd like to test the control of this group, in the *URL* line enter in `/api/YOUR_API_KEY_HERE/groups/3/action/` and in the *Message Body* line enter `{"on":true}` or `{"on":false}` depending if you want to turn the lights On or Off, and press *Put*.
    + If you get a Success message but your lights aren't doing anything, turn the lights on and set the Brightness to Max in the Hue App.
  + You now have all the relavant information to control the Hub, the webpage is no longer needed and can be closed.
##### Programming Arduino
+
  


















For more information and descriptions see the official hue developers manual here: https://developers.meethue.com/develop/get-started-2/
