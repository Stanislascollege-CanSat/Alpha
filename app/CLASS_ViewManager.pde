import java.util.Map;
import java.lang.Runnable;

public class View {
  private String name;
  private PVector lookPos;
  private PVector upPos;
  private PVector straightRotation;
  private Runnable showExecutable;

  public View(String n, float lx, float ly, float lz, float ux, float uy, float uz, float rx, float ry, float rz, Runnable exe){
    this.name = n;
    this.lookPos = new PVector(lx,ly,lz);
    this.upPos = new PVector(ux,uy,uz);
    this.straightRotation = new PVector(rx,ry,rz);
    this.showExecutable = exe;
  }

  public PVector getLookPos(){
    return this.lookPos;
  }

  public PVector getUpPos(){
    return this.upPos;
  }

  public void setShowExecutable(Runnable exe){
    this.showExecutable = exe;
  }

  public void show(){
    translate(this.lookPos.x, this.lookPos.y, this.lookPos.z);
    rotateX(this.straightRotation.x);
    rotateY(this.straightRotation.y);
    rotateZ(this.straightRotation.z);

    this.showExecutable.run();

    rotateX(-this.straightRotation.x);
    rotateY(-this.straightRotation.y);
    rotateZ(-this.straightRotation.z);
    translate(-this.lookPos.x, -this.lookPos.y, -this.lookPos.z);

  }
}

public class ViewManager {
  // ===== CLASS PROPERTIES ===== //
  private Map<String, View> viewList;
  private ArrayList<PVector[]> transitionSteps;
  private View[] transitionFromTo;
  private String[] transitionStringFromTo;
  private boolean isTransitioning;
  private String currentView;
  private PVector currentCameraLookPos;
  private PVector currentCameraUpPos;
  private int amountOfTransitionSteps;
  private boolean executeRunnableAfterTransition;
  private Runnable executableAfterTransition;


  // ===== CLASS INIT METHOD ===== //
  public ViewManager(String name, View v) {
    this.viewList = new HashMap<String, View>();
    this.transitionSteps = new ArrayList<PVector[]>();
    this.transitionFromTo = new View[2];
    this.transitionStringFromTo = new String[2];
    this.isTransitioning = false;
    this.currentView = name;
    this.viewList.put(name, v);
    this.currentCameraLookPos = new PVector(0,0,0);
    this.currentCameraUpPos = new PVector(0,1,0);
    this.amountOfTransitionSteps = 50;
    this.executeRunnableAfterTransition = false;
  }

  // ===== PRIVATE METHODS ===== //
  private void setupTransition(String destination){
    this.transitionFromTo[0] = this.viewList.get(this.currentView);
    this.transitionFromTo[1] = this.viewList.get(destination);
    this.transitionStringFromTo[0] = this.currentView;
    this.transitionStringFromTo[1] = destination;

    PVector deltaLookPos = this.transitionFromTo[1].getLookPos().copy();
    deltaLookPos.sub(this.transitionFromTo[0].getLookPos());
    PVector deltaUpPos = this.transitionFromTo[1].getUpPos().copy();
    deltaUpPos.sub(this.transitionFromTo[0].getUpPos());


    deltaLookPos.div(this.amountOfTransitionSteps);
    deltaUpPos.div(this.amountOfTransitionSteps);

    PVector[] step = new PVector[2];

    step[0] = this.transitionFromTo[0].getLookPos().copy();
    step[1] = this.transitionFromTo[0].getUpPos().copy();

    this.transitionSteps.clear();


    for(int i = 0; i < this.amountOfTransitionSteps-1; ++i){
      PVector[] temp = new PVector[2];
      temp[0] = step[0].copy();
      temp[1] = step[1].copy();
      this.transitionSteps.add(temp);
      step[0].add(deltaLookPos);
      step[1].add(deltaUpPos);

    }

    this.currentView = destination;

    this.isTransitioning = true;

  }

  // ===== PUBLIC METHODS ===== //
  public void show(){
    if(!this.isTransitioning){
      this.currentCameraLookPos = this.viewList.get(this.currentView).getLookPos();
      this.currentCameraUpPos = this.viewList.get(this.currentView).getUpPos();
      camera(0,0,0, this.currentCameraLookPos.x,this.currentCameraLookPos.y,this.currentCameraLookPos.z, this.currentCameraUpPos.x,
                          this.currentCameraUpPos.y,this.currentCameraUpPos.z);
      this.viewList.get(this.currentView).show();
    }else if(this.isTransitioning && this.transitionSteps.size() > 0){
      PVector transLookPos = this.transitionSteps.get(0)[0];
      PVector transLookUp = this.transitionSteps.get(0)[1];
      this.transitionSteps.remove(0);
      this.currentCameraLookPos = transLookPos.copy();
      this.currentCameraUpPos = transLookUp.copy();
      camera(0,0,0, this.currentCameraLookPos.x,this.currentCameraLookPos.y,this.currentCameraLookPos.z, this.currentCameraUpPos.x,
                          this.currentCameraUpPos.y,this.currentCameraUpPos.z);
      this.viewList.get(this.transitionStringFromTo[0]).show();
      this.viewList.get(this.transitionStringFromTo[1]).show();
    }else if(this.isTransitioning && !(this.transitionSteps.size() > 0)){
      this.isTransitioning = false;
      if(this.executeRunnableAfterTransition){
        this.executableAfterTransition.run();
        this.executeRunnableAfterTransition = false;
      }
    }
  }

  public void addView(String name, View v){
    this.viewList.put(name, v);
  }

  public void executeFunctionAfterTransition(Runnable runAfterTransition){
    this.executableAfterTransition = runAfterTransition;
    this.executeRunnableAfterTransition = true;
  }

  public void scrollToView(String name){
    if(!(name == this.currentView)){
      if(this.viewList.containsKey(name)){
        this.setupTransition(name);
      }
    }
  }

  public String getCurrentViewName(){
    return this.currentView;
  }


}
