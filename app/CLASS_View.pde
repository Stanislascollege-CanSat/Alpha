import java.lang.Runnable;

public class View {
  // PROPERTIES
  private PVector pos;
  private Runnable EXT_displayMethod;

  // INIT
  public View(float x, float y, float z, Runnable exe){
    this.pos = new PVector(x,y,z);
    this.EXT_displayMethod = exe;
  }

  // METHODS
  public void show(){
    translate(this.pos.x, this.pos.y, this.pos.z);
    this.EXT_displayMethod.run();
    translate(-this.pos.x, -this.pos.y, -this.pos.z);
  }

  public void curtainShow(float red, float green, float blue, float strength){
    this.show();
    translate(this.pos.x, this.pos.y, this.pos.z);
    rectMode(CORNER);
    noStroke();
    fill(red, green, blue, strength);
    rect(0, 0, width, height);
    translate(-this.pos.x, -this.pos.y, -this.pos.z);
  }


}
