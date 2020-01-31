class Connection{
  
  Star start;
  Star target;
  
  Connection(Star _start, Star _target){
    start = _start;
    target = _target;
  }
  
  void draw(){
   pushStyle();
   noFill();
   stroke(color(255, 243,200));
   strokeWeight(1);
   line(start.getPosition().x, start.getPosition().y, start.getPosition().z, target.getPosition().x, target.getPosition().y, target.getPosition().z);
   popStyle();
  }
}