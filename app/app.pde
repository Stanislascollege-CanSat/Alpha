// ===== IMPORTS ===== //


// ===== VARIABLES ===== //
ViewManager viewManager;

View viewFront, viewBack, viewLeft, viewRight;

float viewDistance;


// ===== setup() ===== //

public void setup(){
  // ===== WINDOW SETUP ===== //
  size(800, 600, P3D);
  surface.setResizable(true);
  pixelDensity(2);

  // ===== VARIABLE INIT ===== //
  viewDistance = 750;
  viewFront = new View("front",0,0,-viewDistance, 0,1,0, 0,0,0, CONTENT_view_front);
  viewBack = new View("back",0,0,viewDistance, 0,1,0, 0,PI,0, CONTENT_view_back);
  viewLeft = new View("left", -viewDistance,0,0, 0,1,0, 0,PI/2,0, CONTENT_view_left);
  viewRight = new View("right", viewDistance,0,0, 0,1,0, 0,-PI/2,0, CONTENT_view_right);
  viewManager = new ViewManager("front", viewFront);
  viewManager.addView("back", viewBack);
  viewManager.addView("left", viewLeft);
  viewManager.addView("right", viewRight);

}

// ===== draw() ===== //

public void draw(){
  background(255);
  viewManager.show();
}

public void keyPressed(){
  if(key == '1'){
    if(viewManager.getCurrentViewName() == "back"){
      viewManager.executeFunctionAfterTransition(new Runnable(){
        public void run(){
          viewManager.scrollToView("front");
        }
      });
      viewManager.scrollToView("right");
    }else{
      viewManager.scrollToView("front");
    }
  }else if(key == '2'){
    if(viewManager.getCurrentViewName() == "left"){
      viewManager.executeFunctionAfterTransition(new Runnable(){
        public void run(){
          viewManager.scrollToView("right");
        }
      });
      viewManager.scrollToView("front");
    }else{
      viewManager.scrollToView("right");
    }
  }else if(key == '3'){
    if(viewManager.getCurrentViewName() == "front"){
      viewManager.executeFunctionAfterTransition(new Runnable(){
        public void run(){
          viewManager.scrollToView("back");
        }
      });
      viewManager.scrollToView("left");
    }else{
      viewManager.scrollToView("back");
    }
  }else if(key == '4'){
    if(viewManager.getCurrentViewName() == "right"){
      viewManager.executeFunctionAfterTransition(new Runnable(){
        public void run(){
          viewManager.scrollToView("left");
        }
      });
      viewManager.scrollToView("front");
    }else{
      viewManager.scrollToView("left");
    }
  }
}
