public class ConsoleView extends ViewController {
  
  
  public ConsoleView(AppController master, float x, float y, float w ,float h){
    super(master, x, y, w, h);
  }
  
  public void show(){
    this.drawStandardOutline();
  }
  
  public void mousePressed(){
    this.applyMousePressedToElements();
  }
  
  public void keyPressed(){
    this.applyKeyPressedToElements();
  }
}
