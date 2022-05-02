class Asteroid{


  float x;
  float y;
  float r;
  
  PVector pos;
  
  int minR = 20;
  int decay = 5;
  
  public Asteroid(){
    x = random(0, width);
    y = random(0, height);
    r = random(30, 100);
    
    pos = new PVector(x, y);
  }
  
  public void update(){
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
