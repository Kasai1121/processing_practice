class Drop{
  float x = random(width);
  float y = random(-200,-100);
  float yspeed = random(10,20);
  
  void fall(){
    y = y + yspeed;
    
    if(y > 400){
      y = random(-200, -100);
    }
  }
  
  void show(){
    stroke(#4269F2);
    line(x,y,x,y+10);
    
  }
  
  
  
}
