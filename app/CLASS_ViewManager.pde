

public class ViewManager {
  // PROPERTIES
  private PVector pos;
  private float viewDepth;

  private View dashboardView;
  private ArrayList<View> viewList;
  private int currentView;
  private int previousView;
  private float transitionOffset;
  private float transitionSpeed;
  private boolean transitionDirection;

  private float scrollIndexYOffset;
  private float scrollIndexBallSize;
  private float scrollIndexBallContainer;
  private color scrollIndexInactiveColor;
  private color scrollIndexActiveColor;



  public ViewManager(float x, float y, float z, View db, float vd){
    this.pos = new PVector(x,y,z);
    this.viewDepth = vd;

    this.dashboardView = db;
    this.viewList = new ArrayList<View>();
    this.currentView = -1;
    this.previousView = -1;
    this.transitionOffset = 0;
    this.transitionSpeed = 8;

    this.scrollIndexYOffset = 15;
    this.scrollIndexBallSize = 6;
    this.scrollIndexBallContainer = 8;
    this.scrollIndexInactiveColor = color(150);
    this.scrollIndexActiveColor = color(0);
  }

  // PRIVATE METHODS
  private void scrollToView(int index){
    if(!(index == this.currentView)){
      if(index >= 0 && index < this.viewList.size()){
        // >> INDEX IS WITHIN VIEWRANGE
        this.previousView = this.currentView;
        this.currentView = index;
      }else if(index >= this.viewList.size()){
        this.scrollToView(0);
      }else if(index < 0){
        this.scrollToView(this.viewList.size()-1);
      }
    }
  }

  private void endTransition(){
    this.transitionOffset = 0;
    this.previousView = -1;
  }


  // PUBLIC METHODS
  public void scrollToRightView(){
    this.transitionDirection = true;
    this.scrollToView(this.currentView + 1);
  }

  public void scrollToLeftView(){
    this.transitionDirection = false;
    this.scrollToView(this.currentView - 1);
  }

  public void show(){
    translate(this.pos.x, this.pos.y, this.pos.z);
    //>> show the current view index
    float w = this.viewList.size() * this.scrollIndexBallContainer;
    float h = this.scrollIndexBallContainer;
    float leftX = width/2 - w/2 + this.scrollIndexBallContainer/2;
    for(int i = 0; i < this.viewList.size(); ++i){
      noStroke();
      fill(this.scrollIndexInactiveColor);
      ellipse(leftX + i*this.scrollIndexBallContainer, this.scrollIndexYOffset, this.scrollIndexBallSize, this.scrollIndexBallSize);
    }
    if(this.currentView >= 0){
      noStroke();
      fill(this.scrollIndexActiveColor);
      ellipse(leftX + this.currentView*this.scrollIndexBallContainer, this.scrollIndexYOffset, this.scrollIndexBallSize, this.scrollIndexBallSize);
    }

    translate(0, 0, -this.viewDepth);



    //>> show the current view and, when transitioning, the transition
    if(this.previousView < 0 && this.currentView >= 0){
      // IS NOT TRANSITIONING
      this.viewList.get(this.currentView).show();
    }else if(this.previousView >= 0 && this.currentView >= 0){
      // IS TRANSITIONING
      translate(-map(this.transitionOffset, 0, 255, 0, width), 0, 0);
      this.viewList.get(this.previousView).show();
      translate(map(this.transitionOffset, 0, 255, 0, width), 0, 0);
      if(this.transitionDirection){
        translate(map(255 - this.transitionOffset, 0, 255, 0, width), 0, 0);
        this.viewList.get(this.currentView).show();
        translate(-map(255 - this.transitionOffset, 0, 255, 0, width), 0, 0);
        this.transitionOffset += this.transitionSpeed;
      }else{
        translate(map(-255 - this.transitionOffset, -255, 0, -width, 0), 0, 0);
        this.viewList.get(this.currentView).show();
        translate(-map(-255 - this.transitionOffset, -255, 0, -width, 0), 0, 0);
        this.transitionOffset -= this.transitionSpeed;
      }
      if(this.transitionOffset >= 255 || this.transitionOffset <= -255){
        this.endTransition();
      }
    }

    translate(0, 0, this.viewDepth);

    this.dashboardView.show();

    translate(-this.pos.x, -this.pos.y, -this.pos.z);
  }

  public void setStartingView(int index){
    if(index >= 0 && index < this.viewList.size()){
      this.currentView = index;
    }
  }

  public void addView(View v){
    this.viewList.add(v);
  }


}
