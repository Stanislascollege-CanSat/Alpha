import java.lang.Runnable;

Runnable DISPLAYINSTANCE_dashboardView = new Runnable(){
  private float console_height = 200;

  public void run(){
    noStroke();
    fill(0, 150);
    rectMode(CORNER);
    rect(0, height-this.console_height, width, this.console_height);
  }
};
