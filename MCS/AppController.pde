public class AppController {
  private StatusView statusView;
  private ConsoleView consoleView;
  private GraphicsView graphicsView;
  private SerialSelectionView serialSelectionView;
  private boolean isSerialSelectionViewOpen;
  private PVector statusViewDimensions;
  private PVector serialSelectionViewDimensions;
  
  public AppController(){
    this.statusViewDimensions = new PVector(400, 300);
    this.serialSelectionViewDimensions = new PVector(600, 500);
    this.statusView = new StatusView(this,      0,0,this.statusViewDimensions.x,this.statusViewDimensions.y);
    this.consoleView = new ConsoleView(this,    0,this.statusViewDimensions.y,this.statusViewDimensions.x,height-this.statusViewDimensions.y);
    this.graphicsView = new GraphicsView(this,  this.statusViewDimensions.x,0,width-this.statusViewDimensions.x,height);
    this.serialSelectionView = new SerialSelectionView(this, width/2 - this.serialSelectionViewDimensions.x/2, height/2 - this.serialSelectionViewDimensions.y/2, this.serialSelectionViewDimensions.x, this.serialSelectionViewDimensions.y);
  }
  
  public void show(){
    this.statusView.show();
    this.consoleView.show();
    this.graphicsView.show();
    if(this.isSerialSelectionViewOpen){
      noStroke();
      fill(0, 100);
      rectMode(CORNER);
      rect(0, 0, width, height);
      this.serialSelectionView.show();
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
    this.statusView.mousePressed();
    this.consoleView.mousePressed();
    this.graphicsView.mousePressed();
    if(this.isSerialSelectionViewOpen){
      this.serialSelectionView.mousePressed();
    }
  }
  
  public void keyPressed(){
    this.statusView.keyPressed();
    this.consoleView.keyPressed();
    this.graphicsView.keyPressed();
    if(this.isSerialSelectionViewOpen){
      this.serialSelectionView.keyPressed();
    }
  }
  
  public void openSerialSelectionView(){
    this.isSerialSelectionViewOpen = true;
  }
  
  public void closeSerialSelectionView(){
    this.isSerialSelectionViewOpen = false;
  }
}
