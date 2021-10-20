#include <PubSubClient.h>
#include <ESP8266WiFi.h>
#include <stdlib.h>

int status1 = 12;  //Digital pin D6
int sensor = 13; //Digital Pin D7

const char* ssid = "Test-Ritwik";   //WiFi ssid
const char* password = "1234";   //WiFi password
/*MQTT connection details*/
const char* mqtt_server = "broker.hivemq.com";   //MQTT server URL
//topic to publish on
char topic[]="testtopic/2";


//string to be published
char pub_str[100];

/*function to detect reading of microwave sensor*/
bool getmotion(); 

WiFiClient espClient;
PubSubClient client(espClient);

void setup_wifi()
{
  delay(10);
  Serial.print("Connecting to...");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print("-");
  }
  Serial.println();
  Serial.println("WiFi Connected");
  Serial.println("WiFi got IP");
  Serial.println(WiFi.localIP());
}

void reconnect()
{
  while(!client.connected()){
    Serial.println("Attempting MQTT connection...");
    if(client.connect("clientId-pLyRpofXvp"))   //ClientID
    {
      Serial.println("Connected!");
      //topic to publish
      client.publish(topic,"Receiving data...");   //TopicID
      Serial.println("Subscribed!");
    }
    else
    {
      Serial.print("Failed, rc = ");
      Serial.print(client.state());
      Serial.println("Retrying connection in 5 seconds...");
      delay(5000);
    }
  }
}

void setup(void)
{
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 1883);   
  //1883 - default port for MQTT connection
  reconnect();
  pinMode(sensor, INPUT);
  pinMode(status1, OUTPUT);
}

void loop()
{
  if(!client.connected())
  {
    reconnect();
    Serial.print("Disconnected!");
  }
  bool flag=getmotion();
  char true_str []="true";
  char false_str []="false";
  if(flag==true){
    client.publish("testtopic/2",true_str);
    Serial.println(true_str);
  }
  else{
    client.publish(topic,false_str);
    Serial.println(false_str);  
  }
  delay(1000);
  client.loop();
}
  
bool getmotion(){
  int val = digitalRead(sensor);
  //Serial.println(state);
  if(val>0) {
    digitalWrite (status1, HIGH);
    Serial.println("Motion detected!");
    return true;
  }
  else {
    digitalWrite (status1, LOW);
    Serial.println("Motion absent!");
    return false;
  }
}
