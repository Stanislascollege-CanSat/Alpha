// Elements.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public interface Element_Interface {
  public void select();
  public void deselect();
  public void resize(float x, float y, float w, float h);
  public void show();
  public void drawSelectionOutline();
  public boolean mousePressIsWithinBorder();
  public void mousePressed();
  public void mouseReleased();
  public void keyPressed(char k, int c);
  public void keyTyped(char k);
  public void keyReleased();
  
  public void clickEvent();
}

public class Element implements Element_Interface {
  public AppController appController;
  public PVector pos;
  public PVector dim;
  public boolean selected;
  public boolean mouseHeld;
  public int layer;
  
  public Element(AppController a, float x, float y, float w, float h){
    this.appController = a;
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);
    this.selected = false;
    this.mouseHeld = false;
    this.layer = 0;
  }
  
  public void select(){
    this.selected = true;
  }
  
  public void deselect(){
    this.selected = false;
  }
  
  public void drawSelectionOutline(){
    stroke(0, 0, 255, 100);
    strokeWeight(1);
    noFill();
    rectMode(CORNER);
    rect(this.pos.x-2, this.pos.y - this.dim.y/2 - 2, this.dim.x+4, this.dim.y+4);
  }
  
  public void resize(float x, float y, float w, float h){
    this.pos.set(x, y);
    this.dim.set(w, h);
  }
  
  public boolean mousePressIsWithinBorder(){
    if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.dim.x && mouseY >= this.pos.y - this.dim.y/2 && mouseY <= this.pos.y + this.dim.y/2){
      // User clicked element
      return true;
    }
    return false;
  }
  
  public void mousePressed(){
    if(this.mousePressIsWithinBorder()){
      // User clicked element
      this.clickEvent();
      this.mouseHeld = true;
      this.select();
    }
  }
  
  public void mouseReleased(){
    this.mouseHeld = false;
  }
  
  public void keyPressed(char k, int c){
    
  }
  
  public void keyTyped(char k){
    
  }
  
  public void keyReleased(){
    
  }
  
  public void show(){
    stroke(0);
    strokeWeight(2);
    fill(255);
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    
    if(this.selected){
      this.drawSelectionOutline();
    }
  }
  
  public void clickEvent(){}
}

//-----------------------------------------------------------------------------------------------------------------//

public class ButtonElement extends Element {
  public float defaultHeight;
  public String text;
  
  public ButtonElement(AppController a, float x, float y, float w, String t){
    super(a, x, y, w, 30);
    this.defaultHeight = 30;
    this.text = t;
  }
  
  public ButtonElement(AppController a, float x, float y, float w, float h, String t){
    super(a, x, y, w, h);
    this.defaultHeight = h;
    this.text = t;
  }
  
  public void resize(float x, float y, float w){
    this.pos.set(x, y);
    this.dim.set(w, this.defaultHeight);
  }
  
  public void resize(float x, float y, float w, float h){
    this.pos.set(x, y);
    this.dim.set(w, h);
  }
  
  public void show(){
    stroke(56, 132, 255);
    strokeWeight(2);
    if(this.mouseHeld){
      fill(200);
    }else{
      fill(255);
    }
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y - this.dim.y/2, this.dim.x, this.dim.y);
    
    strokeWeight(1);
    fill(0);
    
    textAlign(CENTER);
    textFont(fonts.get("SF").get("Regular"));
    text(this.text, this.pos.x + this.dim.x/2, this.pos.y + 6);
    
    if(this.selected){
      this.drawSelectionOutline();
    }
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class UtilityButtonElement extends ButtonElement {
  public UtilityButtonElement(AppController a, float x, float y){
    super(a, x, y, 20, 20, "...");
  }
  
  public void resize(float x, float y){
    this.pos.set(x, y);
    this.dim.set(this.defaultHeight, this.defaultHeight);
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class TextButtonElement extends ButtonElement {
  public TextButtonElement(AppController a, float x, float y, float w, String t){
    super(a, x, y, w, 20, t);
  }
  
  public void show(){
    stroke(56, 132, 255);
    fill(56, 132, 255);
    
    if(this.mouseHeld){
      stroke(0);
      fill(0);
    }
    
    textAlign(CENTER);
    textFont(fonts.get("SF").get("Regular"));
    text(this.text, this.pos.x + this.dim.x/2, this.pos.y + 6);
    
    //if(this.selected){
    //  stroke(0, 100);
    //  strokeWeight(1);
    //  line(this.pos.x + this.dim.x/2 - textWidth(this.text)/2, this.pos.y + this.dim.y/2 + 8, this.pos.x + this.dim.x/2 + textWidth(this.text)/2, this.pos.y + this.dim.y/2 + 8);
    //}
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class TextElement extends ButtonElement {
  public int alignment;
  
  public TextElement(AppController a, float x, float y, float w, String t, int align){
    super(a, x, y, w, 20, t);
    this.alignment = align;
  }
  
  public void setText(String t){
    this.text = t;
  }
  
  public void show(){
    stroke(0);
    fill(0);
    
    textFont(fonts.get("SF").get("Regular"));
    
    if(this.alignment == CENTER){
      textAlign(CENTER);
      text(this.text, this.pos.x + this.dim.x/2, this.pos.y + 6);
    }else if(this.alignment == LEFT){
      textAlign(LEFT);
      text(this.text, this.pos.x + 10, this.pos.y + 6);
    }else if(this.alignment == RIGHT){
      textAlign(RIGHT);
      text(this.text, this.pos.x + this.dim.x - 10, this.pos.y + 6);
    }
    
    //if(this.selected){
    //  stroke(0, 100);
    //  strokeWeight(1);
    //  line(this.pos.x + this.dim.x/2 - textWidth(this.text)/2, this.pos.y + this.dim.y/2 + 8, this.pos.x + this.dim.x/2 + textWidth(this.text)/2, this.pos.y + this.dim.y/2 + 8);
    //}
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class LineInputElement extends Element {
  public float defaultHeight;
  public String text;
  public String displayText;
  public boolean backspaceStillPressed;
  public int backspaceCount;
  public PFont stdFont;
  public boolean contentsHidden;
  
  public LineInputElement(AppController a, float x, float y, float w){
    super(a, x, y, w, 30);
    this.defaultHeight = 30;
    this.text = "";
    this.displayText = "";
    this.backspaceCount = 0;
    this.stdFont = fonts.get("PlexMono").get("Regular");
    this.contentsHidden = false;
  }
  
  public LineInputElement(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    this.defaultHeight = h;
    this.text = "";
    this.displayText = "";
    this.backspaceCount = 0;
    this.stdFont = fonts.get("PlexMono").get("Regular");
    this.contentsHidden = false;
  }
  
  public void hideContents(boolean a){
    this.contentsHidden = a;
    if(this.contentsHidden){
      this.displayText = "";
      for(int i = 0; i < this.text.length(); ++i){
        this.displayText += "*";
      }
    }else{
      this.displayText = this.text;
    }
    
    textFont(this.stdFont);
    while(textWidth(this.displayText) > this.dim.x - 20){
      this.displayText = this.displayText.substring(1, this.displayText.length());
    }
  }
  
  public void resize(float x, float y, float w){
    this.pos.set(x, y);
    this.dim.set(w, this.defaultHeight);
  }
  
  public void reset(){
    this.text = "";
    this.displayText = "";
  }
  
  public String getValue(){
    return this.text;
  }
  
  public void show(){
    stroke(0);
    strokeWeight(2);
    if(this.mouseHeld){
      fill(200);
    }else{
      fill(255);
    }
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y - this.dim.y/2, this.dim.x, this.dim.y);
    
    strokeWeight(1);
    fill(0);
    
    textAlign(LEFT);
    textFont(this.stdFont);
    text(this.displayText + (this.selected ? "_" : ""), this.pos.x + 10, this.pos.y + 6);
    
    if(this.selected){
      this.drawSelectionOutline();
    }
    
    //update text input
    if(this.backspaceStillPressed){
      this.backspaceCount++;
    }
    
    if(this.backspaceCount >= frameRate/2){
      this.backspaceTriggered();
    }
  }
  
  public void enterEvent(){}
  
  public void keyPressed(char k, int c){
    if(k == BACKSPACE){
      this.backspaceTriggered();
      this.backspaceStillPressed = true;
    }else if(k == ENTER || k == RETURN){
      this.enterEvent();
    }
  }
  
  public void keyReleased(){
    this.backspaceStillPressed = false;
    this.backspaceCount = 0;
  }
  
  public void backspaceTriggered(){
    if(ALT_PRESSED){
      this.reset();
    }else if(this.text.length() > 0){
      this.text = this.text.substring(0, this.text.length() - 1);
      if(this.contentsHidden){
        this.displayText = "";
        for(int i = 0; i < this.text.length(); ++i){
          this.displayText += "*";
        }
      }else{
        this.displayText = this.text;
      }
      
      textFont(this.stdFont);
      while(textWidth(this.displayText) > this.dim.x - 20){
        this.displayText = this.displayText.substring(1, this.displayText.length());
      }
    }
  }
  
  public void keyTyped(char k){
    this.text += k;
    if(this.contentsHidden){
      this.displayText = "";
      for(int i = 0; i < this.text.length(); ++i){
        this.displayText += "*";
      }
    }else{
      this.displayText = this.text;
    }
    
    textFont(this.stdFont);
    while(textWidth(this.displayText) > this.dim.x - 20){
      this.displayText = this.displayText.substring(1, this.displayText.length());
    }
  }
}

//-----------------------------------------------------------------------------------------------------------------//
public class NumberLineInputElement extends LineInputElement {
  public boolean sign;
  public boolean displaySign;
  public boolean numbersHidden;
  
  public NumberLineInputElement(AppController a, float x, float y, float w){
    super(a, x, y, w);
    this.sign = true;
    this.displaySign = true;
    this.numbersHidden = false;
  }
  
  public NumberLineInputElement(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    this.sign = true;
    this.displaySign = true;
    this.numbersHidden = false;
  }
  
  public void reset(){
    this.text = "";
    this.displayText = "";
    this.sign = true;
    this.displaySign = true;
    this.numbersHidden = false;
  }
  
  public float getNumber(){
    return (this.sign ? 1.0 : -1.0) * float(this.text);
  }
  
  public void show(){
    
    if(this.getNumber() == 0 || this.text.isEmpty()){
      this.displaySign = false;
    }else{
      this.displaySign = true;
    }
    
    stroke(0);
    strokeWeight(2);
    if(this.mouseHeld){
      fill(200);
    }else{
      fill(255);
    }
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y - this.dim.y/2, this.dim.x, this.dim.y);
    
    strokeWeight(1);
    fill(0);
    
    textAlign(LEFT);
    textFont(this.stdFont);
    text((this.numbersHidden ? "<" : "") + (this.displaySign ? (this.sign ? "+" : "-") : "") + this.displayText + (this.selected ? "_" : ""), this.pos.x + 10, this.pos.y + 6);
    
    if(this.selected){
      this.drawSelectionOutline();
    }
    
    //update text input
    if(this.backspaceStillPressed){
      this.backspaceCount++;
    }
    
    if(this.backspaceCount >= frameRate/2){
      this.backspaceTriggered();
    }
  }
  
  public void backspaceTriggered(){
    if(ALT_PRESSED){
      this.reset();
    }else if(this.text.length() > 0){
      this.text = this.text.substring(0, this.text.length() - 1);
      if(this.contentsHidden){
        this.displayText = "";
        for(int i = 0; i < this.text.length(); ++i){
          this.displayText += "*";
        }
      }else{
        this.displayText = this.text;
      }
      
      textFont(this.stdFont);
      this.numbersHidden = false;
      while(textWidth((this.numbersHidden ? "<" : "") + (this.displaySign ? (this.sign ? "+" : "-") : "") + this.displayText) > this.dim.x - 20){
        this.displayText = this.displayText.substring(1, this.displayText.length());
        this.numbersHidden = true;
      }
    }
  }
  
  public void keyTyped(char k){
    
    if(k >= '0' && k <= '9'){
      this.text += k;
    }else if(k == '.'){
      if(!this.text.contains(".")){
        if(this.text.length() == 0){
          this.text += "0";
        }
        this.text += ".";
      }
    }else if(k == '-'){
      this.sign = !this.sign;
    }
    
    if(this.text.length() > 1){
      while(this.text.charAt(0) == '0' && this.text.length() > 1){
        if(!(this.text.charAt(1) == '.')){
          this.text = this.text.substring(1, this.text.length());
        }else{
          break;
        }
      }
    }
    
    
    if(this.contentsHidden){
      this.displayText = "";
      for(int i = 0; i < this.text.length(); ++i){
        this.displayText += "*";
      }
    }else{
      this.displayText = this.text;
    }
    
    textFont(this.stdFont);
    this.numbersHidden = false;
    while(textWidth((this.numbersHidden ? "<" : "") + (this.displaySign ? (this.sign ? "+" : "-") : "") + this.displayText) > this.dim.x - 20){
      this.displayText = this.displayText.substring(1, this.displayText.length());
      this.numbersHidden = true;
    }
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class SelectionElement extends Element {
  public ArrayList<String> options;
  public int sel;
  public float defaultHeight;
  public boolean opened;
  public PFont stdFont;
  
  public SelectionElement(AppController a, float x, float y, String[] list){
    super(a, x, y, 100, 30);
    this.defaultHeight = 30;
    this.options = new ArrayList<String>();
    this.stdFont = fonts.get("PlexMono").get("Regular");
    this.sel = -1;
    textFont(this.stdFont);
    for(String s : list){
      this.options.add(s);
      if(textWidth(s) + 35 > this.dim.x - 20){
        this.dim.x = textWidth(s) + 35;
      }
    }
  }
  
  public SelectionElement(AppController a, float x, float y, float w){
    super(a, x, y, w, 30);
    this.defaultHeight = 30;
    this.options = new ArrayList<String>();
    this.stdFont = fonts.get("PlexMono").get("Regular");
    this.sel = -1;
  }
  
  public void select(){
    this.selected = true;
    this.layer = 1;
  }
  
  public void deselect(){
    this.selected = false;
    this.opened = false;
    this.layer = 0;
  }
  
  public void resize(float x, float y, float w){
    this.pos.set(x, y);
    this.dim.set(w, this.defaultHeight);
    textFont(this.stdFont);
    for(String s : this.options){
      if(textWidth(s) + 35 > this.dim.x - 20){
        this.dim.x = textWidth(s) + 35;
      }
    }
  }
  
  public void addOption(String s){
    textFont(this.stdFont);
    this.options.add(s);
    if((textWidth(s) + 35) > (this.dim.x - 20)){
      this.dim.x = textWidth(s) + 35;
    }
  }
  
  public void removeOption(String s){
    for(int i = 0; i < this.options.size(); ++i){
      if(this.options.get(i) == s){
        this.options.remove(i);
        break;
      }
    }
  }
  
  public boolean mousePressIsWithinBorder(){
    if(this.opened){
      if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.dim.x && mouseY >= this.pos.y - this.dim.y/2 && mouseY <= this.pos.y + this.options.size() * this.dim.y + this.dim.y/2){
        // User clicked element or an option
        return true;
      }
      return false;
    }else{
      if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.dim.x && mouseY >= this.pos.y - this.dim.y/2 && mouseY <= this.pos.y + this.dim.y/2){
        // User clicked element
        return true;
      }
      return false;
    }
  }
  
  public void mousePressed(){
    if(this.opened){
      if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.dim.x && mouseY >= this.pos.y - this.dim.y/2 && mouseY <= this.pos.y + this.options.size() * this.dim.y + this.dim.y/2){
        // User clicked element or an option
        this.clickEvent();
        this.selectOptionClickEvent();
        this.mouseHeld = true;
        this.select();
      }else{
        this.deselect();
        this.opened = false;
      }
    }else{
      if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.dim.x && mouseY >= this.pos.y - this.dim.y/2 && mouseY <= this.pos.y + this.dim.y/2){
        // User clicked element
        this.clickEvent();
        this.mouseHeld = true;
        this.select();
        this.opened = true;
      }
    }
  }
  
  private void selectOptionClickEvent(){
    for(int i = 0; i < this.options.size(); ++i){
      if(mouseY >= this.pos.y + this.dim.y * (i+1) - this.dim.y/2 && mouseY <= this.pos.y + this.dim.y * (i+1) + this.dim.y/2){
        // An option has been pressed!
        this.deselect();
        this.opened = false;
        this.sel = i;
        break;
      }
    }
  }
  
  public void show(){
    stroke(0);
    strokeWeight(2);
    if(this.mouseHeld){
      fill(200);
    }else{
      fill(255);
    }
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y - this.dim.y/2, this.dim.x, this.dim.y);
    
    strokeWeight(1);
    fill(0);
    
    textAlign(LEFT);
    textFont(this.stdFont);
    if(this.sel >= 0 && this.sel < this.options.size()){
      text(this.options.get(this.sel), this.pos.x + 10, this.pos.y + 6);
    }else{
      this.sel = -1;
    }
    
    if(this.opened){
      translate(0, 0, 2);
      
      this.sel = -1;
      
      stroke(0);
      strokeWeight(1);
      rectMode(CORNER);
      textAlign(LEFT);
      textFont(this.stdFont);
      for(int i = 0; i < this.options.size(); ++i){
        fill(255);
        rect(this.pos.x, this.pos.y + this.dim.y * (i+1) - this.dim.y/2, this.dim.x, this.dim.y);
        fill(0);
        text(this.options.get(i), this.pos.x + 10, this.pos.y + this.dim.y * (i+1) + 6);
      }
      
      translate(0, 0, -2);
    }else{
      stroke(0);
      strokeWeight(1);
      line(this.pos.x + this.dim.x - 10 - 5, this.pos.y + 3, this.pos.x + this.dim.x - 10 - 5 - 5, this.pos.y - 3);
      line(this.pos.x + this.dim.x - 10 - 5, this.pos.y + 3, this.pos.x + this.dim.x - 10, this.pos.y - 3);
    }
  }
  
  
}

//-----------------------------------------------------------------------------------------------------------------//

public class StepperCounterElement extends Element {
  
  public StepperCounterElement(AppController a, float x, float y, float w){
    super(a, x, y, w, 30);
  }
  
}

//-----------------------------------------------------------------------------------------------------------------//

public class DateSelectionElement extends Element {
  public float defaultHeight;
  public String parts;
  public ArrayList<Element> elements;
  public SelectionElement day;
  public SelectionElement month;
  public SelectionElement year;
  
  public DateSelectionElement(AppController a, float x, float y, String parts){
    super(a, x, y, 200, 30);
    this.defaultHeight = 30;
    this.parts = parts;
    this.elements = new ArrayList<Element>();
    this.day = new SelectionElement(this.appController, this.pos.x, this.pos.y, 50);
    for(int i = 1; i <= 31; ++i){
      this.day.addOption(str(i));
    }
    
    this.elements.add(this.day);
  }
  
  public void mousePressed(){
    for(Element e : this.elements){
      e.deselect();
      e.mousePressed();
    }
  }
  
  public void mouseReleased(){
    for(Element e : this.elements){
      e.mouseReleased();
    }
  }
  
  public void show(){
    for(Element e : this.elements){
      e.show();
    }
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class SpinWheelLoadingElement extends Element {
  public float counter;
  public float step;
  public int amountOfLines;
  public boolean shown;
  
  public SpinWheelLoadingElement(AppController a, float x, float y, float s){
    super(a, x, y, s, s);
    this.counter = 0;
    this.step = 0;
    this.amountOfLines = int(s);
    this.shown = true;
  }
  
  public SpinWheelLoadingElement(AppController a, float x, float y, float s, int n){
    super(a, x, y, s, s);
    this.counter = 0;
    this.step = 0;
    this.amountOfLines = n;
    this.shown = true;
  }
  
  public void resize(float x, float y, float s){
    this.pos.set(x, y);
    this.dim.set(s, s);
  }
  
  public void toggleHide(){
    this.shown = !this.shown;
  }
  
  public void hide(boolean f){
    this.shown = !f;
  }
  
  public void show(){
    if(this.shown){
      this.counter += 30/frameRate;
      if(this.counter >= 1){
        this.counter = 0;
        this.step += TWO_PI/float(this.amountOfLines);
        if(this.step >= TWO_PI){
          this.step = 0;
          this.counter += 30/frameRate;
        }
      }
      
      translate(this.pos.x, this.pos.y);
      
      rotate(this.step);
      
      strokeWeight(this.dim.x/5);
      
      for(int i = 0; i < this.amountOfLines; ++i){
        stroke(255 - map(float(i), 0, float(this.amountOfLines)-1, 0, 255));
        line(
          this.dim.x/3 * cos(i/float(this.amountOfLines) * TWO_PI),
          this.dim.x/3 * sin(i/float(this.amountOfLines) * TWO_PI),
          this.dim.x * cos(i/float(this.amountOfLines) * TWO_PI),
          this.dim.x * sin(i/float(this.amountOfLines) * TWO_PI)
        );
      }
      
      
      //stroke(200);
      //strokeWeight(2);
      //fill(200);
      //for(float i = 0; i <= 2*PI; i += (2/float(this.amountOfLines))*PI){
      //  line(
      //    this.dim.x/3*cos(i),
      //    this.dim.x/3*sin(i),
      //    this.dim.x*cos(i),
      //    this.dim.x*sin(i)
      //  );
      //}
      
      //stroke(0);
      //fill(0);
      //line(
      //  this.dim.x/3*cos(this.step * ((2/float(this.amountOfLines))*PI)),
      //  this.dim.x/3*sin(this.step * ((2/float(this.amountOfLines))*PI)),
      //  this.dim.x*cos(this.step * ((2/float(this.amountOfLines))*PI)),
      //  this.dim.x*sin(this.step * ((2/float(this.amountOfLines))*PI))
      //);
      
      //if(this.step > 0){
      //  stroke(100);
      //  fill(100);
      //  line(
      //    this.dim.x/3*cos((this.step-1) * ((2/float(this.amountOfLines))*PI)),
      //    this.dim.x/3*sin((this.step-1) * ((2/float(this.amountOfLines))*PI)),
      //    this.dim.x*cos((this.step-1) * ((2/float(this.amountOfLines))*PI)),
      //    this.dim.x*sin((this.step-1) * ((2/float(this.amountOfLines))*PI))
      //  );
      //}else{
      //  stroke(100);
      //  fill(100);
      //  line(
      //    this.dim.x/3*cos(this.amountOfLines * ((2/float(this.amountOfLines))*PI)),
      //    this.dim.x/3*sin(this.amountOfLines * ((2/float(this.amountOfLines))*PI)),
      //    this.dim.x*cos(this.amountOfLines * ((2/float(this.amountOfLines))*PI)),
      //    this.dim.x*sin(this.amountOfLines * ((2/float(this.amountOfLines))*PI))
      //  );
      //}
      
      rotate(-this.step);
      
      translate(-this.pos.x, -this.pos.y);
    }
  }
}
