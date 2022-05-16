class ExplosionParticle{

  float x;
  float y;
  float direction;
  float r;
  float v;
  float rDecay = 0.25;
  String c = "FFFFFFFF";
  
  ExplosionParticle(float mx, float my){
    direction = random(0, 360);
     x = mx;
     y = my;
     r = 8;
     v = 2.5;
  }
  
  public void update(){
      x += v * sin(radians(direction));
      y += -v * cos(radians(direction));
      if(r>0){
        r -= rDecay;
      }
  }
  
  public void show(){
    noStroke();
    fill(unhex(c));
    circle(x,y,r);
  }
 
}
