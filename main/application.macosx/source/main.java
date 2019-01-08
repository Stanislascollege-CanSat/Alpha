import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Map; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

// main.pde
// Processing 3.4
// Rens Dur (Project Bèta)



// Frame components
float w, h;
int minWidth, minHeight;


// Fonts
public Map<String, HashMap<String, PFont>> fonts;



// Application components
AppController appController;
StartupView startupView;

public void settings(){
  size(1000, 700, P3D);
  pixelDensity(displayDensity());
  smooth(8);
}

public void setup(){
  surface.setTitle("Mission Control Software");
  surface.setResizable(true);
  background(200);
  
  // Frame components
  w = width;
  h = height;
  minWidth = 600;
  minHeight = 500;
  
  // Load fonts
  fonts = new HashMap<String, HashMap<String, PFont>>();
  fonts.put("Lora", new HashMap<String, PFont>());
  fonts.get("Lora").put("Regular",      createFont("data/fonts/Lora/Regular.ttf",      15));
  fonts.get("Lora").put("Bold",         createFont("data/fonts/Lora/Bold.ttf",         15));
  fonts.get("Lora").put("Italic",       createFont("data/fonts/Lora/Italic.ttf",       15));
  
  fonts.put("OverpassMono", new HashMap<String, PFont>());
  fonts.get("OverpassMono").put("Regular",      createFont("data/fonts/OverpassMono/Regular.ttf",      15));
  fonts.get("OverpassMono").put("Bold",         createFont("data/fonts/OverpassMono/Bold.ttf",         15));
  fonts.get("OverpassMono").put("Light",       createFont("data/fonts/OverpassMono/Light.ttf",         15));
  
  fonts.put("PlexMono", new HashMap<String, PFont>());
  fonts.get("PlexMono").put("Regular",      createFont("data/fonts/PlexMono/Regular.ttf",      15));
  fonts.get("PlexMono").put("Bold",         createFont("data/fonts/PlexMono/Bold.ttf",         15));
  fonts.get("PlexMono").put("Italic",       createFont("data/fonts/PlexMono/Italic.ttf",       15));
  fonts.get("PlexMono").put("Light",       createFont("data/fonts/PlexMono/Light.ttf",         15));
  
  fonts.put("SF", new HashMap<String, PFont>());
  fonts.get("SF").put("Black",      createFont("data/fonts/SF/Black.otf",      8));
  fonts.get("SF").put("Bold",         createFont("data/fonts/SF/Bold.otf",     8));
  fonts.get("SF").put("Heavy",       createFont("data/fonts/SF/Heavy.otf",     8));
  fonts.get("SF").put("Light",       createFont("data/fonts/SF/Light.otf",     8));
  fonts.get("SF").put("Medium",       createFont("data/fonts/SF/Medium.otf",   8));
  fonts.get("SF").put("Regular",       createFont("data/fonts/SF/Regular.otf", 8));
  fonts.get("SF").put("Thin",       createFont("data/fonts/SF/Thin.otf",       8));
  
  fonts.get("SF").put("Black 15",      createFont("data/fonts/SF/Black.otf",      15));
  fonts.get("SF").put("Bold 15",         createFont("data/fonts/SF/Bold.otf",     15));
  fonts.get("SF").put("Heavy 15",       createFont("data/fonts/SF/Heavy.otf",     15));
  fonts.get("SF").put("Light 15",       createFont("data/fonts/SF/Light.otf",     15));
  fonts.get("SF").put("Medium 15",       createFont("data/fonts/SF/Medium.otf",   15));
  fonts.get("SF").put("Regular 15",       createFont("data/fonts/SF/Regular.otf", 15));
  fonts.get("SF").put("Thin 15",       createFont("data/fonts/SF/Thin.otf",       15));
  
  fonts.get("SF").put("Black 20",      createFont("data/fonts/SF/Black.otf",      20));
  fonts.get("SF").put("Bold 20",         createFont("data/fonts/SF/Bold.otf",     20));
  fonts.get("SF").put("Heavy 20",       createFont("data/fonts/SF/Heavy.otf",     20));
  fonts.get("SF").put("Light 20",       createFont("data/fonts/SF/Light.otf",     20));
  fonts.get("SF").put("Medium 20",       createFont("data/fonts/SF/Medium.otf",   20));
  fonts.get("SF").put("Regular 20",       createFont("data/fonts/SF/Regular.otf", 20));
  fonts.get("SF").put("Thin 20",       createFont("data/fonts/SF/Thin.otf",       20));
  
  
  // Application components
  appController = new AppController();
  
}

public void draw(){
  if(w != width || h != height){
    if(width < minWidth){
      surface.setSize(minWidth, height);
    }
    if(height < minHeight){
      surface.setSize(width, minHeight);
    }
    
    // window resized
    appController.resize();
  }
  
  background(255);
  
  appController.show();
  
  w = width;
  h = height;
}

public void mousePressed(){
  appController.mousePressed();
}

public void mouseReleased(){
  appController.mouseReleased();
}
// AppController.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public interface AppController_Interface {
  public void show();
  
  public void addView(ViewController v);
  public void resize();
  public void mousePressed();
  public void mouseReleased();
}

public class AppController implements AppController_Interface {
  private ArrayList<ViewController> viewControllers;
  
  private StartupView startupView;
  
  public AppController(){
    this.viewControllers = new ArrayList<ViewController>();
    
    this.startupView = new StartupView(this, 0, 0, width, height);
    
    this.viewControllers.add(this.startupView);
  }
  
  public void show(){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.show();
      }
    }
  }
  
  public void resize(){
    this.startupView.resize(0, 0, width, height);
  }
  
  
  
  public void addView(ViewController v){
    this.viewControllers.add(v);
  }
  
  public void mousePressed(){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.mousePressed();
      }
    }
  }
  
  public void mouseReleased(){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.mouseReleased();
      }
    }
  }
  
  public void sayHi(){
    println("clicked");
  }
}
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
// StartupView.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public class StartupView extends ViewController {
  public TextButtonElement button;
  
  public StartupView(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    this.button = new TextButtonElement(this.appController, this.dim.x/2-50, this.dim.y/2 + 100, 100, "Start"){
      public void clickEvent(){
        this.appController.sayHi();
      }
    };
    this.elements.add(this.button);
  }
  
  public void viewResizeTriggered(){
    this.button.resize(this.dim.x/2-50, this.dim.y/2 + 100, 100);
  }
  
  public void show(){
    stroke(255);
    strokeWeight(1);
    fill(255);
    
    rectMode(CORNER);
    
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    
    translate(this.pos.x, this.pos.y);
    
    //
    // Begin Content
    //
    
    fill(0);
    
    textAlign(CENTER);
    textFont(fonts.get("SF").get("Black 20"));
    text("Alpha", this.dim.x/2, this.dim.y/2 - this.dim.y/10);
    
    textFont(fonts.get("Lora").get("Regular"));
    text("CanSat Mission Control Software by Rens Dur", this.dim.x/2, this.dim.y/2 - this.dim.y/10 + 30);
    
    for(Element e : this.elements){
      e.show();
    }
    
    //
    // End Content
    //
    
    
    translate(-this.pos.x, -this.pos.y);
  }
}
// ViewController.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public interface ViewController_Interface {
  public void toggleVisibility();
  public void resize(float x, float y, float w, float h);
  public void viewResizeTriggered();
  public void show();
  public void mousePressed();
  public void mouseReleased();
}

public class ViewController implements ViewController_Interface {
  public AppController appController;
  public PVector pos;
  public PVector dim;
  public boolean visible;
  public ArrayList<Element> elements;
  
  public ViewController(AppController a, float x, float y, float w, float h){
    this.appController = a;
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);
    this.visible = true;
    this.elements = new ArrayList<Element>();
  }
  
  public void viewResizeTriggered(){}
  
  public void resize(float x, float y, float w, float h){
    this.pos.set(x, y);
    this.dim.set(w, h);
    this.viewResizeTriggered();
  }
  
  public void toggleVisibility(){
    this.visible = !this.visible;
  }
  
  public void show(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    
    rectMode(CORNER);
    
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
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
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
