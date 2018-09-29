//
// CanSat Mission Control Application: Alpha [Project Beta]
// CLASS_ViewManager.pde
// Rens Dur
//

public interface INTERFACE_ViewManager {
	// *public methods*
	public void show();
	public void addView(View view);
	public void setCurrentView(int view);
	public void scrollToView(int view);
	public void scrollForwards();
	public void scrollBackwards();
}



public class ViewManager implements INTERFACE_ViewManager {
	// *properties*
	private ArrayList<View> viewList;
	private int currentView;
	private int nextView;
	private boolean isTransitioning;
	private boolean transitionDirection;
	private float transitionSpeed;
	private float transitionOffset;

	private float dotTopOffset;
	private float dotContainer;
	private float dotXMargin;
	private float dotSize;

	private float viewDepth;


	// *constructors*
	public ViewManager(float _viewDepth){
		this.viewList = new ArrayList<View>();
		this.currentView = -1;
		this.isTransitioning = false;
		this.transitionDirection = false;
		this.transitionSpeed = 600;
		this.transitionOffset = 0;

		this.dotTopOffset = 10;
		this.dotContainer = 8;
		this.dotXMargin = 1;
		this.dotSize = 6;

		this.viewDepth = -_viewDepth;
	}

	// *private methods*
	private void calculateNextTransition(){
		if(this.isTransitioning){
			if(this.transitionDirection){
				this.transitionOffset -= this.transitionSpeed/frameRate;
				if(this.transitionOffset <= -255){
					this.transitionOffset = 0;
					this.isTransitioning = false;
					this.currentView = this.nextView;
					this.nextView = -1;
				}
			}else{
				this.transitionOffset += this.transitionSpeed/frameRate;
				if(this.transitionOffset >= 255){
					this.transitionOffset = 0;
					this.isTransitioning = false;
					this.currentView = this.nextView;
					this.nextView = -1;
				}
			}
		}
	}

	private void displayCurrentViewIndicator(){
		int amountOfDots = this.viewList.size();
		translate(width/2 - amountOfDots*(this.dotContainer+this.dotXMargin)/2 + this.dotSize/2 + this.dotXMargin/2, this.dotTopOffset, 0);
		noStroke();
		fill(150);
		for(int i = 0; i < amountOfDots; ++i){
			ellipse(i*(this.dotContainer+this.dotXMargin), 0, this.dotSize, this.dotSize);
		}
		fill(0);
		ellipse(this.currentView*(this.dotContainer+this.dotXMargin), 0, this.dotSize, this.dotSize);
		translate(-width/2 + amountOfDots*(this.dotContainer+this.dotXMargin)/2 - this.dotSize/2 - this.dotXMargin/2, -this.dotTopOffset, 0);
	}


	// *public methods*
	public void show(){
		this.displayCurrentViewIndicator();
		translate(map(this.transitionOffset, -255, 255, -width + this.viewDepth, width - this.viewDepth), 0, this.viewDepth);
		if(this.currentView >= 0){
			this.viewList.get(this.currentView).show();
		}
		if(this.isTransitioning){
			if(this.transitionDirection){
				translate(width - this.viewDepth, 0, 0);
				this.viewList.get(this.nextView).show();
				translate(-width + this.viewDepth, 0, 0);
			}else{
				translate(-width + this.viewDepth, 0, 0);
				this.viewList.get(this.nextView).show();
				translate(width - this.viewDepth, 0, 0);
			}
		}
		translate(-map(this.transitionOffset, -255, 255, -width + this.viewDepth, width - this.viewDepth), 0, -this.viewDepth);
		this.calculateNextTransition();
	}

	public void addView(View view){
		this.viewList.add(view);
	}

	public void setCurrentView(int view){
		if(view >= 0 && view < this.viewList.size()){
			this.currentView = view;
		}
	}

	public void scrollToView(int view){
		if(this.currentView >= 0 && this.currentView < this.viewList.size()){
			if(view >= 0 && view < this.viewList.size() && view != this.currentView){
				//the view exists and != currentView
				this.isTransitioning = true;
				if(view > this.currentView){
					this.transitionDirection = true;
					this.transitionOffset = 0;
					this.nextView = view;
				}else{
					this.transitionDirection = false;
					this.transitionOffset = 0;
					this.nextView = view;
				}
			}
		}
	}

	public void scrollForwards(){
		if(this.viewList.size() > 1){
			nextView = this.currentView + 1;
			if(nextView >= this.viewList.size()){
				nextView = 0;
			}
			this.scrollToView(nextView);
		}
	}

	public void scrollBackwards(){
		if(this.viewList.size() > 1){
			nextView = this.currentView - 1;
			if(nextView < 0){
				nextView = this.viewList.size() - 1;
			}
			this.scrollToView(nextView);
		}
	}
}
