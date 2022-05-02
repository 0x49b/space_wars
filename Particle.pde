class Particle{

  float x;
  float y;
  float r;
  
  public Particle(){
    x = random(0, width);
    y = random(0, height);
    r = random(1,5);  
  }
  
  public Particle(float radius){
    x = random(0, width);
    y = random(0, height);
    r = radius;  
  }
  
  public void show(){
    fill(255);
    noStroke();
    ellipse(x,y,r,r);
  }

}
