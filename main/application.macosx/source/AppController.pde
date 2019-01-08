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
