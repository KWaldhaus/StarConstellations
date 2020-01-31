//Parsen der Daten ändern.
//Routine einbauen die Sterne in einem Bereich sucht.
//Nur gewünschte Anzahl an Sternen liefern.
//COLOR UND Magnitude hinzufügen

class Data{
  private Star[] list;
  private Star randStar;
  //Filename
  final String fileName = "hip_main.dat";
  
  //Array of the files Lines
  public String[] lines;
  
  //Line/Properties
  private String data[];
  
  //Distance for Stars
  private int RADI = 1;

  //DataArrays
  private ArrayList<Star> starList = new ArrayList<Star>();
  
  //Position errechenbar(keine fehlenden Werte)
  private boolean posAvail = true;
  
  Data(){
    //load File in a String array
    lines = loadStrings(fileName);
  }
  
  Boolean positionAvailable(int i){
    
    boolean posAvail = false;
    //Declaration
    data = new String[77]; 
    
    //Line splitten
    data = split(lines[i], "|");
    
    //Right Ascension Parse
    if(Float.isNaN(float(data[8]))){
      posAvail = false;
    }else{
      posAvail = true;
    }
    
    //Declination Parse
    if(Float.isNaN(float(data[9]))){
      posAvail = false;
    }else{
      //Declination Parse
      if(float(data[9]) < 0){
        posAvail = true;
      }else{
        posAvail = true;
      }
    }
    
    //Parsec Parse
    if(Float.isNaN(float(data[11]))){
      posAvail = false;
    }else if(float(data[11]) > 0){
      posAvail = true;
    }
    return posAvail;
  }
  
  Star parse(int i){
    //Declaration
    data = new String[77]; 
    
    //Line splitten
    data = split(lines[i], "|");

    //Daten wegspeichern
    Star star = new Star();

      
    //set Right Ascension
    star.setRA(float(data[8]));
    
    //Declination Parse
    if(float(data[9]) < 0){
      star.setDEC((float(data[9]) * -1) +90);
    }else{
      star.setDEC(90 - float(data[9]));
    }
    
    //setNumber
    star.setNumber(int(data[1]));
    
    //setParsec with Mapping
    if(float(data[11]) > 0){
    star.setParsec(map(1/((float(data[11])/1000)), 0, 3000, 900, 6000));
    //without mapping
    //star.setParsec(1/((float(data[i][11])/1000)));
    }
    
    //set RA in hms
    star.setrealRA(data[3]);
    
    //set DEC in deg ' "
    star.setrealDEC(data[4]);
    
    //set proper motion for RA
    star.setPM_RA((float(data[12]))/360000);
    
    //set proper motion for DEC
    star.setPM_DEC((float(data[13]))/360000);
    
    //set magnitude map fpr alpha value
    star.setMagnitude(map(float(data[5]), 0, 13, 0, 255));
    
    //set color of the star
    star.setstarColor(bvToRGB(float(data[37])));
    
    
    return star;
  }
  
  //returns a random Star if the position is calculatable
  public Star randomStar(){
    int randomStarNumber = 0;
    boolean starFound = false;
    while(!starFound){
       randomStarNumber = (int)(random(0, lines.length));
       starFound = positionAvailable(randomStarNumber);
    }
    return parse(randomStarNumber);
  }

  //B-V Color Spektrum to RGB Colors(https://stackoverflow.com/questions/21977786/star-b-v-color-index-to-apparent-rgb-color , Credit: Spektre)
  color bvToRGB(float bv)
    {
        float r = 0;
        float g = 0;
        float b = 0;
        float t = 0;

        if (bv > 2)
            bv = 2;
        if(bv <= -0.4f)
            bv = -0.4f;

        if ((bv >= -0.40) && (bv < 0.00))
        {
            t = (bv + 0.40f) / (0.00f + 0.40f);
            r = 0.61f + (0.11f * t) + (0.1f * t * t);
        }
        else if ((bv >= 0.00) && (bv < 0.40))
        {
            t = (bv - 0.00f) / (0.40f - 0.00f);
            r = 0.83f + (0.17f * t);
        }
        else if ((bv >= 0.40) && (bv < 2.10))
        {
            t = (bv - 0.40f) / (2.10f - 0.40f);
            r = 1.00f;
        }
        if ((bv >= -0.40) && (bv < 0.00f))
        {
            t = (bv + 0.40f) / (0.00f + 0.40f);
            g = 0.70f + (0.07f * t) + (0.1f * t * t);
        }
        else if ((bv >= 0.00) && (bv < 0.40))
        {
            t = (bv - 0.00f) / (0.40f - 0.00f);
            g = 0.87f + (0.11f * t);
        }
        else if ((bv >= 0.40) && (bv < 1.60))
        {
            t = (bv - 0.40f) / (1.60f - 0.40f);
            g = 0.98f - (0.16f * t);
        }
        else if ((bv >= 1.60) && (bv < 2.00))
        {
            t = (bv - 1.60f) / (2.00f - 1.60f);
            g = 0.82f - (0.5f * t * t);
        }
        if ((bv >= -0.40) && (bv < 0.40))
        {
            t = (bv + 0.40f) / (0.40f + 0.40f);
            b = 1.00f;
        }
        else if ((bv >= 0.40) && (bv < 1.50))
        {
            t = (bv - 0.40f) / (1.50f - 0.40f);
            b = 1.00f - (0.47f * t) + (0.1f * t * t);
        }
        else if ((bv >= 1.50) && (bv < 1.94))
        {
            t = (bv - 1.50f) / (1.94f - 1.50f);
            b = 0.63f - (0.6f * t * t);
        }
        return color(r*255, g*255, b*255);
    }
  
  void parseStars(){
    list = new Star[0];
    for(int i = 0; i < 30000; i++){
      if(positionAvailable(i)){
        list = (Star[]) append(list, parse(i));
      }
    }
  }
  
  void drawStars(){
    for(int i = 0; i < list.length; i++){
      list[i].draw();
    }
  }
  
}