#include <Arduino.h>
#include <ESP8266WebServer.h>
#include <ESP8266WiFi.h>

#define relay D6

ESP8266WebServer server(80);
String lamp = "mati";

String ssid = "Anarchy99";
String password = "18042022";

void handleTest()
{
  String arg = server.arg("test");
  Serial.println(arg);
  lamp = arg;
  Serial.println(lamp);
  server.send(200, "text/plain", "hello world");
}

IPAddress local_ip(192, 168, 1, 12);
IPAddress gateway(192, 168, 1, 12);
IPAddress subnet(255, 255, 255, 0);
IPAddress dns1(8, 8, 8, 8);
IPAddress dns2(8, 8, 4, 4);

void setup()
{
  Serial.begin(9600);
  // put your setup code here, to run once:
  WiFi.mode(WIFI_AP);
  WiFi.softAP("Anarchy", "18042022");
  pinMode(relay, OUTPUT);
  digitalWrite(relay, LOW);

  Serial.println("connection wifi");
  WiFi.softAPConfig(local_ip, gateway, subnet);

  // while (WiFi.status() != WL_CONNECTED)
  // {
  //   delay(500);
  //   Serial.print(".");
  // }
  Serial.println("\n");
  Serial.println("--------------");
  Serial.print("ip mu ");
  Serial.println(WiFi.localIP());
  server.begin();
  server.on("/test", HTTP_GET, handleTest);
}

void loop()
{
  // put your main code here, to run repeatedly:
  server.handleClient();
  if (lamp == "nyala")
  {
    digitalWrite(relay, HIGH);
  }
  else
  {
    digitalWrite(relay, LOW);
  }
  // digitalWrite(relay, HIGH);
  // delay(1000);
  // digitalWrite(relay, LOW);
  // delay(1000);
}