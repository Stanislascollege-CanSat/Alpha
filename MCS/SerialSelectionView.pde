public class SerialSelectionView extends ViewController {
  public SerialSelectionView(AppController master, float x, float y, float w ,float h){
    super(master, x, y, w, h);
    this.elements.add(new ButtonElement(this.appController, 1280/2, 800/2, 50, "Close"){
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
