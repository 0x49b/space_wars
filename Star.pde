class Star{

  float x;
  float y;
  float z;
  
  float speed;
  
  public Star(){
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    speed = 0.5;
  }
  
  public float getZ(){
    return z;
  }
  
  public void setSpeed(float newSpeed){
    speed = newSpeed;
  }
  
  public void update(){
    z = z - speed;
    if (z < 1) {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
    }
  }
  
  public void show(){
    fill(255);
    noStroke();
    
    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);
    
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);
  }

}
