import java.lang.Runnable;

public Runnable CONTENT_view_right = new Runnable(){
  public void run(){
    // ===== VIEW CONTENTS HERE (SIMILAR TO draw() LOOP) ===== //

    translate(0,0,0);
    stroke(0);
	  noFill();
    rectMode(CORNER);
	  rect(-width/2,-height/2,width,height);


  }
};
