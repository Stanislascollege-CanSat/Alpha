public class AppController {
  private StatusView statusView;
  private ConsoleView consoleView;
  private GraphicsView graphicsView;
  private SerialSelectionView serialSelectionView;
  private boolean isSerialSelectionViewOpen;
  private PVector statusViewDimensions;
  private Serial serialPort;
  
  public AppController(){
    this.statusViewDimensions = new PVector(400, 300);
    this.statusView = new StatusView(this,      0,0,this.statusViewDimensions.x,this.statusViewDimensions.y);
    this.consoleView = new ConsoleView(this,    0,this.statusViewDimensions.y,this.statusViewDimensions.x,height-this.statusViewDimensions.y);
    this.graphicsView = new GraphicsView(this,  this.statusViewDimensions.x,0,width-this.statusViewDimensions.x,height);
    this.serialSelectionView = new SerialSelectionView(this, 0,0,this.statusViewDimensions.x,this.statusViewDimensions.y);
  }
  
  public void show(){
    this.consoleView.show();
    this.graphicsView.show();
    if(this.isSerialSelectionViewOpen){
      this.serialSelectionView.show();
    }else{
      this.statusView.show();
    }
    fill(0);
    textAlign(LEFT);
    text(int(frameRate), width-30, 20);
  }
  
  public void deselectAllElements(){
    this.statusView.deselectAllElements();
    this.consoleView.deselectAllElements();
    this.graphicsView.deselectAllElements();
    this.serialSelectionView.deselectAllElements();
  }
  
  public void mousePressed(){
    this.deselectAllElements();
    this.consoleView.mousePressed();
    this.graphicsView.mousePressed();
    if(this.isSerialSelectionViewOpen){
      this.serialSelectionView.mousePressed();
    }else{
      this.statusView.mousePressed();
    }
  }
  
  public void keyPressed(){
    this.consoleView.keyPressed();
    this.graphicsView.keyPressed();
    if(this.isSerialSelectionViewOpen){
      this.serialSelectionView.keyPressed();
    }else{
      this.statusView.keyPressed();
    }
  }
  
  public void keyReleased(){
    this.consoleView.keyReleased();
    this.graphicsView.keyReleased();
    if(this.isSerialSelectionViewOpen){
      this.serialSelectionView.keyReleased();
    }else{
      this.statusView.keyReleased();
    }
  }
  
  public void openSerialSelectionView(){
    this.serialSelectionView.pushAvailableSerialPorts(Serial.list());
    this.isSerialSelectionViewOpen = true;
  }
  
  public void closeSerialSelectionView(){
    this.isSerialSelectionViewOpen = false;
  }
}
