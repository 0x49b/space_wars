class Asteroid{
  
  float x = 0;
  float y = 0;
  float v = 0;
  float r = 0;
  float speedModifier = 0;
  PVector velocity;
  
  PVector pos;
  
  int minR = 20;
  int decay = 5;
  
  
  public Asteroid(float ix, float iy, float ir, PVector iVelocity, float iSpeedModifier){
    x = ix;
    y = iy;
    r = ir;
    velocity = iVelocity;
    speedModifier = iSpeedModifier;
  }
  
  public void update(){ 
    x += velocity.x * speedModifier;
    y += velocity.y * speedModifier;
  }
  
  public void show(){
    noStroke();
    fill(255);
    ellipse(x, y, r, r);
  }
  
  public void hit(){
    println("hit: " +r);
    if(r>minR){
      r -= decay;
    }
  } 
  
  public boolean destroyed(){
    return r <= minR;
  }

}
