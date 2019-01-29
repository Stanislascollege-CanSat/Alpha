import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Map; 
import static javax.swing.JOptionPane.*; 
import processing.serial.*; 

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




public boolean completedStartup;

// Frame components
public float w, h;
public int minWidth, minHeight;


// Fonts
public Map<String, HashMap<String, PFont>> fonts;

// Conditions
public boolean ALT_PRESSED;
public boolean CTRL_PRESSED;

// Application components
AppController appController;
StartupView startupView;

public void settings(){
  size(1000, 700, P3D);
  //fullScreen(P3D);
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
  appController = new AppController(this);
  
  //println(MAX_INT);
  
}

public void global_askUser_DataOutputFile(){
  selectFolder("Select a directory for the flight-data output", "global_responseFromUser_DataOutputFile");
}

public void global_responseFromUser_DataOutputFile(File selection){
  appController.responseFromUser_DataOutputFile(selection);
}

public void draw(){
  if(!completedStartup){
    //showMessageDialog(null, "This application is still being developed. Some functions might not work.", "Work in progress", WARNING_MESSAGE);
    completedStartup = true;
  }else{
  
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
}

public void mousePressed(){
  appController.mousePressed();
}

public void mouseReleased(){
  appController.mouseReleased();
}

public void keyPressed(){
  if(keyCode == ALT){
    ALT_PRESSED = true;
  }else if(keyCode == CONTROL){
    CTRL_PRESSED = true;
  }
  appController.keyPressed(key, keyCode);
}

public void keyTyped(){
  appController.keyTyped(key);
}

public void keyReleased(){
  ALT_PRESSED = false;
  CTRL_PRESSED = false;
  appController.keyReleased();
}
public class SpaceSegment {
  public PVector begin;
  public PVector pointer;
  public PVector temp;
  public float length;
  
  public SpaceSegment(PVector a, PVector b){
    this.begin = a;
    this.pointer = b;
    this.temp = new PVector(0, 0);
    this.length = this.pointer.mag();
  }
  
  public void show(){
    line(this.begin.x, this.begin.y, this.begin.x + this.pointer.x, this.begin.y + this.pointer.y);
  }
  
  public void follow(float x, float y){
    this.temp.set(x - this.begin.x, y - this.begin.y);
    this.pointer.rotate(this.temp.heading() - this.pointer.heading());
    this.begin.x = x - this.pointer.x;
    this.begin.y = y - this.pointer.y;
  }
}

public class SpaceImageSegment extends SpaceSegment {
  Parachute p;
  
  public SpaceImageSegment(PVector a){
    super(a, new PVector(2, 2));
    this.p = new Parachute(0, 0, 0, 100, 100, 50, 30, 60, 5, color(0), color(244, 161, 66));
  }
  
  public void show(){
    translate(this.begin.x, this.begin.y, 0);
    rotate(this.pointer.heading());
    
    stroke(0);
    strokeWeight(1);
    fill(255, 0, 0, 150);
    rectMode(CENTER);
    //rect(-15, 0, 30, 15);
    
    //textAlign(RIGHT);
    //textFont(fonts.get("SF").get("Heavy"));
    //text("Project Bèta", 0, 4);
    
    rotate(-PI/2);
    
    this.p.show();
    
    rotate(PI/2);
    
    rotate(-this.pointer.heading());
    translate(-this.begin.x, -this.begin.y);
  }
}

public class SpaceAnimation {
  public ArrayList<SpaceSegment> points;
  
  public SpaceAnimation(){
    this.points = new ArrayList<SpaceSegment>();
    this.points.add(new SpaceSegment(new PVector(0,0), new PVector(3,3)));
    for(int i = 0; i < 50; ++i){
      this.points.add(new SpaceSegment(new PVector(-i * 10, -i * 10), new PVector(3, 3)));
    }
    this.points.add(new SpaceImageSegment(new PVector(0, 0)));
  }
  
  public void show(){
    if(this.points.size() > 0){
      this.points.get(0).follow(mouseX, mouseY);
    }
    for(int i = 1; i < this.points.size(); ++i){
      this.points.get(i).follow(this.points.get(i-1).begin.x, this.points.get(i-1).begin.y);
    }
    
    stroke(0, 50);
    strokeWeight(2);
    for(SpaceSegment s : this.points){
      s.show();
    }
  }
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
  public void keyPressed(char k, int c);
  public void keyTyped(char k);
  public void keyReleased();
  
  public void startApp();
}

public class AppController implements AppController_Interface {
  public PApplet mainJavaEnvironment;
  
  private ArrayList<ViewController> viewControllers;
  
  private SerialController serialController;
  
  private StartupView startupView;
  private SetupView setupView;
  private MissionView missionView;
  
  public AppController(PApplet environment){
    this.mainJavaEnvironment = environment;
    
    this.viewControllers = new ArrayList<ViewController>();
    
    this.serialController = new SerialController(this);
    
    this.startupView = new StartupView(this, 0, 0, width, height);
    
    this.setupView = new SetupView(this, 0, 0, width, height);
    this.setupView.visible = false;
    
    this.missionView = new MissionView(this, 0, 0, width, height);
    this.missionView.visible = false;
    
    this.viewControllers.add(this.startupView);
    this.viewControllers.add(this.setupView);
    this.viewControllers.add(this.missionView);
  }
  
  public void openSerialPort(String portName, int baudRate){
    this.serialController.openConnection(portName, baudRate);
  }
  
  public void responseFromUser_DataOutputFile(File selection){
    if(selection != null){
      this.setupView.setDataOutputFile(selection);
    }
  }
  
  public void show(){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.show();
      }
    }
    //strokeWeight(1);
    //fill(0);
    //textAlign(LEFT);
    //textFont(fonts.get("SF").get("Regular"));
    //text(int(frameRate), 10, 20);
  }
  
  public void resize(){
    this.startupView.resize(0, 0, width, height);
    this.setupView.resize(0, 0, width, height);
    this.missionView.resize(0, 0, width, height);
  }
  
  
  
  public void addView(ViewController v){
    this.viewControllers.add(v);
  }
  
  public void mousePressed(){
    for(ViewController v : this.viewControllers){
      if(v.visible && v.userInteractionEnabled){
        v.mousePressed();
      }
    }
  }
  
  public void mouseReleased(){
    for(ViewController v : this.viewControllers){
      v.userInteractionEnabled = true;
      if(v.visible){
        v.mouseReleased();
      }
    }
  }
  
  public void keyPressed(char k, int c){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.keyPressed(k, c);
      }
    }
  }
  
  public void keyTyped(char k){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.keyTyped(k);
      }
    }
  }
  
  public void keyReleased(){
    for(ViewController v : this.viewControllers){
      if(v.visible){
        v.keyReleased();
      }
    }
  }
  
  
  
  
  public void startApp(){
    for(ViewController v : this.viewControllers){
      v.userInteractionEnabled = false;
    }
    this.startupView.visible = false;
    this.setupView.visible = true;
  }
  
  public void back(){
    for(ViewController v : this.viewControllers){
      v.userInteractionEnabled = false;
    }
    this.setupView.visible = false;
    this.startupView.visible = true;
  }
  
  public void selectSerialPort(){
    this.openSerialPort(this.setupView.getSelectedSerialPort(), this.setupView.getSelectedBaudRate());
  }
  
  public void sendDeployCommand(){
    if(this.serialController.opened()){
      this.serialController.write("open");
    }
  }
  
  public void sendCloseRingCommand(){
    if(this.serialController.opened()){
      this.serialController.write("closeRing");
    }
  }
  
  public void sendClosePinsCommand(){
    if(this.serialController.opened()){
      this.serialController.write("closePins");
    }
  }
  
  public void openMissionView(){
    for(ViewController v : this.viewControllers){
      v.userInteractionEnabled = false;
    }
    this.setupView.visible = false;
    this.missionView.visible = true;
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
  public boolean signed;
  public boolean displaySign;
  public boolean numbersHidden;
  
  public NumberLineInputElement(AppController a, float x, float y, float w){
    super(a, x, y, w);
    this.sign = true;
    this.signed = true;
    this.displaySign = true;
    this.numbersHidden = false;
  }
  
  public NumberLineInputElement(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    this.sign = true;
    this.signed = true;
    this.displaySign = true;
    this.numbersHidden = false;
  }
  
  public void setSigned(boolean s){
    this.signed = s;
  }
  
  public void reset(){
    this.text = "";
    this.displayText = "";
    this.sign = true;
    this.displaySign = true;
    this.numbersHidden = false;
  }
  
  public float getNumber(){
    return (this.sign ? 1.0f : -1.0f) * PApplet.parseFloat(this.text);
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
    text((this.numbersHidden ? "<" : "") + ((this.displaySign && this.signed) ? (this.sign ? "+" : "-") : "") + this.displayText + (this.selected ? "_" : ""), this.pos.x + 10, this.pos.y + 6);
    
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
    }else if(k == '-' && this.signed){
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
    while(textWidth((this.numbersHidden ? "<" : "") + ((this.displaySign && this.signed) ? (this.sign ? "+" : "-") : "") + this.displayText) > this.dim.x - 20){
      this.displayText = this.displayText.substring(1, this.displayText.length());
      this.numbersHidden = true;
    }
  }
}

//-----------------------------------------------------------------------------------------------------------------//
public class IntegerLineInputElement extends NumberLineInputElement {
  public IntegerLineInputElement(AppController a, float x, float y, float w){
    super(a, x, y, w);
  }
  
  public IntegerLineInputElement(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
  }
  
  public int getInteger(){
    return PApplet.parseInt((this.sign ? 1.0f : -1.0f) * PApplet.parseFloat(this.text));
  }
  
  public void keyTyped(char k){
    
    if(k >= '0' && k <= '9'){
      this.text += k;
    }else if(k == '-' && this.signed){
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
    while(textWidth((this.numbersHidden ? "<" : "") + ((this.displaySign && this.signed) ? (this.sign ? "+" : "-") : "") + this.displayText) > this.dim.x - 20){
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
  
  public String getValue(){
    if(this.sel >= 0 && this.sel < this.options.size()){
      return this.options.get(this.sel);
    }
    return "";
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
    this.amountOfLines = PApplet.parseInt(s);
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
        this.step += TWO_PI/PApplet.parseFloat(this.amountOfLines);
        if(this.step >= TWO_PI){
          this.step = 0;
          this.counter += 30/frameRate;
        }
      }
      
      translate(this.pos.x, this.pos.y);
      
      rotate(this.step);
      
      strokeWeight(this.dim.x/5);
      
      for(int i = 0; i < this.amountOfLines; ++i){
        stroke(255 - map(PApplet.parseFloat(i), 0, PApplet.parseFloat(this.amountOfLines)-1, 0, 255));
        line(
          this.dim.x/3 * cos(i/PApplet.parseFloat(this.amountOfLines) * TWO_PI),
          this.dim.x/3 * sin(i/PApplet.parseFloat(this.amountOfLines) * TWO_PI),
          this.dim.x * cos(i/PApplet.parseFloat(this.amountOfLines) * TWO_PI),
          this.dim.x * sin(i/PApplet.parseFloat(this.amountOfLines) * TWO_PI)
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
public class MissionView extends ViewController {
  public ButtonElement deployButton;
  public ButtonElement closeRingButton;
  public ButtonElement closePinsButton;
  
  public MissionView(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    
    this.deployButton = new ButtonElement(this.appController, this.dim.x/2 - 50, this.dim.y/2 - 100, 100, "Deploy"){
      public void clickEvent(){
        this.appController.sendDeployCommand();
      }
    };
    
    this.closeRingButton = new ButtonElement(this.appController, this.dim.x/2 - 50, this.dim.y/2, 100, "Close ring"){
      public void clickEvent(){
        this.appController.sendCloseRingCommand();
      }
    };
    
    this.closePinsButton = new ButtonElement(this.appController, this.dim.x/2 - 50, this.dim.y/2 + 50, 100, "Close pins"){
      public void clickEvent(){
        this.appController.sendClosePinsCommand();
      }
    };
    
    this.elements.add(this.deployButton);
    this.elements.add(this.closeRingButton);
    this.elements.add(this.closePinsButton);
  }
  
  public void viewResizeTriggered(){
    this.deployButton.resize(this.dim.x/2 - 50, this.dim.y/2 - 100, 100);
    this.closeRingButton.resize(this.dim.x/2 - 50, this.dim.y/2, 100);
    this.closePinsButton.resize(this.dim.x/2 - 50, this.dim.y/2 + 50, 100);
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
    textFont(fonts.get("SF").get("Thin 20"));
    text("Mission overview", this.dim.x/2, 50);
    
    for(Element e : this.elements){
      e.show();
    }
    
    //
    // End Content
    //
    
    
    translate(-this.pos.x, -this.pos.y);
  }
}
class Parachute{
  PVector pos;
  float Width;
  float Height;
  float CenterDepth;
  float Depth;
  float depthStep;
  float segWidth;
  float StringLength;
  int nSegments;
  
  int primaryColor;
  int secondaryColor;
  
  float alpha;
  float beta;
  
  PVector frontLeft;
  PVector frontRight;
  PVector backRight;
  PVector backLeft;
  
  Parachute(float x, float y, float z, float w, float h, float cd, float od, float sl, int nseg, int p, int s){
    pos = new PVector(x,y,z);
    Width = w;
    Height = h;
    Depth = cd;
    CenterDepth = cd;
    StringLength = sl;
    if(nseg > 0){
      nSegments = nseg;
    }else{
      nSegments = 1;
    }
    segWidth = Width/nSegments;
    depthStep = (cd-od)/((nSegments-1)/2);
    
    alpha = sin((0.5f*segWidth)/StringLength)*2;
    beta = sin((0.5f*Depth)/StringLength)*2;
    
    primaryColor = p;
    secondaryColor = s;
    
    frontLeft = new PVector(0,0,0);
    frontRight = new PVector(0,0,0);
    backRight = new PVector(0,0,0);
    backLeft = new PVector(0,0,0);
  }
  
  public void show(){
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    //rotateX(map(mouseY,0,height,0,-2*PI));
    //rotateY(map(mouseX,0,width,0,2*PI));
    stroke(0);
    strokeWeight(1);
    fill(primaryColor);
    
    Depth = CenterDepth;
    beta = sin((0.5f*Depth)/StringLength)*2;
    
    // 1
    line(0,0,0,-StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),StringLength*(sin(0.5f*beta)));
    line(0,0,0,StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),StringLength*(sin(0.5f*beta)));
    line(0,0,0,StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),-StringLength*(sin(0.5f*beta)));
    line(0,0,0,-StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),-StringLength*(sin(0.5f*beta)));
    beginShape();
    vertex(-StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),StringLength*(sin(0.5f*beta)));
    vertex(StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),StringLength*(sin(0.5f*beta)));
    vertex(StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),-StringLength*(sin(0.5f*beta)));
    vertex(-StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),-StringLength*(sin(0.5f*beta)));
    endShape(CLOSE);
    
    frontLeft.set(-StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),StringLength*(sin(0.5f*beta)));
    frontRight.set(StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),StringLength*(sin(0.5f*beta)));
    backRight.set(StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),-StringLength*(sin(0.5f*beta)));
    backLeft.set(-StringLength*sin(0.5f*alpha),-StringLength*cos(0.5f*alpha),-StringLength*(sin(0.5f*beta)));
    
    String colorSet = "primary";
    
    for(int i = 1; i <= (nSegments-1)/2; ++i){
      Depth -= depthStep;
      beta = sin((0.5f*Depth)/StringLength)*2;
      
      if(colorSet == "primary"){
        fill(secondaryColor);
        colorSet = "secondary";
      }else if(colorSet == "secondary"){
        fill(primaryColor);
        colorSet = "primary";
      }
      
      line(0,0,0,-StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),StringLength*(sin(0.5f*beta)));
      line(0,0,0,-StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),-StringLength*(sin(0.5f*beta)));
      beginShape();
      vertex(-StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),StringLength*(sin(0.5f*beta)));
      vertex(frontLeft.x,frontLeft.y,frontLeft.z);
      vertex(backLeft.x,backLeft.y,backLeft.z);
      vertex(-StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),-StringLength*(sin(0.5f*beta)));
      endShape(CLOSE);
      
      frontLeft.set(-StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),StringLength*(sin(0.5f*beta)));
      backLeft.set(-StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),-StringLength*(sin(0.5f*beta)));
      
      line(0,0,0,StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),StringLength*(sin(0.5f*beta)));
      line(0,0,0,StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),-StringLength*(sin(0.5f*beta)));
      beginShape();
      vertex(frontRight.x,frontRight.y,frontRight.z);
      vertex(StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),StringLength*(sin(0.5f*beta)));
      vertex(StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),-StringLength*(sin(0.5f*beta)));
      vertex(backRight.x,backRight.y,backRight.z);
      endShape(CLOSE);
      
      frontRight.set(StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),StringLength*(sin(0.5f*beta)));
      backRight.set(StringLength*sin((i+0.5f)*alpha),-StringLength*cos((i+0.5f)*alpha),-StringLength*(sin(0.5f*beta)));
    }
    
    
    
    
    
    //// 1
    //line(0,0,0,-30,-147,20);
    //line(0,0,0,30,-147,20);
    //line(0,0,0,30,-147,-20);
    //line(0,0,0,-30,-147,-20);
    //beginShape();
    //vertex(-30,-147,20);
    //vertex(30,-147,20);
    //vertex(30,-147,-20);
    //vertex(-30,-147,-20);
    //endShape(CLOSE);
    
    ////2
    //line(0,0,0,-84,-124,20);
    //line(0,0,0,-84,-124,-20);
    //beginShape();
    //vertex(-84,-124,20);
    //vertex(-30,-147,20);
    //vertex(-30,-147,-20);
    //vertex(-84,-124,-20);
    //endShape(CLOSE);
    
    ////2
    //line(0,0,0,84,-124,20);
    //line(0,0,0,84,-124,-20);
    //beginShape();
    //vertex(30,-147,20);
    //vertex(84,-124,20);
    //vertex(84,-124,-20);
    //vertex(30,-147,-20);
    //endShape(CLOSE);
    
    popMatrix();
  }
}


public interface SerialController_Interface {
  
}

public class SerialController implements SerialController_Interface {
  public AppController appController;
  private Serial com;
  private boolean serialSetupDone;
  private int[] possibleBaudRates;
  
  public SerialController(AppController a){
    this.appController = a;
    this.possibleBaudRates = new int[1];
    this.possibleBaudRates[0] = 9600;
  }
  
  public String[] getPortsList(){
    return Serial.list();
  }
  
  public void openConnection(String port, int baudrate){
    if(this.serialSetupDone){
      this.stopConnection();
    }
    this.com = null;
    this.com = new Serial(this.appController.mainJavaEnvironment, port, baudrate);
    this.serialSetupDone = true;
  }
  
  public void stopConnection(){
    if(this.serialSetupDone){
      this.com.stop();
      this.serialSetupDone = false;
    }
  }
  
  public void write(String msg){
    if(this.serialSetupDone){
      this.com.write(msg);
    }
  }
  
  public boolean opened(){
    return this.serialSetupDone;
  }
}
// SetupView.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public class SetupView extends ViewController {
  public ArrayList<Integer> baudRates;
  public File dataOutputFile;
  
  public TextElement Label_FlightName;
  public LineInputElement Input_FlightName;
  
  public TextElement Label_serialPort;
  public SelectionElement Select_serialPort;
  
  public TextElement Label_baudRate;
  public IntegerLineInputElement Select_baudRate;
  
  public TextElement Label_DataOutputFile;
  public TextElement Display_DataOutputFile;
  public UtilityButtonElement Button_DataOutputFile;
  
  
  public TextButtonElement Button_back;
  public ButtonElement Button_continue;
  
  
  
  
  public SetupView(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    
        
    this.Label_FlightName = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4, 150, "Flight name:", RIGHT);
    
    this.Input_FlightName = new LineInputElement(this.appController, this.dim.x/2 + 10, this.dim.y/4, 200);
    
    
    
    this.Label_serialPort = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4 + 50, 140, "Serial port:", RIGHT);
    
    this.Select_serialPort = new SelectionElement(this.appController, this.dim.x/2 + 10, this.dim.y/4 + 50, 200);
    for(String s : Serial.list()){
      this.Select_serialPort.addOption(s);
    }
    
    
    this.Label_baudRate = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4 + 100, 140, "Baud rate:", RIGHT);
    
    this.Select_baudRate = new IntegerLineInputElement(this.appController, this.dim.x/2 + 10, this.dim.y/4 + 100, 200);
    this.Select_baudRate.setSigned(false);
    //for(int i : this.baudRates){
    //  this.Select_baudRate.addOption(str(i));
    //}
    
    
    this.Label_DataOutputFile = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4 + 150, 140, "Data output file:", RIGHT);
    
    this.Display_DataOutputFile = new TextElement(this.appController, this.dim.x/2 + 30, this.dim.y/4 + 150, 500, "", LEFT);
    
    this.Button_DataOutputFile = new UtilityButtonElement(this.appController, this.dim.x/2 + 10, this.dim.y/4 + 150){
      public void clickEvent(){
        global_askUser_DataOutputFile();
      }
    };
    
    
    
    this.Button_back = new TextButtonElement(this.appController, this.dim.x/2 - 70, this.dim.y - 40, 60, "Back"){
      public void clickEvent(){
        this.appController.back();
      }
    };
    
    this.Button_continue = new ButtonElement(this.appController, this.dim.x/2 + 10, this.dim.y - 40, 100, "Continue"){
      public void clickEvent(){
        this.appController.selectSerialPort();
        this.appController.openMissionView();
      }
    };

    //this.elements.add(this.Label_FlightName);
    //this.elements.add(this.Input_FlightName);
    this.elements.add(this.Label_serialPort);
    this.elements.add(this.Select_serialPort);
    this.elements.add(this.Label_baudRate);
    this.elements.add(this.Select_baudRate);
    //this.elements.add(this.Label_DataOutputFile);
    //this.elements.add(this.Display_DataOutputFile);
    //this.elements.add(this.Button_DataOutputFile);
    
    this.elements.add(this.Button_back);
    this.elements.add(this.Button_continue);
    
  }
  
  public void viewResizeTriggered(){
    this.Label_FlightName.resize(this.dim.x/2 - 150, this.dim.y/4, 150);
    this.Input_FlightName.resize(this.dim.x/2 + 10, this.dim.y/4, 200);
    this.Label_serialPort.resize(this.dim.x/2 - 150, this.dim.y/4 + 50, 140);
    this.Select_serialPort.resize(this.dim.x/2 + 10, this.dim.y/4 + 50, 200);
    this.Label_baudRate.resize(this.dim.x/2 - 150, this.dim.y/4 + 100, 140);
    this.Select_baudRate.resize(this.dim.x/2 + 10, this.dim.y/4 + 100, 200);
    this.Label_DataOutputFile.resize(this.dim.x/2 - 150, this.dim.y/4 + 150, 140);
    this.Display_DataOutputFile.resize(this.dim.x/2 + 30, this.dim.y/4 + 150, 500);
    this.Button_DataOutputFile.resize(this.dim.x/2 + 10, this.dim.y/4 + 150);
    this.Button_back.resize(this.dim.x/2 - 70, this.dim.y - 40, 60);
    this.Button_continue.resize(this.dim.x/2 + 10, this.dim.y - 40, 100);
  }
  
  public void setDataOutputFile(File selection){
    this.dataOutputFile = selection;
    String[] terms = selection.getAbsolutePath().split("/");
    this.Display_DataOutputFile.setText(terms[terms.length - 1]);
    terms = null;
  }
  
  public String getSelectedSerialPort(){
    return this.Select_serialPort.getValue();
  }
  
  public int getSelectedBaudRate(){
    return this.Select_baudRate.getInteger();
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
    textFont(fonts.get("SF").get("Thin 20"));
    text("Session setup", this.dim.x/2, 50);
    
    for(Element e : this.elements){
      e.show();
    }
    
    //
    // End Content
    //
    
    
    translate(-this.pos.x, -this.pos.y);
  }
}
// StartupView.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public class StartupView extends ViewController {
  public SpaceAnimation spaceAnimation;
  public TextButtonElement button;
  
  public StartupView(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    this.spaceAnimation = new SpaceAnimation();
    this.button = new TextButtonElement(this.appController, this.dim.x/2 - 30, this.dim.y/2 + 100, 60, "Start"){
      public void clickEvent(){
        this.appController.startApp();
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
    //fill(255);
    noFill();
    
    rectMode(CORNER);
    
    rect(this.pos.x, this.pos.y, this.dim.x, this.dim.y);
    
    this.spaceAnimation.show();
    
    translate(this.pos.x, this.pos.y);
    
    //
    // Begin Content
    //
    
    translate(0, 0, 100);
    
    fill(0);
    
    textAlign(CENTER);
    textFont(fonts.get("SF").get("Black 20"));
    text("Alpha", this.dim.x/2, this.dim.y/2 - this.dim.y/10);
    
    textFont(fonts.get("Lora").get("Regular"));
    text("CanSat Mission Control Software by Rens Dur\n(Project Bèta)", this.dim.x/2, this.dim.y/2 - this.dim.y/10 + 30);
    
    translate(0, 0, -100);
    
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
  public void keyPressed(char k, int c);
  public void keyTyped(char k);
  public void keyReleased();
}

public class ViewController implements ViewController_Interface {
  public AppController appController;
  public PVector pos;
  public PVector dim;
  public boolean visible;
  public boolean userInteractionEnabled;
  public ArrayList<Element> elements;
  public ArrayList<Integer> elementFilter;
  
  public ViewController(AppController a, float x, float y, float w, float h){
    this.appController = a;
    this.pos = new PVector(x, y);
    this.dim = new PVector(w, h);
    this.visible = true;
    this.userInteractionEnabled = true;
    this.elements = new ArrayList<Element>();
    this.elementFilter = new ArrayList<Integer>();
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
    this.elementFilter.clear();
    for(int i = 0; i < this.elements.size(); ++i){
      if(this.elements.get(i).mousePressIsWithinBorder()){
        this.elementFilter.add(i);
      }
    }
    int biggest = -1;
    int index = -1;
    for(int i : this.elementFilter){
      if(this.elements.get(i).layer > biggest){
        biggest = this.elements.get(i).layer;
        index = i;
      }
    }
    if(index > -1){
      this.elements.get(index).mousePressed();
    }
    for(int i = 0; i < this.elements.size(); ++i){
      if(i != index){
        this.elements.get(i).deselect();
      }
    }
  }
  
  public void mouseReleased(){
    for(Element e : this.elements){
      e.mouseReleased();
    }
  }
  
  public void keyPressed(char k, int c){
    for(Element e : this.elements){
      if(e.selected){
        e.keyPressed(k, c);
      }
    }
  }
  
  public void keyTyped(char k){
    for(Element e : this.elements){
      if(e.selected){
        e.keyTyped(k);
      }
    }
  }
  
  public void keyReleased(){
    for(Element e : this.elements){
      if(e.selected){
        e.keyReleased();
      }
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
