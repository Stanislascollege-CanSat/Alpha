public class SerialSelectionView extends ViewController {
  public SerialSelectionView(AppController master, float x, float y, float w ,float h){
    super(master, x, y, w, h);
    this.elements.add(new ButtonElement(this.appController, this.pos.x + this.width/2 - 25, this.pos.y + this.height/2 - 25/2, 50, "Close"){
      public void clickCommand(){
        this.appController.closeSerialSelectionView();
      }
    });
  }
  
  public void show(){
    this.drawStandardOutline();
    for(Element e : this.elements){
      e.show();
    }
  }
  
  public void mousePressed(){
    this.applyMousePressedToElements();
  }
  
  public void keyPressed(){
    this.applyKeyPressedToElements();
  }
}
