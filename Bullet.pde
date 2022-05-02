class Bullet{
    
  float x;
  float y;
  float angle;
  float r = 8;
  float speed = 15; 
  
  public Bullet(float ix, float iy, float ia){
    x = ix;
    y = iy;
    angle = ia;
  }
   
  public void update(){      
    x += speed  * cos(angle);
    y += speed  * sin(angle);
  }
   
  public void show(){
    fill(0,255,0);
    ellipse(x, y, r, r);
  }
   
}
