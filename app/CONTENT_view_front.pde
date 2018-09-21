import java.lang.Runnable;

float front_up = 0;
boolean front_direction = true;

public Runnable CONTENT_view_front = new Runnable(){
  public void run(){
    // ===== VIEW CONTENTS HERE (SIMILAR TO draw() LOOP) ===== //
    
    textAlign(CENTER);
    textSize(25);
    fill(0);
    text("Status Overview" + frameRate, 0, -height/1.8);
    
    translate(-width/2.5,height/4, 0);
    rotateX(-PI/2);
    noStroke();
    fill(200,0,0);
    ellipse(0,0,150,150);
    translate(0,0,-100+front_up);
    stroke(0);
    fill(0,255,0);
    box(80);
    translate(0,0,100-front_up);
    translate(0,0,15);
    noStroke();
    fill(51,150);
    ellipse(0,0,150,150);
    translate(0,0,15);
    fill(51,50);
    ellipse(0,0,150,150);
    translate(0,0,-30);
    translate(width/1.25,0,0);
    fill(200,0,0);
    ellipse(0,0,150,150);
    translate(0,0,-100+front_up);
    stroke(0);
    fill(0,0,255);
    box(80);
    translate(0,0,100-front_up);
    translate(0,0,15);
    noStroke();
    fill(51,150);
    ellipse(0,0,150,150);
    translate(0,0,15);
    fill(51,50);
    ellipse(0,0,150,150);
    translate(0,0,-30);
    rotateX(PI/2);
    translate(-width/2.5, -height/4,0);
    
    if(front_direction){
      front_up += 0.2;
      if(front_up >= 10){
        front_up = 10;
        front_direction = false;
      }
    }else{
      front_up -= 0.2;
      if(front_up <= -10){
        front_up = -10;
        front_direction = true;
      }
    }
    
  }
};
