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
