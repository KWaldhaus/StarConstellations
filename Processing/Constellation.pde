class Constellation{
  
  private Data data;
  
  private int constSize;
  private Star[] conStars;
  private Star[] backgroundStars;
  private Connection[] starConnections;
  private Star randStar;
  private int maxDistance = 500;
  int yearsMoved = 1991;
  int timeSpeed = 0;
  int sensitivity = 100;
  String currentRA = "0";
  String currentDEC = "0";
  boolean timeView = false;
  
Constellation(int amount){
  
  data = new Data();
  constSize = amount;
  conStars = new Star[amount];
  
  selectConstellation();
  insertionSort();
  setConnections();
  findStarsInRange();
}

void draw(){
  moveStars();
  drawBackgroundStars();
  drawConstellationStars();
  drawConstellation();
}

//move the stars timeSpeed * their proper motion per year
void moveStars(){
  if(timeView){
      for (int i = 0; i < conStars.length; i++) {
         conStars[i].move(timeSpeed);
      }
      for (int i = 0; i < backgroundStars.length; i++) {
         backgroundStars[i].move(timeSpeed);
      }
      yearsMoved += timeSpeed;
  }
}

//methods for the buttons
public void faster(){
  timeView = true;
  timeSpeed += 10;
}

//slowers time or reverses it
public void slower(){
  timeView = true;
  timeSpeed -= 10;
}

//stops time progression
public void stopTime(){
  timeView = false;
}

//resets time to year 1991
public void resetTime(){
  timeView = false;
  timeSpeed = 0;
  yearsMoved = 1991;
  for (int i = 0; i < conStars.length; i++) {
     conStars[i].resetPosition();
  }
  for (int i = 0; i < backgroundStars.length; i++) {
     backgroundStars[i].resetPosition();
  }
}

//returns the current Year
public String currentYear(){
  return str(yearsMoved);
}

//returns the Right Ascension of our aproximate view Direction
public String currentRA(){
  return conStars[5].getrealRA();
}
//returns the Declination of our aproximate view Direction
public String currentDEC(){
  return conStars[5].getrealDEC();
}

//draws random stars in range depending on location
void findStarsInRange() {
  backgroundStars = new Star[0];
  float raLower = 0;
  float raUpper = 0;
  float raRange = 0;
  float mediumRA = 0;
  
  //getMediumRA of the constellation
  /*for (int i = 0; i < conStars.length; i++) {
     mediumRA += conStars[i].getRA();
  }
  mediumRA = mediumRA / conStars.length;*/
  mediumRA = conStars[conStars.length/2].getRA();
  
  //if position of Star very high or very low, expand the range to the left and right
  if(conStars[conStars.length/2].getDEC() < 90){
    raRange = map(conStars[conStars.length/2].getDEC(), 90, 0, 60, 360);
  }else{
    raRange = map(conStars[conStars.length/2].getDEC(), 90, 180, 60, 360);
  }
  
  //println("Star RA: " + conStars[conStars.length/2].getRA());
  //println("Star DEC: " + conStars[conStars.length/2].getDEC());
  //println("RA Range: " + raRange);

  //workaround for when the range goes above 360° or below 0°
  if(mediumRA - raRange/2 < 0){
    raLower = 360 +(mediumRA - raRange/2);
  }else{
    raLower = mediumRA - raRange/2;
  }
  
  if(mediumRA + raRange/2 > 360){
    raUpper = (mediumRA + raRange/2) - 360;
  }else{
    raUpper = mediumRA + raRange/2;
  }
  
  //println("Medium RA" + mediumRA);
  //println("RA lower: " + raLower);
  //println("RA upper: " + raUpper);
  //println("");
  
  //search for stars in near vicinity
  for (int i = 0; i < 5000; i++) {
      Star star = data.randomStar();
      if((star.getRA() > raLower) || (star.getRA() < raUpper && star.getRA() > 0)){
        backgroundStars = (Star[]) append(backgroundStars, star);
      }
  }
}

//draw the stars of the constellation
void drawConstellationStars() {
  for (int i = 0; i < conStars.length; i++) {
      conStars[i].draw();
  }
}

void drawBackgroundStars() {
  for (int i = 0; i < backgroundStars.length; i++) {
      backgroundStars[i].drawWithAlpha(50);
  }
}

//draw Lines
void drawConstellation(){
  for (int i = 0; i < starConnections.length; i++) {
     starConnections[i].draw();
  } 
}

void update(){
  selectConstellation();
  insertionSort();
  setConnections();
  findStarsInRange();
  getMedianPoint();
  draw();
}

void selectConstellation(){
  boolean found = false;
  conStars[0] = data.randomStar();
  
  for(int i = 1; i <= constSize-1; i++){
    found = false;
    while(!found){
      randStar = data.randomStar();
      
      float distance = conStars[0].getPosition().dist(randStar.getPosition());
      //mediumDistance.add(distance);
      
      if(distance <= maxDistance){
        found = true;
        conStars[i] = randStar;
      }
    }
  }
}

//Random Connection between stars
void setConnections(){
  
  starConnections = new Connection[0];
  int newStart = 0;
  int connectCount = 0;
  
  for(int i = 0; i < conStars.length-1; i++){
    if(i < conStars.length-2){
      connectCount = (int)random(1, 3);  
    }else{
      connectCount = 1;
    }
    for(int j = 1; j < connectCount+1; j++){
      Connection con = new Connection(conStars[i], conStars[i+j]);
      starConnections = (Connection[]) append(starConnections, con);
    }
    newStart = i+connectCount-1;
    if(newStart < conStars.length-1){
      i = newStart;
    }
      
  }
}

//Methode für die Zentrierung der Kamera auf die Constellation
  public PVector getMedianPoint(){
    
    float sumX = 0;
    float sumY = 0;
    float sumZ = 0;
    
    PVector medianPoint;
    for(int i = 0; i < constSize; i++){
      PVector pos = conStars[i].getPosition();
      sumX += pos.x;
      sumY += pos.y;
      sumZ += pos.z;
    }
    medianPoint = new PVector(sumX/constSize, sumY/constSize, sumZ/constSize);
    return medianPoint;
    //return starList.get(conStars[0]).getPosition();
  }
  
  //Sorting the Stars of the Constellation
  void insertionSort() {
      int i, j;
      Star temp;
      for (i = 1; i < conStars.length; i++) {
            temp = conStars[i];
            j = i;
            while (j > 0 && conStars[j - 1].getRA() > temp.getRA()) {
                  conStars[j] = conStars[j - 1];
                  j--;
            }
            conStars[j] = temp;
      }
  }

}