public class StatusView extends ViewController {
  ButtonElement selectSerialButton;
  InputLineElement serialNameTextBox;
  
  public StatusView(AppController master, float x, float y, float w ,float h){
    super(master, x, y, w, h);
    this.selectSerialButton = new ButtonElement(this.appController, 5, 5, 130, "Select serial-port"){
      public void clickCommand(){
        this.appController.openSerialSelectionView();
      }
    };
    this.serialNameTextBox = new InputLineElement(this.appController, 140, 5, this.width - 145);
    this.elements.add(this.selectSerialButton);
    this.elements.add(this.serialNameTextBox);
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
