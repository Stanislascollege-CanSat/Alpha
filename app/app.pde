
// CREATE THE viewManager INSTANCE VARIABLE
ViewManager viewManager;

// CREATE THE dashboardView INSTANCE VARIABLE
View dashboardView;

// CREATE ALL THE VIEW INSTANCE VARIABLES
View statusView, liveGraphsView;



public void setup(){
  // WINDOW SETUP
  fullScreen(P3D);
  surface.setResizable(true);
  pixelDensity(2);
  smooth(8);
  frameRate(60);

  // VARIABLE INIT
  dashboardView = new View(0, 0, 0, DISPLAYINSTANCE_dashboardView);

  statusView = new View(0, 0, 0, DISPLAYINSTANCE_statusView);
  liveGraphsView = new View(0, 0, 0, DISPLAYINSTANCE_liveGraphsView);

  viewManager = new ViewManager(0, 0, 0, dashboardView, 100);

  //>> add all the views
  viewManager.addView(statusView);
  viewManager.addView(liveGraphsView);


  //>> set the starting view
  viewManager.setStartingView(0);



  // POST SETUP


}

public void draw(){
  // CLEAR CANVAS
  background(255);
  viewManager.show();

}

public void keyPressed(){
  if(key == CODED){
    if(keyCode == RIGHT){
      viewManager.scrollToRightView();
    }else if(keyCode == LEFT){
      viewManager.scrollToLeftView();
    }
  }
}
