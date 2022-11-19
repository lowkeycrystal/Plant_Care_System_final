#include <Wire.h>
#include <dht.h>
#include <BH1750.h>
#include <SoftwareSerial.h>

// Temperature and Humidity Sensor Pin
#define DHT11_PIN 7


// Bluetooth Serial to send and receive
SoftwareSerial bluetoothSerial(0, 1); // RX, TX


dht DHT;
unsigned long lastSentTime = 0;
BH1750 lightMeter;
const int AirValue = 690;   //you need to replace this value with your reading on Air
const int WaterValue = 200;  //you need to replace this value with your reading on Water
int soilMoistureValue = 0;
int soilmoisturepercent=0;
String soilmoisturepercentMax = "100";
String soilmoisturepercentMin = "0";

void setup()
{
  Serial.begin(9600);
  bluetoothSerial.begin(9600);
  Wire.begin();
  lightMeter.begin();
}

void loop()
{

   bool output = true;
  float lux = lightMeter.readLightLevel();
  int sz = DHT.read11(DHT11_PIN);
  soilMoistureValue = analogRead(A0);  //put Sensor insert into soil
  soilmoisturepercent = map(soilMoistureValue, AirValue, WaterValue, 0, 100);

   if ((millis() - lastSentTime) >= 1000)
  {
    float temp = DHT.temperature;
    float humid = DHT.humidity;
    //dht.readHumidity();

    //Serial.print("Temperature: ");
    //Serial.print(temp);
   // Serial.println(" *C ");
   //Serial.println(String(moisture_percentage));
    Serial.println("LX:" + String(lux));
    delay(500);
    if (soilMoistureValue > 690){
    Serial.print("MS:" + String(soilmoisturepercentMin));
     } else if (soilMoistureValue < 200 ){
   Serial.print("MS:" + String(soilmoisturepercentMax));
   } else{ 
  Serial.print("MS:" + String(soilmoisturepercent));
  }
    delay(500);
    Serial.println("TP:" + String(temp));
    delay(500);
    Serial.println("HD:" + String(humid));
    delay(500);
   // Serial.println("LX, " + String(lux) + ";");
   // Serial.println("MS, " + String(moisture_percentage)+", "+ ";");
   // Serial.println("TP, " + String(temp) +", "+ ";");
   // Serial.println("HD, " + String(humid) + ", "+";");
    
    //Serial.print(humid);
   // Serial.println(" % ");

    // arduino send, phone receive
    //bluetoothSerial.println("TP, " + String(temp) +", "+ ";");
    //bluetoothSerial.println("HD, " + String(humid) + ", "+";");
    //bluetoothSerial.println(String(humid));

    lastSentTime = millis();
  }
}
