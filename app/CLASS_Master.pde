//
// CanSat Mission Control Application: Alpha [Project Beta]
// CLASS_Master.pde
// Rens Dur
//

public interface INTERFACE_Master {
	// *public methods*
	public void loop();
	public void keyPressed();
}



public class Master implements INTERFACE_Master {
	// *properties*
	private ViewManager viewManager;

	private View dashboardView;

	public View testView;
	public View testView2;


	// *constructors*
	public Master(){
		this.dashboardView = new View(){
			public void show(){
				noStroke();
				fill(0, 150);
				rect(0, 0, width, height);
			}
		};

		this.viewManager = new ViewManager(this.dashboardView, 100);

		this.testView = new View(){
			public void show(){
				stroke(0);
				fill(0);
				textAlign(CENTER);
				textSize(30);
				text("First View", width/2, height/2);
				noFill();
				rectMode(CORNER);
				rect(0,0,width,height);
			}
		};
		this.testView2 = new View(){
			public void show(){
				stroke(0);
				fill(0);
				textAlign(CENTER);
				textSize(30);
				text("Second View", width/2, height/2);
				noFill();
				rectMode(CORNER);
				rect(0,0,width,height);
			}
		};

		this.viewManager.addView(this.testView);
		this.viewManager.addView(this.testView2);
		this.viewManager.setCurrentView(0);
	}

	// *private methods*


	// *public methods*
	public void loop(){
		stroke(0);
		fill(0);
		textAlign(LEFT);
		textSize(20);
		text(int(frameRate), 10, 20);
		this.viewManager.show();
	}

	public void keyPressed(){
		if(key == CODED){
			if(keyCode == RIGHT){
				this.viewManager.scrollForwards();
			}else if(keyCode == LEFT){
				this.viewManager.scrollBackwards();
			}else if(keyCode == SHIFT){
				this.viewManager.toggleDashboardVisible();
			}
		}
	}
}
