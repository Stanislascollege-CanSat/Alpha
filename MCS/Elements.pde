//
//
// Standard: Element
//
//

public float standardElementHeight = 25;

public class Element {
  public AppController appController;
  public PVector pos;
  public float width;
  public float height;
  public boolean selected;
  public PFont standardFont;
  
  public boolean backspacePressed;
  public int backspaceCount;
  
  public Element(AppController a, float x, float y, float w, float h){
    this.appController = a;
    this.pos = new PVector(x, y);
    this.width = w;
    this.height = h;
    this.standardFont = createFont("fonts/Exo_2/Exo2-Regular.ttf", 15);
  }
  
  public void update(){
  }
  
  public void show(){
    
  }
  
  public void drawStandardOutline(){
    stroke(0, 0, 255, 100);
    strokeWeight(1);
    noFill();
    rectMode(CORNER);
    rect(this.pos.x - 2, this.pos.y - 2, this.width + 4, this.height + 4);
  }
  
  public void select(){
    this.selected = true;
  }
  
  public void deselect(){
    this.selected = false;
  }
  
  public boolean isMousePositionWithinBorders(){
    if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.width && mouseY >= this.pos.y && mouseY <= this.pos.y + this.height){
      return true;
    }else{
      return false;
    }
  }
  
  public void elementPressed(){}
  
  public void keyboardInputTriggered(){}
  
  public void keyboardCode_BACKSPACE(){}
  
  public void keyboardRelease_BACKSPACE(){}
  
  public void keyboardCode_ENTER(){}
  
  public void keyPressed(){
    //if((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z') || (key >= '1' && key <= '2') || (key == ' ')){
    if(key >= ' ' && key <= '~'){
      this.keyboardInputTriggered();
    }else if(keyCode == BACKSPACE){
      this.keyboardCode_BACKSPACE();
    }else if(keyCode == ENTER || keyCode == RETURN){
      this.keyboardCode_ENTER();
    }
  }
  
  public void mousePressed(){
    if(this.isMousePositionWithinBorders()){
      // Element is pressed by the mouse
      this.select();
      this.elementPressed();
    }
  }
  
  public void keyReleased(){
    if(key == BACKSPACE){
      this.keyboardRelease_BACKSPACE();
    }
  }
}

//
//
// ButtonElement
//
//

public class ButtonElement extends Element {
  public String text;
  
  public ButtonElement(AppController a, float x, float y, float w, String t){
    super(a, x, y, w, standardElementHeight);
    this.text = t;
  }
  
  public void show(){
    stroke(86, 151, 255);
    strokeWeight(2);
    if(mousePressed && this.selected){
      fill(240);
    }else{
      fill(255);
    }
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.width, this.height);
    stroke(0);
    strokeWeight(1);
    fill(0);
    textAlign(CENTER);
    textFont(this.standardFont);
    textSize(15);
    text(this.text, (2 * this.pos.x + this.width)/2, (2 * this.pos.y + this.height)/2 + 6);
    if(this.selected){
      this.drawStandardOutline();
    }
  }
  
  public void clickCommand(){
    
  }
  
  public void elementPressed(){
    this.clickCommand();
  }
  
  
}

//
//
// TextBoxElement
//
//

public class TextBoxElement extends Element {
  public String text;
  
  public TextBoxElement(AppController a, float x, float y, float w, String t){
    super(a, x, y, w, standardElementHeight);
    this.text = t;
  }
  
  public void show(){
    stroke(0);
    strokeWeight(2);
    fill(255);
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.width, this.height);
    stroke(0);
    strokeWeight(1);
    fill(0);
    textAlign(CENTER);
    textFont(this.standardFont);
    textSize(15);
    text(this.text, (2 * this.pos.x + this.width)/2, (2 * this.pos.y + this.height)/2 + 6);
    if(this.selected){
      this.drawStandardOutline();
    }
  }
  
  public void setText(String t){
    this.text = t;
  }
}

//
//
// InputLineElement
//
//

public class InputLineElement extends Element {
  public String text;
  public int align;
  
  public InputLineElement(AppController a, float x, float y, float w, int align){
    super(a, x, y, w, standardElementHeight);
    this.text = "";
    this.align = align;
  }
  
  public void update(){
    if(keyPressed && key == BACKSPACE && !this.backspacePressed){
      this.backspaceCount += 1;
    }
    if(this.backspaceCount >= 60){
      this.backspacePressed = true;
    }
    if(this.backspacePressed){
      this.keyboardCode_BACKSPACE();
    }
  }
  
  public void keyboardRelease_BACKSPACE(){
    this.backspaceCount = 0;
    this.backspacePressed = false;
  }
  
  public void show(){
    stroke(0);
    strokeWeight(2);
    fill(255);
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.width, this.height);
    stroke(0);
    strokeWeight(1);
    fill(0);
    textAlign(this.align);
    textFont(this.standardFont);
    textSize(15);
    if(this.align == CENTER){
      text(this.text, (2 * this.pos.x + this.width)/2, (2 * this.pos.y + this.height)/2 + 6);
    }else if(this.align == LEFT){
      text(this.text, this.pos.x + 5, (2 * this.pos.y + this.height)/2 + 6);
    }else if(this.align == RIGHT){
      text(this.text, this.pos.x + this.width - 5, (2 * this.pos.y + this.height)/2 + 6);
    }
    if(this.selected){
      this.drawStandardOutline();
    }
  }
  
  public void keyboardInputTriggered(){
    if(this.selected){
      this.text += key;
    }
  }
  
  public void keyboardCode_BACKSPACE(){
    if(this.selected && this.text.length() > 0){
      this.text = this.text.substring(0, this.text.length() - 1);
    }
  }
  
  public void keyboardCode_ENTER(){
    
  }
}

//
//
// ConsoleElement
//
//

public class ConsoleElement extends Element {
  public ArrayList<MessageElement> messageElements;
  
  public ConsoleElement(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    this.messageElements = new ArrayList<MessageElement>();
  }
  
  public void show(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.width, this.height);
    if(this.selected){
      this.drawStandardOutline();
    }
  }
}

//
//
// MessageElement
//
//

public class MessageElement extends Element {  
  public MessageElement(AppController a, float h){
    super(a, 0, 0, 0, h);
  }
  
  public void show(float y){
    
  }
}
