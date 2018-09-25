public class View {
  // PROPERTIES
  private PVector pos;
  private ViewContent viewContent;

  // CONSTRUCTORS
  public View(float x, float y, float z, ViewContent content){
    this.pos = new PVector(x,y,z);
    this.viewContent = content;
  }

  // METHODS
  public void show(){
    translate(this.pos.x, this.pos.y, this.pos.z);
    this.viewContent.show();
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
