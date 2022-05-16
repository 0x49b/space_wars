class Drop{

  float x;
  float y;
  PImage dropImage;
  int size = 32;
  
  public Drop(float dx, float dy){
    x = dx;
    y = dy;
  }
  
  public void show(){
    
    if(DEBUG){
      pushMatrix();
      stroke(31,180,255);
      noFill();
      rectMode(CENTER);
      circle(x+size/2,y+size/2,size);
      popMatrix();
    }
    
    // rectMode(CENTER);
    image(dropImage, x, y, size, size);
  }
    
}
