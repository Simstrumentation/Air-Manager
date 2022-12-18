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
+ From the Philips Hue App, make sure your hue bridge is registered to your Phone App. This isn't a requirement, but helpful to find your Hue Hub IP Address.
+ You must either reserve the DHCP address of your Philips Hue Bridge in your Router, or to set it to a static IP in the Hue App. For the short term, can you see what the IP is in the Hue App.
  + To see the Hue Bridge IP, go to *Settings*, choose your Hue Bridge, click the "i" icon.  
     <p align="center"><img src="https://user-images.githubusercontent.com/38576265/208324694-977bdb60-aac2-44ff-ad1c-68df274c12e8.PNG" width="150"> <img src="https://user-images.githubusercontent.com/38576265/208324698-c059901d-64da-4dec-a706-639cc77844db.PNG" width="150"> <img src="https://user-images.githubusercontent.com/38576265/208324703-d885d9ba-6c66-4ab6-b6bd-b4281ca698a6.PNG" width="150"></p>
  + To set a static IP address on your bridge, go to *Settings*, scroll down to *Bridge settings*, choose *Network settings*, unselect *DHCP*, and enter a static IP Address. 
  
    <p align="center"><img src="https://user-images.githubusercontent.com/38576265/208325002-25440495-04e1-4662-8793-55bf8729f4a6.PNG" width="150"> <img src="https://user-images.githubusercontent.com/38576265/208325010-98706b46-c5a4-4dc5-abcd-3c4eea224c63.PNG" width="150"> <img src="https://user-images.githubusercontent.com/38576265/208325019-2aa9cdcf-af3c-4f69-936d-68765dc7989c.PNG" width="150"> <img src="https://user-images.githubusercontent.com/38576265/208325020-a4f869c2-bcb9-471f-b6ad-f582048c5296.PNG" width="150"> </p>

+ The Arduino script was wrote with using groups in mind, or "Rooms" as it's called in the Hue App. This allows multiple Hue Lights to be controlled at the same time. You'll see that this script was tested with 2 Hue Play lights in a room called "FlightSim".  
+ Make sure the Hue Lights you'd like to control are in a Room. A "Zone" should also work as it gets a group ID number the same as a room does. The Arduino script will control the room or zone by it's ID number.
##### Creating a API Key
+ You need to create an API Key (also called username) to make sure the requests that the Arduino does are authenticated.
+ Once you know the Hue Hub IP address, on a computer browse your hub webpage http://192.168.1.117/debug/clip.html (replacing 192.168.1.117 with your Hub IP Address).
+ Click *Get* and you should see some generic information in the Response.
  
  <p align="center"><img src="https://user-images.githubusercontent.com/38576265/208325172-eb779474-d5a1-4905-9937-ed608c17171f.png" width="400"></p>

+ Enter in `/api/ArduinoAM` in the *URL* and `{"devicetype":"my_hue_app#ArduinoAM app"}` into the *Message Body*. 
  + Press *Put* and you should receieve an error message saying "link button not pressed" or "unauthorized user".
  <p align="center"><img src="https://user-images.githubusercontent.com/38576265/208325348-fc421d28-03a6-4684-8710-cf320b24e2d7.png" width="400"></p>

  + Go to your Hue Hub and physically press the top link button.
  + Now press *Put* again, and you should see a success message with a new API Key. **COPY THIS KEY AND SAVE IT TO A TEXT FILE FOR REFERENCE.**
##### Getting Hue Room ID Number
+ Now that you have a API Key, replace *ArduinoAM* in the *URL* line with your new API Key, clear the text out of the *Message Body* and press *Get*.
  + You should get a response in JSON format that includes all of your Hue Hub and Hue Lights information.
  + To find your group (either a Room or a Zone) ID Number, the easist thing to do is do a search (CTRL-F) for the name of your room. In this example, my room is named "FlightSim" and you'll see the ID Number above the name, my example is ID "3".
  + If you'd like to test the control of this group, in the *URL* line enter in `/api/YOUR_API_KEY_HERE/groups/3/action/` and in the *Message Body* line enter `{"on":true}` or `{"on":false}` depending if you want to turn the lights On or Off, and press *Put*.
    + If you get a Success message but your lights aren't doing anything, turn the lights on and set the Brightness to Max in the Hue App.
  + You now have all the relavant information to control the Hub, the webpage is no longer needed and can be closed.
##### Setting up Arduino IDE
+ Download the [Arudino script from Github](https://github.com/Simstrumentation/Air-Manager/blob/main/Ambient_Light_Dimmer/Philips%20Hue%20Light%20Dimming/HueArduinoScript/HueArduinoScript.ino)
+ Open the script using Arduino IDE 
  + Arduino IDE Available for [download here](https://docs.arduino.cc/software/ide-v1)
+ Once the script is open in Arudino IDE, go to *Tools* menu, and set the Board model from the drop down as well as *Port* Channel from the next drop down. (Use Windows Device Manager to find the Comm port number if you need too.
  + TIP: It's recomemnded to unplug any DIY knobsters to reduce the risk of accidently choose them in the comm port menu.
+ Download the [SimInnovations Message Port Library](https://www.siminnovations.com/api4/download.php?product_type=APPLICATION&application_group_type=MESSAGE_PORT_LIBRARY&platform=WINDOWS&program_compilation=HOME_USE&beta=false)
  + Unpack the downloaded zip, and copy the *SiMessagePort* folder into Arduino libaries folder, typically located in your *My Documents\Arduino\libaries*
  + More information for reference about Air Manager Message Port is [here on SI Wiki Page](https://siminnovations.com/wiki/index.php?title=Arduino#Download_the_Message_Port_library)
+ Go to *Tools* menu, and choose *Manage Libaries*, the Libary Manager should open up, in the search box enter `wifinina`, click the first search result and install the latest version.
##### Setting Custom Script Variables
+ Near the top of the Arudion Script you must change the following variables:
  1. **hueHubIP** - replace `192.168.1.117` with your Hue Hub IP Address.
  2. **hueUsername** - replace `abcdefghijklmnopkrstuvwxyz` with your API Key.
  3. **huegroup** - replace `3` with your group ID number.
  4. **ssid** - replace `YourWiFi` with your Wifi SSID.
  5. **pass** - replace `WiFiPassword` with your Wifi password.
  
 For more comlicated setups, you may have to change the SI_MESSAGE_PORT_CHANNEL_A on Line 73 to something not being used. You'll know if you're doing this already or not.

##### Verify Compiling and Uploading
+ At this point, the script should compile without errors, click the Verify checkmark icon in the top ribbon bar to verify the code before compiling and writing it to the Arduino. 
+ If you get a clean verify, as indicated by the "Done Compiling" message at the bottom of the Arduino IDE screen and no red errors message, write the script to the Arudino by choosing Upload (the arrow) from the top ribbon bar.



















For more information and descriptions see the official hue developers manual here: https://developers.meethue.com/develop/get-started-2/
