public class GraphicsView extends ViewController {
  
  
  public GraphicsView(AppController master, float x, float y, float w ,float h){
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
