/*Rob Verdon
  rob.verdon@gmail.com
  Simstrumentation
  http://simstrumentation.com/

  This script was wrote to control and entire Hue Group, that way multiple lights can be controlled at the same time, but you can have a group with just 1 light in it.
  Arduino will get a DHCP Address, but your Hub should be a static.
  
  You must change the IP address to your Hue Hub IP Address.
  You must get the API Key Name. See Simstrumentation Github for more instructions.
  You must change the HueGroup number.
  You must set your WiFi SSID name and password.

  Version1: 10/04/2021 Initial Script
  Version2: 12/16/2022  Optimized and cleaned code
  

 */

#include <SPI.h>
#include <WiFiNINA.h>
#include <si_message_port.hpp>


//  Hue Info
const char hueHubIP[] = "192.168.1.117";  // Hue hub IP (recomend to make Hub static)
const char hueUsername[] = "abcdefghijklmnopkrstuvwxyz";  // Hue Username/API Key
const int hueHubPort = 80;
const int huegroup = 3;  // your hue group that you want to control

// WiFi Info
char ssid[] = "YourWiFi";         // your network SSID (name)
char pass[] = "WiFiPassword";        // your network password

//Air Manager Info
//If you need to change from Channel A to something different search for "SI_MESSAGE_PORT_CHANNEL_A" and replace the letter with next available.


int status = WL_IDLE_STATUS;     // the Wifi radio's status

SiMessagePort* messagePort;

WiFiClient client;

static void new_message_callback(uint16_t message_id, struct SiMessagePortPayload* payload) {
   Serial1.print("Received Message from AM. ");

	if (payload == NULL) {
		messagePort->DebugMessage(SI_MESSAGE_PORT_LOG_LEVEL_INFO, (String)"Received without payload");
	}
	else {
		switch(payload->type) {
			case SI_MESSAGE_PORT_DATA_TYPE_BYTE:
        Serial1.print("Calling MessagePort \r\n");
				messagePort->DebugMessage(SI_MESSAGE_PORT_LOG_LEVEL_INFO, (String)"Received " + payload->len + " bytes: " + payload->data_byte[0]);
        String command = "{\"on\": true,\"hue\": 8418,\"sat\":50,\"bri\":"+String(payload->data_byte[0])+"}";
        Serial1.println(command);
        setHue(huegroup,command);
        if (String(payload->data_byte[0]) == "0"){
          Serial1.print("Data was 0, setting light off. \r\n");
          messagePort->DebugMessage(SI_MESSAGE_PORT_LOG_LEVEL_INFO, (String)"INSIDE IF STATEMENT " + payload->len + " bytes: " + payload->data_byte[0]);
          String command = "{\"on\": false,\"hue\": 8418,\"sat\":50,\"bri\":"+String(payload->data_byte[0])+"}";  
          setHue(huegroup,command);
        }
        Serial1.print("Breaking \r\n");
				break;
		}
	}
}

void setup() {
	// Init library on channel A and Arduino type MEGA 2560
	messagePort = new SiMessagePort(SI_MESSAGE_PORT_DEVICE_ARDUINO_NANO, SI_MESSAGE_PORT_CHANNEL_A, new_message_callback);

  //START
  Serial1.begin(9600);
     // attempt to connect to WiFi network
  while ( status != WL_CONNECTED) {
    Serial1.print("Attempting to connect to WPA SSID: ");
    status = WiFi.begin(ssid, pass);
  }
  printWifiStatus();
}

void loop() {
	// Make sure this function is called regularly
	messagePort->Tick();
}


boolean setHue(int lightNum,String command)
{
  if (client.connect(hueHubIP, hueHubPort))
  {
      Serial1.print("About to Set Hue.     ");
      client.print(F("PUT /api/"));
      client.print(hueUsername);
      client.print(F("/groups/"));
      client.print(lightNum); 
      client.println(F("/action HTTP/1.1"));
      client.println(F("keep-alive"));
      client.print(F("Host: "));
      client.println(hueHubIP);
      client.print(F("Content-Length: "));
      client.println(command.length());
      client.println(F("Content-Type: text/plain;charset=UTF-8"));
      client.println();  // blank line before body
      client.println(command);  // Hue command
      Serial1.print("Done Setting Hue.     ");

     client.flush();
     client.stop();
     return true;  // command executed
  }
  else
    Serial1.print("Hue Set Failed. /r/n");
    return false;  // command failed
}

void printWifiStatus()
{
  // print the SSID of the network you're attached to
  Serial1.print("SSID: ");
  Serial1.println(WiFi.SSID());

  // print your WiFi shield's IP address
  IPAddress ip = WiFi.localIP();
  Serial1.print("IP Address: ");
  Serial1.println(ip);

  // print the received signal strength
  long rssi = WiFi.RSSI();
  Serial1.print("Signal strength (RSSI):");
  Serial1.println(rssi);
  Serial1.print(" dBm \r\n");
}
