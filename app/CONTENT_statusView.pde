import java.lang.Runnable;

Runnable DISPLAYINSTANCE_statusView = new Runnable(){
  public void run(){
    stroke(0);
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("Status View", width/2, height/2);
  }
};
