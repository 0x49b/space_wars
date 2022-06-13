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
  
  float angle = 0;
  
  PImage asteroidPic;
  
  
  public Asteroid(float ix, float iy, float ir, PVector iVelocity, float iSpeedModifier){
    x = ix;
    y = iy;
    r = ir;
    velocity = iVelocity;
    speedModifier = iSpeedModifier;
    angle = atan2(velocity.x, velocity.y);
    
    // get an image from an asteroid 1 to 3 random
    int as = (int) Math.round(random(1, 3));
    asteroidPic = loadImage("asteroid"+as+".png");
  }
  
  public void update(){ 
    x += velocity.x * speedModifier + angle;
    y += velocity.y * speedModifier + angle;
  }
  
  public void show(){
   
    if(DEBUG){
      stroke(0,255,0);
    }else {
      noStroke();
    }
    
    //fill(255);
    noFill();
    ellipse(x, y, r, r);
    image(asteroidPic, x-(r/2), y-r/2,r, r);
  }
  
  public void hit(){
    if(r>minR){
      r -= decay;
    }
  } 
  
  public boolean destroyed(){
    return r <= minR;
  }

}
