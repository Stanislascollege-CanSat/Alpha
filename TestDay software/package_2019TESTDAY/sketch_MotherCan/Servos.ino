// (void) openRingAndPins
void openRingAndPins(){
  
}

// (void) closePinsAndRing
void closePinsAndRing(){
  
}

// (void) startOpenRingServo
void openRingServo(){
  ringServoController.write(90 - ringServoSpeed);

  ringServoTurning = true;
  ringServoDirection = 1;
  millisRecord_ringServo = millis();
}

// (void) stopOpenRingServo
void stopOpenRingServo(){
  ringServoController.write(90);

  ringServoTurning = false;
  ringServoDirection = 0;

  delay(500);
  openPinsServo();
}

// (void) startCloseRingServo
void closeRingServo(){
  ringServoController.write(90 + ringServoSpeed);

  ringServoTurning = true;
  ringServoDirection = -1;
  millisRecord_ringServo = millis();
}

// (void) stopCloseRingServo
void stopCloseRingServo(){
  ringServoController.write(90);

  ringServoTurning = false;
  ringServoDirection = 0;
}

// (void) openPinsServo
void openPinsServo(){
  pinsServoController.write(pinsServoOpenPos);
}


// (void) closePinsServo
void closePinsServo(){
  pinsServoController.write(pinsServoClosePos);
}

