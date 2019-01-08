// Elements.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public interface Element_Interface {
  public void select();
  public void deselect();
  public void resize(float x, float y, float w, float h);
  public void show();
  public void drawSelectionOutline();
  public void mousePressed();
  public void mouseReleased();
  
  public void clickEvent();
}

public class Element implements Element_Interface {
  public AppController appController;
  public PVector pos;
  public PVector dim;
  public boolean selected;
  public boolean mouseHeld;
  
  public Element(AppController a, float x, float y, float w, float h){
    this.appController = a;
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);
    this.selected = false;
    this.mouseHeld = false;
  }
  
  public void select(){
    this.selected = true;
  }
  
  public void deselect(){
    this.selected = false;
  }
  
  public void drawSelectionOutline(){
    stroke(0, 0, 255);
    strokeWeight(1);
    noFill();
    rectMode(CORNER);
    rect(this.pos.x-2, this.pos.y-2, this.dim.x+4, this.dim.y+4);
  }
  
  public void resize(float x, float y, float w, float h){
    this.pos.set(x, y);
    this.dim.set(w, h);
  }
  
  public void mousePressed(){
    if(mouseX >= this.pos.x && mouseX <= this.pos.x + this.dim.x && mouseY >= this.pos.y && mouseY <= this.pos.y + this.dim.y){
      // User clicked element
      this.clickEvent();
      this.mouseHeld = true;
      this.select();
    }
  }
  
  public void mouseReleased(){
    this.mouseHeld = false;
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
  
  public void show(){
    stroke(56, 132, 255);
    strokeWeight(2);
    if(this.mouseHeld){
      fill(200);
    }else{
      fill(255);
    }
    rectMode(CORNER);
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    
    strokeWeight(1);
    fill(0);
    
    textAlign(CENTER);
    textFont(fonts.get("SF").get("Regular"));
    text(this.text, this.pos.x + this.dim.x/2, this.pos.y + this.dim.y/2 + 6);
    
    if(this.selected){
      this.drawSelectionOutline();
    }
  }
}

//-----------------------------------------------------------------------------------------------------------------//

public class TextButtonElement extends ButtonElement {
  public TextButtonElement(AppController a, float x, float y, float w, String t){
    super(a, x, y, w, 20, t);
  }
  
  public void show(){
    if(this.mouseHeld){
      stroke(0);
      fill(0);
    }else{
      stroke(56, 132, 255);
      fill(56, 132, 255);
    }
    
    textAlign(CENTER);
    textFont(fonts.get("SF").get("Regular"));
    text(this.text, this.pos.x + this.dim.x/2, this.pos.y + this.dim.y/2 + 6);
    
    //if(this.selected){
    //  stroke(0, 100);
    //  strokeWeight(1);
    //  line(this.pos.x + this.dim.x/2 - textWidth(this.text)/2, this.pos.y + this.dim.y/2 + 8, this.pos.x + this.dim.x/2 + textWidth(this.text)/2, this.pos.y + this.dim.y/2 + 8);
    //}
  }
}
