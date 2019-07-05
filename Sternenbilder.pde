//Sternenbilderprojekt
//Bei jedem Aufruf ein zufälliges anderes Sternenbild erzeugen.
//TODO

//****************************************
//Main           => Interaktion einbauen
//****************************************

//Data           => Helligkeit einbauen
//Data           => Farben einbauen

//Constellation  => Bereich für Sterne raussuchen und nur diese Zeichnen.
//Constellation  => PROPER SORTING ALGORYTHM



import java.util.Hashtable;
import peasy.*;
import controlP5.*;

PeasyCam cam;
ControlP5 gui;
int guiHeight;
Textarea yearTextArea;
Textarea raTextArea;
Textarea decTextArea;

public float[] ra;
public float[] dec;

public int radius = 1;
public int starAmount = 10;

public Data data;
public Constellation constellation;

color backgroundColor1 = color(0,11,94);
color backgroundColor2 = color(46,0,138);

PVector medianPoint;

void setup() {
  size(1280, 900, P3D);
  guiHeight = 200;
  gui = new ControlP5(this);
  constellation = new Constellation(starAmount);
  setupGUI(gui);
  gui.setAutoDraw(false);

  medianPoint = constellation.getMedianPoint();
  //cam = new PeasyCam(this, 0, 0, 0,  300);
  cam = new PeasyCam(this, medianPoint.x, medianPoint.y, medianPoint.z, 300);
  camera(0, 0, 0, medianPoint.x, medianPoint.y, medianPoint.z, 0.0, 1.0, 0.0);
}

void draw() {
  pushMatrix();
  //background(#000329);
  background(#0e1525);
  constellation.draw();
  popMatrix();
  yearTextArea.setText(constellation.currentYear());
  raTextArea.setText(constellation.currentRA());
  decTextArea.setText(constellation.currentDEC());
  gui();
}

void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  gui.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void keyPressed(){
  //new constellation
  if(key == 'u'){
    neu();
  }
  //recenter the camera
  if(key == 'r'){
    reset();
  }
  //start time progression
  if(key == 'd'){
    faster();
  }
  //slower time progression
  if(key == 'd'){
    slower();
  }
  //stop time progression
  if(key == 's'){
    stopTime();
  }
  //reset time progression
  if(key == 'a'){
    resetTime();
  }
}

void setupGUI(ControlP5 p5){
  
  p5.addButton("neu")
  .setPosition(10, 10)
  .setCaptionLabel("Neues Bild");
  
  p5.addButton("reset")
  .setPosition(100,10)
  .setCaptionLabel("Zentrieren");
  
  p5.addButton("faster")
  .setPosition(10,40)
  .setCaptionLabel("Schneller");
  
  p5.addTextarea("Year")
  .setPosition(100,45)
  .setText("Year:");
  
  yearTextArea = p5.addTextarea("currentYear")
  .setPosition(140,45)
  .setText(constellation.currentYear());
  
  //Label for current Right Acension in h:min:sec
  p5.addTextarea("RA")
  .setPosition(10,height-30)
  .setText("RA:");
  
  raTextArea = p5.addTextarea("ra")
  .setPosition(40,height - 30)
  .setText(constellation.currentRA());
  
  //Label for current Declination in deg ' "
  p5.addTextarea("DEC")
  .setPosition(10,height -60)
  .setText("Dec:");
  
  decTextArea = p5.addTextarea("dec")
  .setPosition(40,height -60)
  .setText(constellation.currentDEC());
  
  
  
  p5.addButton("slower")
  .setPosition(10,70)
  .setCaptionLabel("Langsamer");
  
  p5.addButton("stopTime")
  .setPosition(10,100)
  .setCaptionLabel("Zeit Stop");
  
  p5.addButton("resetTime")
  .setPosition(10,130)
  .setCaptionLabel("Zeit Reset");
}


//new constellation
void neu(){
  constellation.update();
  medianPoint = constellation.getMedianPoint();
  cam = new PeasyCam(this, 0, 0, 0,  300);
  camera(0, 0, 0, medianPoint.x, medianPoint.y, medianPoint.z, 0.0, 1.0, 0.0);
}

//reset camera
void reset(){
  //constellation.resetTime();
  medianPoint = constellation.getMedianPoint();
  camera(0, 0, 0, medianPoint.x, medianPoint.y, medianPoint.z, 0.0, 1.0, 0.0);
}

//move time forward faster
void faster(){
  constellation.faster();
}

//move time slower
void slower(){
  constellation.slower();
}

//stop time
void stopTime(){
  constellation.stopTime();
}

//reset time to year 1991
void resetTime(){
  constellation.resetTime();
}
