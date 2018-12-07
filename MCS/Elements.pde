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
  
  public Element(AppController a, float x, float y, float w, float h){
    this.appController = a;
    this.pos = new PVector(x, y);
    this.width = w;
    this.height = h;
    this.standardFont = createFont("fonts/Exo_2/Exo2-Regular.ttf", 15);
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
  
  public InputLineElement(AppController a, float x, float y, float w){
    super(a, x, y, w, standardElementHeight);
    this.text = "";
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
