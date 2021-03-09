#include <EEPROM.h>
#include "EEPROMAnything.h"
#include <LiquidCrystal.h>
#include <MPU6050_tockn.h>
#include <Wire.h>

MPU6050 mpu6050(Wire);
const int alarmPin = 5;
const int relayPin = 10;
int Xacc, Yacc, Zacc, threshold = 0, thresholdSET = 20;
long debouncing_time = 35; //Debouncing Time in Milliseconds
volatile unsigned long last_micros;

LiquidCrystal lcd(12, 11, 9, 8, 7, 6);
struct sensorValue
{
  int X;
  int Y;
  int Z;
};
sensorValue acceleration;
void debounceInterrupt_Increment()
{
  if ((long)(micros() - last_micros) >= debouncing_time * 1000) {
    IncrementThreshold();
    last_micros = micros();
  }
}
void debounceInterrupt_Decrement()
{
  if ((long)(micros() - last_micros) >= debouncing_time * 1000) {
    DecrementThreshold();
    last_micros = micros();
  }
}
void IncrementThreshold() {
  thresholdSET = EEPROM.read(500);
  thresholdSET++;
  EEPROM.write(500, thresholdSET);
}
void DecrementThreshold() {
  thresholdSET = EEPROM.read(500);
  thresholdSET--;
  EEPROM.write(500, thresholdSET);
}
void setup() {
    Serial.begin(9600);
  Wire.begin();
  lcd.begin(16, 2);
  mpu6050.begin();
  mpu6050.calcGyroOffsets(true);
  attachInterrupt(0, debounceInterrupt_Increment, RISING);
  attachInterrupt(1, debounceInterrupt_Decrement, RISING);
  pinMode(alarmPin, OUTPUT);
  pinMode(relayPin, OUTPUT);
  digitalWrite(relayPin, HIGH);
  EEPROM.write(500, thresholdSET);
  digitalWrite(alarmPin, LOW);
  lcd.setCursor(0, 0);
  lcd.print("AME03LIMBOMBEROS");
   lcd.setCursor(0,1);
  lcd.print("MANTEN LA CALMA");
  delay(2500);
     lcd.clear();
    lcd.setCursor(0, 0);
  lcd.print("Calibrando...");
   delay(1000);
 mpu6050.update();
  sensorValue acceleration = { mpu6050.getAccX()*1000, mpu6050.getAccY()*1000, mpu6050.getAccZ()*10 };
  EEPROM_writeAnything(0, acceleration);
  EEPROM_readAnything(0, acceleration);
  lcd.clear();
}
void loop() {
  mpu6050.update();
  EEPROM_readAnything(0, acceleration);
  threshold = EEPROM.read(500);
  lcd.setCursor(0, 0);
  lcd.print("MONITOREO ACTIVO");
  lcd.setCursor(0,1);
  lcd.print("Limite: ");
  lcd.print(threshold);
  Xacc = mpu6050.getAccX()*1000;
  Yacc = mpu6050.getAccY()*1000;
  Zacc = mpu6050.getAccZ()*10;
  lcd.print(" X:");
   lcd.print(Xacc);

if((Xacc >= (acceleration.X + (threshold + 20))) || (Xacc <= (acceleration.X - (threshold + 20)))||(Yacc >= (acceleration.Y + (threshold + 20))) || (Yacc <= (acceleration.Y - (threshold + 20)))||(Zacc >= (acceleration.Z + (threshold + 20))) || (Zacc <= (acceleration.Z - (threshold + 20)))) {
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
    delay(50);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, LOW);
    delay(50);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
	delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
    delay(100);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(300);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
    delay(100);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(300);
    digitalWrite(alarmPin, LOW);  
    digitalWrite(relayPin, HIGH); 
    delay(100);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(300);
    digitalWrite(relayPin, LOW);
    digitalWrite(relayPin, HIGH);
    delay(75);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
    delay(50);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
    delay(50);
    digitalWrite(alarmPin, HIGH);
    digitalWrite(relayPin, LOW);
    delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
      delay(50);
         digitalWrite(alarmPin, HIGH);
         digitalWrite(relayPin, LOW);
      delay(75);
    digitalWrite(alarmPin, LOW);
        digitalWrite(relayPin, HIGH);
      delay(350);
       lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("ALARMA SOS!");
    lcd.setCursor(0,1);
    lcd.print("X");
    lcd.print(Xacc);
       lcd.print("  ");
        lcd.print("Y");
    lcd.print(Yacc);
          lcd.print("  ");
            lcd.print("Z");
    lcd.print(Zacc);
    delay(1000);
    digitalWrite(alarmPin, LOW);
  digitalWrite(relayPin, HIGH);
    lcd.clear();
  }

  
else if((Xacc >= (acceleration.X + (threshold + 10))) || (Xacc <= (acceleration.X - (threshold + 10)))||(Yacc >= (acceleration.Y + (threshold + 10))) || (Yacc <= (acceleration.Y - (threshold + 10)))||(Zacc >= (acceleration.Z + (threshold + 10))) || (Zacc <= (acceleration.Z - (threshold + 10)))) {


              digitalWrite(alarmPin, HIGH);
                  digitalWrite(relayPin, LOW);
          delay(250);
                   delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
      delay(75);
              digitalWrite(alarmPin, HIGH);
                  digitalWrite(relayPin, LOW);
          delay(250);
  digitalWrite(alarmPin, LOW);
  digitalWrite(relayPin, HIGH);
      delay(75);
              digitalWrite(alarmPin, HIGH);
                  digitalWrite(relayPin, LOW);
          delay(250);
                   delay(75);
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
      delay(100);
              digitalWrite(alarmPin, HIGH);
                  digitalWrite(relayPin, LOW);
           tone(alarmPin, 1000, 1500);
           digitalWrite(relayPin, LOW);
       lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("CUARTA ALARMA!");
    lcd.setCursor(0,1);
    lcd.print("X");
    lcd.print(Xacc);
       lcd.print("  ");
        lcd.print("Y");
    lcd.print(Yacc);
          lcd.print("  ");
            lcd.print("Z");
    lcd.print(Zacc);
    delay(1500);
    digitalWrite(alarmPin, LOW);
  digitalWrite(relayPin, HIGH);
    lcd.clear();
  }
  
else if((Xacc >= (acceleration.X + (threshold + 5))) || (Xacc <= (acceleration.X - (threshold + 5)))||(Yacc >= (acceleration.Y + (threshold + 5))) || (Yacc <= (acceleration.Y - (threshold + 5)))||(Zacc >= (acceleration.Z + (threshold + 5))) || (Zacc <= (acceleration.Z - (threshold + 5)))) {
              digitalWrite(alarmPin, HIGH);
              digitalWrite(relayPin, LOW);
              
          delay(250);
                
  
  digitalWrite(alarmPin, LOW);
  digitalWrite(relayPin, HIGH);
      delay(100);
              digitalWrite(alarmPin, HIGH);
              digitalWrite(relayPin, LOW);
          delay(250);
                   
    digitalWrite(alarmPin, LOW);
    digitalWrite(relayPin, HIGH);
    
      delay(100);
      digitalWrite(relayPin, LOW);
           tone(alarmPin, 1000, 1000);
       lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("TERCERA ALARMA!");
    lcd.setCursor(0,1);
    lcd.print("X");
    lcd.print(Xacc);
       lcd.print("  ");
        lcd.print("Y");
    lcd.print(Yacc);
          lcd.print("  ");
            lcd.print("Z");
    lcd.print(Zacc);
    delay(1500);
  digitalWrite(relayPin, HIGH);
    digitalWrite(alarmPin, LOW);
    lcd.clear();
  }
  else if((Xacc >= (acceleration.X + (threshold + 2))) || (Xacc <= (acceleration.X - (threshold + 2)))||(Yacc >= (acceleration.Y + (threshold + 2))) || (Yacc <= (acceleration.Y - (threshold + 2)))||(Zacc >= (acceleration.Z + (threshold + 2))) || (Zacc <= (acceleration.Z - (threshold + 2)))) {
    digitalWrite(alarmPin, HIGH);
  digitalWrite(relayPin, LOW);
      delay(250);
    digitalWrite(alarmPin, LOW);
     digitalWrite(relayPin, HIGH);
      delay(75);
      digitalWrite(relayPin, LOW);
      tone(alarmPin, 1000, 1000);
       lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("SEGUNDA ALARMA!");
    lcd.setCursor(0,1);
    lcd.print("X");
    lcd.print(Xacc);
       lcd.print("  ");
        lcd.print("Y");
    lcd.print(Yacc);
          lcd.print("  ");
            lcd.print("Z");
    lcd.print(Zacc);
    delay(1500);
    digitalWrite(alarmPin, LOW);
  digitalWrite(relayPin, HIGH);
    lcd.clear();
  }
  else if((Xacc >= (acceleration.X + threshold)) || (Xacc <= (acceleration.X - threshold))||(Yacc >= (acceleration.Y + threshold)) || (Yacc <= (acceleration.Y - threshold))||(Zacc >= (acceleration.Z + threshold)) || (Zacc <= (acceleration.Z - threshold))) {
      digitalWrite(relayPin, LOW);
        digitalWrite(alarmPin, HIGH);
      delay(1000);
    digitalWrite(alarmPin, LOW);
     digitalWrite(relayPin, LOW);
      delay(50);
       lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("PRIMERA ALARMA!");
    lcd.setCursor(0,1);
    lcd.print("X");
    lcd.print(Xacc);
       lcd.print("  ");
        lcd.print("Y");
    lcd.print(Yacc);
          lcd.print("  ");
            lcd.print("Z");
    lcd.print(Zacc);
    delay(1500);
   digitalWrite(relayPin, HIGH);

    lcd.clear();   
  }  
 
}
