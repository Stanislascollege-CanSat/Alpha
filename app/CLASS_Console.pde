public class Console {
  // PROPERTIES
  private PVector pos;
  private ArrayList<String> msgList;
  private int fontSize;


  // CONSTRUCTORS
  public Console(float x, float y){
    this.pos = new PVector(x,y);
    this.msgList = new ArrayList<String>();
    this.fontSize = 12;
    this.msgList.add("This is a logging message");
  }


  // PRIVATE METHODS



  // PUBLIC METHODS
  public void show(){
    translate(this.pos.x, this.pos.y);
    stroke(0);
    fill(0);
    textAlign(LEFT);
    textSize(this.fontSize);
    for(int i = 0; i < this.msgList.size(); ++i){
      text(this.msgList.get(i), 20, (i+1)*this.fontSize);
    }
    translate(-this.pos.x, -this.pos.y);
  }

  public void log(String msg){
    msgList.add(msg);
  }
}
