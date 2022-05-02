class Shot{
    
  float x;
  float y;
  float r = 8;
  
  float angle;
  PVector vel;
  
  float speed = 10;
  
  PVector pos;
  
  
  public Shot(float ix, float iy, float ia, PVector v){
    x = ix;
    y = iy;
    angle = ia;
    vel = v;
    pos = new PVector(ix, iy);
  }
   
   public void update(){      
      float rotation = atan2(vel.y, vel.x);
      x += speed  * cos(rotation);
      y += speed  * sin(rotation);
      pos.x = x;
      pos.y = y;
   }
   
   public void show(){
     
     fill(0,255,0);
     ellipse(x, y, r, r);
   
   }
   
  
  
  
}
