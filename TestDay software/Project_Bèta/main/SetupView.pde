// SetupView.pde
// Processing 3.4
// Rens Dur (Project Bèta)

public class SetupView extends ViewController {
  public ArrayList<Integer> baudRates;
  public File dataOutputFile;
  
  public TextElement Label_FlightName;
  public LineInputElement Input_FlightName;
  
  public TextElement Label_serialPort;
  public SelectionElement Select_serialPort;
  
  public TextElement Label_baudRate;
  public IntegerLineInputElement Select_baudRate;
  
  public TextElement Label_DataOutputFile;
  public TextElement Display_DataOutputFile;
  public UtilityButtonElement Button_DataOutputFile;
  
  
  public TextButtonElement Button_back;
  public ButtonElement Button_continue;
  
  
  
  
  public SetupView(AppController a, float x, float y, float w, float h){
    super(a, x, y, w, h);
    
        
    this.Label_FlightName = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4, 150, "Flight name:", RIGHT);
    
    this.Input_FlightName = new LineInputElement(this.appController, this.dim.x/2 + 10, this.dim.y/4, 200);
    
    
    
    this.Label_serialPort = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4 + 50, 140, "Serial port:", RIGHT);
    
    this.Select_serialPort = new SelectionElement(this.appController, this.dim.x/2 + 10, this.dim.y/4 + 50, 200);
    for(String s : Serial.list()){
      this.Select_serialPort.addOption(s);
    }
    
    
    this.Label_baudRate = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4 + 100, 140, "Baud rate:", RIGHT);
    
    this.Select_baudRate = new IntegerLineInputElement(this.appController, this.dim.x/2 + 10, this.dim.y/4 + 100, 200);
    this.Select_baudRate.setSigned(false);
    //for(int i : this.baudRates){
    //  this.Select_baudRate.addOption(str(i));
    //}
    
    
    this.Label_DataOutputFile = new TextElement(this.appController, this.dim.x/2 - 150, this.dim.y/4 + 150, 140, "Data output file:", RIGHT);
    
    this.Display_DataOutputFile = new TextElement(this.appController, this.dim.x/2 + 30, this.dim.y/4 + 150, 500, "", LEFT);
    
    this.Button_DataOutputFile = new UtilityButtonElement(this.appController, this.dim.x/2 + 10, this.dim.y/4 + 150){
      public void clickEvent(){
        global_askUser_DataOutputFile();
      }
    };
    
    
    
    this.Button_back = new TextButtonElement(this.appController, this.dim.x/2 - 70, this.dim.y - 40, 60, "Back"){
      public void clickEvent(){
        this.appController.back();
      }
    };
    
    this.Button_continue = new ButtonElement(this.appController, this.dim.x/2 + 10, this.dim.y - 40, 100, "Continue"){
      public void clickEvent(){
        this.appController.selectSerialPort();
        this.appController.openMissionView();
      }
    };

    //this.elements.add(this.Label_FlightName);
    //this.elements.add(this.Input_FlightName);
    this.elements.add(this.Label_serialPort);
    this.elements.add(this.Select_serialPort);
    this.elements.add(this.Label_baudRate);
    this.elements.add(this.Select_baudRate);
    //this.elements.add(this.Label_DataOutputFile);
    //this.elements.add(this.Display_DataOutputFile);
    //this.elements.add(this.Button_DataOutputFile);
    
    this.elements.add(this.Button_back);
    this.elements.add(this.Button_continue);
    
  }
  
  public void viewResizeTriggered(){
    this.Label_FlightName.resize(this.dim.x/2 - 150, this.dim.y/4, 150);
    this.Input_FlightName.resize(this.dim.x/2 + 10, this.dim.y/4, 200);
    this.Label_serialPort.resize(this.dim.x/2 - 150, this.dim.y/4 + 50, 140);
    this.Select_serialPort.resize(this.dim.x/2 + 10, this.dim.y/4 + 50, 200);
    this.Label_baudRate.resize(this.dim.x/2 - 150, this.dim.y/4 + 100, 140);
    this.Select_baudRate.resize(this.dim.x/2 + 10, this.dim.y/4 + 100, 200);
    this.Label_DataOutputFile.resize(this.dim.x/2 - 150, this.dim.y/4 + 150, 140);
    this.Display_DataOutputFile.resize(this.dim.x/2 + 30, this.dim.y/4 + 150, 500);
    this.Button_DataOutputFile.resize(this.dim.x/2 + 10, this.dim.y/4 + 150);
    this.Button_back.resize(this.dim.x/2 - 70, this.dim.y - 40, 60);
    this.Button_continue.resize(this.dim.x/2 + 10, this.dim.y - 40, 100);
  }
  
  public void setDataOutputFile(File selection){
    this.dataOutputFile = selection;
    String[] terms = selection.getAbsolutePath().split("/");
    this.Display_DataOutputFile.setText(terms[terms.length - 1]);
    terms = null;
  }
  
  public String getSelectedSerialPort(){
    return this.Select_serialPort.getValue();
  }
  
  public int getSelectedBaudRate(){
    return this.Select_baudRate.getInteger();
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
    text("Session setup", this.dim.x/2, 50);
    
    for(Element e : this.elements){
      e.show();
    }
    
    //
    // End Content
    //
    
    
    translate(-this.pos.x, -this.pos.y);
  }
}
