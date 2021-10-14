#include <SPI.h>
#include <WiFiNINA.h>
#include <si_message_port.hpp>

//  Hue constants
const char hueHubIP[] = "192.168.1.xxx";  // Hue hub IP
const char hueUsername[] = "yourhueusername";  // Hue username
const int hueHubPort = 80;

//  Hue variables
boolean hueOn;  // on/off
int hueBri;  // brightness value
long hueHue;  // hue value
String hueCmd;  // Hue command

unsigned long buffer=0;  //buffer for received data storage
unsigned long addr;

char ssid[] = "YourWifi";            // your network SSID (name)
char pass[] = "WifiPassword";        // your network password

int status = WL_IDLE_STATUS;     // the Wifi radio's status

SiMessagePort* messagePort;

WiFiClient client;

static void new_message_callback(uint16_t message_id, struct SiMessagePortPayload* payload) {
	// Do something with a message from Air Manager or Air Player
   Serial1.print("Received Message from AM. ");
	// The arguments are only valid within this function!
	// Make a clone if you want to store it

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
        setHue(3,command);
        if (String(payload->data_byte[0]) == "0"){
          Serial1.print("Data was 0, setting light off. \r\n");
          messagePort->DebugMessage(SI_MESSAGE_PORT_LOG_LEVEL_INFO, (String)"INSIDE IF STATEMENT " + payload->len + " bytes: " + payload->data_byte[0]);
          String command = "{\"on\": false,\"hue\": 8418,\"sat\":50,\"bri\":"+String(payload->data_byte[0])+"}";  
          setHue(2,command);
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
    // Connect to WPA/WPA2 network
    Serial1.print("Attempting to connect to WPA SSID: ");
    status = WiFi.begin(ssid, pass);
  }

  printWifiStatus();
}

void loop() {
	// Make sure this function is called regularly
	messagePort->Tick();

	// You can send your own messages to Air Manager or Air Player
	//messagePort->SendMessage(123);
	//messagePort->SendMessage(123, "hello");
	//messagePort->SendMessage(123, (int32_t)1000);
	//messagePort->SendMessage(123, 2.5f);
	//messagePort->SendMessage(123, (uint8_t) 0xAA);
 
}


boolean setHue(int lightNum,String command)
{
  if (client.connect(hueHubIP, hueHubPort))
  {
    //while (client.connected())
    //{
      Serial1.print("About to Set Hue.     ");
      //messagePort->DebugMessage(SI_MESSAGE_PORT_LOG_LEVEL_INFO, (String)"About to Set Hue");
      //client.print(F("PUT /api/s1hucok3IWwWmU65aWtyHd0JJKuMDV3rLJ7JcPNE/lights/2/"));
      client.print(F("PUT /api/"));
      client.print(hueUsername);
      //client.print(F("/lights/"));
       client.print(F("/groups/"));
      client.print(lightNum);  // hueLight zero based, add 1
      //client.println(F("/state HTTP/1.1"));
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
    //}
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