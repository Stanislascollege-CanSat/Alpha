#include <SPI.h>
#include <RH_RF95.h>

// DEFINITIONS
#define RFM95_RST 2
#define RFM95_CS 4
#define RFM95_INT 3

#define RF95_FREQ 868.0

// RADIO SETUP
RH_RF95 rf95(RFM95_CS, RFM95_INT);

String serialReadString;


// (void) setup
void setup(){
  // PINMODES
  pinMode(RFM95_RST, OUTPUT);
    digitalWrite(RFM95_RST, HIGH);


  serialReadString = "";
  
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
}


// (void) loop
void loop(){
  if(Serial.available()){
    serialReadString = Serial.readString();
    uint8_t data[100] = "";
    strcat((char*) data, String(serialReadString).c_str());
    Serial.println((char*)data);

    rf95.send(data, sizeof(data));
  }
}

