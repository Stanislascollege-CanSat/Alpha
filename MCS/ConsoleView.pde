public class ConsoleView extends ViewController {
  public ConsoleElement consoleElement;
  public InputLineElement inputElement;
  
  
  public ConsoleView(AppController master, float x, float y, float w ,float h){
    super(master, x, y, w, h);
    this.consoleElement = new ConsoleElement(this.appController, this.pos.x, this.pos.y, this.width, this.height - 35);
    this.inputElement = new InputLineElement(this.appController, this.pos.x + 5, this.pos.y + this.height - 5 - standardElementHeight, this.width - 10, LEFT);
    this.elements.add(this.consoleElement);
    this.elements.add(this.inputElement);
  }
  
  public void show(){
    this.drawStandardOutline();
    for(Element e : this.elements){
      e.update();
      e.show();
    }
  }
  
  public void mousePressed(){
    this.applyMousePressedToElements();
  }
  
  public void keyPressed(){
    this.applyKeyPressedToElements();
  }
  
  public void keyReleased(){
    this.applyKeyReleasedToElements();
  }
}
