class Asteroid{
  
  float x = 0;
  float y = 0;
  float v = 0;
  float r = 0;
  
  PVector pos;
  
  int minR = 20;
  int decay = 5;
  
  public Asteroid(){
    x = random(0, width);
    y = random(0, height);
    r = random(30, 100);
    
    pos = new PVector(x, y);
  }
  
  public Asteroid(float ix, float iy, float ir, float iv){
    x = ix;
    y = iy;
    r = ir;
    v = iv;
  }
  
  public void update(){ 
    x += v;
    y += v;
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
