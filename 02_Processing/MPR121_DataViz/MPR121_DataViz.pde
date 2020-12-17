import processing.serial.*;

// Sensors
DataPoint[] sensGrid;        // Array of data points from the touch surface
int NSENS = 12;              // number of sensors

// Serial communication
Serial myPort; // Serial communication with touch sensor
String serialData = "";

// Colors
color colorBack = color(255, 255, 255);
color colorPoints = color(0, 0, 0);

// Size
int maxDiameter = 60;       // Max range to display data point

void setup()
{
  // Set size
  size(800, 100);

  // Set data point grid
  sensGrid = new DataPoint[NSENS];
  for (int i = 0; i < NSENS; i++) {
    sensGrid[i] = new DataPoint(i);
  }

  // Set serial communication with touch sensors
  println(Serial.list());
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600); // initialize serial communication
  myPort.clear();
}

void draw()
{
  background(colorBack);

  // Display sensors states
  for (int i = 0; i < NSENS; i++) {
    sensGrid[i].display(maxDiameter); // display data point
  }
}

// Receive Arduino messages
void serialEvent(Serial myPort) {
  String serialData = myPort.readStringUntil(13);
  if (serialData != null)
  {
    if (serialData != "") {
        serialData = serialData.trim();

        // GET SENSORS STATES
        int[] sensStates_ = int(split(serialData, 'x')); 
        if (sensStates_.length == NSENS + 1) {
          for (int i = 0; i < NSENS; i++) {  
            sensGrid[i].setState(sensStates_[i] != 0);  // fill data point with its current state (true/false <-> touch/release)
          }
        }
      }
    myPort.clear();
  }
}
