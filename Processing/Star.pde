class Star{
  
  private PVector Position;
  private PVector backupPosition;
  
  private float RA;
  private float backupRA;
  private String realRA;
  
  private float DEC;
  private float backupDEC;
  private String realDEC;
  
  private float Magnitude;
  private float PM_RA;
  private float PM_DEC;
  private int Number;
  private float Parsec;
  private color StarColor;
  
  void Star(){
  }
  
  public void setPosition(PVector pos){
    Position = pos;
  }
  
  public PVector getPosition(){
    return Position;
  }
  
  public void setRA(float ra){
    RA = ra;
    backupRA = ra;
    Position = calcPosition();
    backupPosition = calcPosition();
  }
  
  public float getRA(){
    return RA;
  }
  
  public void setDEC(float dec){
    DEC = dec;
    backupDEC = dec;
    Position = calcPosition();
    backupPosition = calcPosition();
  }
  
  public float getDEC(){
    return DEC;
  }
  
  public void setNumber(int num){
    Number = num;
  }
  
  public int getNunmer(){
    return Number;
  }
  
  public void setParsec(float pars){
    Parsec = pars;
    Position = calcPosition();
    backupPosition = calcPosition();
  }
  
  public float getParsec(){
    return Parsec;
  }
  
  public void setMagnitude(float mag){
    Magnitude = mag;
  }
  
  public float getMagnitude(){
    return Magnitude;
  }
  
  public void setPM_RA(float pm_ra){
    PM_RA = pm_ra;
  }
  
  public float getPM_RA(){
    return PM_RA;
  }
  
  public void setPM_DEC(float pm_dec){
    PM_DEC = pm_dec;
  }
  
  public float getPM_DEC(){
    return PM_DEC;
  }
  
  public void setstarColor(color col){
    StarColor = col;
  }
  
  public color getstarColor(){
    return StarColor;
  }
  
  public void setrealDEC(String dec){
    String[] temp = split(dec, " ");
    realDEC = temp[0] + "deg " + temp[1] + "' " + temp[2] + "\"";
  }
  
  public String getrealDEC(){
    return realDEC;
  }
  
  //set RA in hms
  public void setrealRA(String ra){
    String[] temp = split(ra, " ");
    realRA = temp[0] + "h " + temp[1] + "min " + temp[2] + "sec";
  }
  
  public String getrealRA(){
    return realRA;
  }
  
  public PVector calcPosition(){
    float x = Parsec  * sin(radians(DEC)) * cos(radians(RA));
    float z = Parsec  * sin(radians(DEC)) * sin(radians(RA));
    float y = Parsec  * cos(radians(DEC));
   
    return new PVector(x, y, z);
  }
  
  //adds 1 Julian year of proper motion and recalculates Position
  public void move(float factor){
    RA += PM_RA * factor;
    DEC += PM_DEC * factor;
    Position = calcPosition();
  }
  
  void resetPosition(){
    Position = backupPosition;
    RA = backupRA;
    DEC = backupDEC;
  }
  
  public void draw(){
    pushStyle();
    pushMatrix();
    noStroke();
    fill(StarColor);
    translate(Position.x, Position.y, Position.z);
    sphereDetail(10);
    sphere(5);
    popMatrix();
    popStyle();
  }
  
  public void drawWithAlpha(int alpha){
    pushStyle();
    pushMatrix();
    noStroke();
    fill((StarColor >> 16) & 0xFF, (StarColor >> 8) & 0xFF, StarColor & 0xFF, 255);
    translate(Position.x, Position.y, Position.z);
    sphereDetail(10);
    sphere(2);
    popMatrix();
    popStyle();
  }
}