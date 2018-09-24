import java.lang.Runnable;

Runnable DISPLAYINSTANCE_liveGraphsView = new Runnable(){
  public void run(){
    stroke(0);
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text("Live Graphs View", width/2, height/2);
  }
};
