//
//Test-day mothercan software
//Rens Dur
//Project Beta
//

// INCLUDES
#include <Servo.h>
#include <SPI.h>
#include <RH_RF95.h>


// DEFINITIONS
#define RFM95_RST 9
#define RFM95_CS 10
#define RFM95_INT 3

#define RF95_FREQ 868.0

// SERIAL VARIABLES
String serialReadStringBuffer;
String radioReadStringBuffer;

// RADIO SETUP
RH_RF95 rf95(RFM95_CS, RFM95_INT);

// SERVO DEFINITIONS
Servo ringServoController;
Servo pinsServoController;

// SERVO PWM-PINS
int ringServoPIN;
int pinsServoPIN;

// CONTINUOUS ROTATION SERVO VARIABLES
bool ringServoTurning;
int ringServoDirection;
unsigned long millisRecord_ringServo;
int ringServoSpeed;
unsigned long ringServoDuration;

// COORDINATE ROTATION SERVO VARIABLES
int pinsServoClosePos;
int pinsServoOpenPos;

// (void) setup
void setup(){
  // PINMODES
  pinMode(RFM95_RST, OUTPUT);
    digitalWrite(RFM95_RST, HIGH);

  // SERIAL SETUP
  serialReadStringBuffer = "";
  radioReadStringBuffer = "";
  
  Serial.begin(115200);
  while(!Serial){delay(1);}

  // RADIO: MANUAL RESET
  digitalWrite(RFM95_RST, LOW);
  delay(10);
  digitalWrite(RFM95_RST, HIGH);
  delay(10);

  // RADIO: INIT TEST
  while(!rf95.init()){while(1);}

  // RADIO: SET FREQUENCY TEST
  if(!rf95.setFrequency(RF95_FREQ)){while(1);}

  // RADIO: SET TX POWER
  rf95.setTxPower(23, false);


  // SERVO SETUP

  ringServoPIN = 5;
  pinsServoPIN = 6;

  ringServoController.attach(ringServoPIN);
  pinsServoController.attach(pinsServoPIN);

  ringServoTurning = false;
  ringServoDirection = 0;
  millisRecord_ringServo = 0;

  ringServoSpeed = 90;
  ringServoDuration = 1000;

  pinsServoClosePos = 2;
  pinsServoOpenPos = 25;

  ringServoController.write(90);
  pinsServoController.write(0);
}


// (void) loop
void loop(){
  // CHECK FOR SERVO: millisRecord_ringServo
  if((ringServoTurning) && (millis() - millisRecord_ringServo >= ringServoDuration)){
    switch(ringServoDirection){
      case 1: stopOpenRingServo(); break;
      case -1: stopCloseRingServo(); break;
    }
  }

  
  // TEST FOR RECEIVED DATA FROM RADIO
  if(rf95.available()){
    uint8_t receiveBuffer[RH_RF95_MAX_MESSAGE_LEN];
    uint8_t receiveLength = sizeof(receiveBuffer);
    if(rf95.recv(receiveBuffer, &receiveLength)){
      //RH_RF95::printBuffer("Received: ", receiveBuffer, receiveLength);
      radioReadStringBuffer = String((char*)receiveBuffer);
      Serial.println(String((char*)receiveBuffer));
      if(radioReadStringBuffer.equals("open")){
        openRingServo();
      }else if(radioReadStringBuffer.equals("closeRing")){
        closeRingServo();
      }else if(radioReadStringBuffer.equals("closePins")){
        closePinsServo();
      }
    }
    //delete receiveBuffer;
    //delete &receiveLength;
  }

  // TEST FOR RECEIVED COMMAND FROM SERIAL
  if(Serial.available()){
    serialReadStringBuffer = Serial.readString();
    if(serialReadStringBuffer.equals("open")){
      openRingServo();
    }else if(serialReadStringBuffer.equals("closeRing")){
      closeRingServo();
    }else if(serialReadStringBuffer.equals("closePins")){
      closePinsServo();
    }
    
  }
}

