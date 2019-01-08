import processing.serial.*;

AppController appController;

public void setup(){
  //fullScreen(P3D);
  size(1000, 700, P3D);
  pixelDensity(2);
  smooth(8);
  frameRate(60);
  
  appController = new AppController();
}

public void draw(){
  background(255);
  
  appController.show();
}

public void mousePressed(){
  appController.mousePressed();
}

public void keyPressed(){
  appController.keyPressed();
}

public void keyReleased(){
  appController.keyReleased();
}
