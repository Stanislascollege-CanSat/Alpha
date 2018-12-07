public class ViewController {
  public AppController appController;
  public ArrayList<Element> elements;
  public PVector pos;
  public float width;
  public float height;
  
  public ViewController(AppController master, float x, float y, float w ,float h){
    this.appController = master;
    this.elements = new ArrayList<Element>();
    this.pos = new PVector(x, y);
    this.width = w;
    this.height = h;
  }
  
  public void drawStandardOutline(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.width, this.height);
  }
  
  public void applyMousePressedToElements(){
    for(Element e : this.elements){
      e.mousePressed();
    }
  }
  
  public void applyKeyPressedToElements(){
    for(Element e : this.elements){
      e.keyPressed();
    }
  }
  
  public void deselectAllElements(){
    for(Element e : this.elements){
      e.deselect();
    }
  }
}
