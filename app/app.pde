//
// CanSat Mission Control Application: Alpha [Project Beta]
// app.pde
// Rens Dur
//

Master master;

public void setup(){
	size(1000, 600, P3D);
	// pixelDensity(2);
	smooth(8);


	master = new Master();

}

public void draw(){
	background(255);
	master.loop();
}

public void keyPressed(){
	master.keyPressed();
}
