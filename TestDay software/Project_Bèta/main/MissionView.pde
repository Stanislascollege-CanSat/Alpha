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
