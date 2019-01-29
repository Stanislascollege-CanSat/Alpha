SpaceAnimation anim;

public void setup(){
  size(800, 800, P2D);
  pixelDensity(displayDensity());
  smooth(8);
  
  anim = new SpaceAnimation();
}

public void draw(){
  background(255);
  
  anim.show();
}
