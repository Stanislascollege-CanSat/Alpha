public class SerialSelectionView extends ViewController {
  public ArrayList<String> availableSerialPorts;
  
  public SerialSelectionView(AppController master, float x, float y, float w ,float h){
    super(master, x, y, w, h);
    this.availableSerialPorts = new ArrayList<String>();
    this.elements.add(new ButtonElement(this.appController, this.pos.x + this.width/2 - 25, this.pos.y + this.height/2 - 25/2, 50, "Close"){
      public void clickCommand(){
        this.appController.closeSerialSelectionView();
      }
    });
  }
  
  public void pushAvailableSerialPorts(String[] list){
    this.availableSerialPorts.clear();
    for(String s : list){
      this.availableSerialPorts.add(s);
    }
    printArray(this.availableSerialPorts);
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
