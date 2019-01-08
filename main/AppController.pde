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
  private ArrayList<ViewController> viewControllers;
  
  private StartupView startupView;
  private SetupView setupView;
  
  public AppController(){
    this.viewControllers = new ArrayList<ViewController>();
    
    this.startupView = new StartupView(this, 0, 0, width, height);
    this.setupView = new SetupView(this, 0, 0, width, height);
    this.setupView.visible = false;
    
    this.viewControllers.add(this.startupView);
    this.viewControllers.add(this.setupView);
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
    strokeWeight(1);
    fill(0);
    textAlign(LEFT);
    textFont(fonts.get("SF").get("Regular"));
    text(int(frameRate), 10, 20);
  }
  
  public void resize(){
    this.startupView.resize(0, 0, width, height);
    this.setupView.resize(0, 0, width, height);
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
}
