class Spaceship {
  PImage spaceshipAccelerate;
  PImage spaceshipIdle;
  
  PVector pos;
  float angle;
  //float speed;
  
  float deceleration = 0.25;
  float acceleration = 0.15;
  float speed = 0.0;
  boolean move = false;
  
  Spaceship(float x, float y) {
    spaceshipAccelerate = loadImage("spaceship.png");
    spaceshipIdle = loadImage("spaceship-idle.png");
    pos = new PVector(x, y);
  }
  
  
  public void setMove(boolean move){
    this.move = move;
  }
  
  
  void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    if(move){
      image(spaceshipAccelerate, 0, 0);
    }else{
      image(spaceshipIdle, 0, 0);
    }
    
    
    popMatrix();
    
  }
  void update() {
    updateAngle();
    updateMovementSecondExample();
  }
  
  void updateAngle() {
    PVector vel = PVector.sub(new PVector(mouseX, mouseY), pos);
    angle = atan2(vel.y, vel.x);
  }
  
  
  void updateMovementSecondExample() {
    
    if (move){
      speed += acceleration;
      if(speed > 20){
        speed = 20;
      }
    } else {
      speed -= deceleration;
      if(speed < 0){
        speed = 0;
      }
    }
    
           PVector vel = PVector.sub(new PVector(mouseX, mouseY), pos);
      if (vel.mag() < speed) return;
      vel.normalize();
      vel.mult(speed);
      moveBackground(vel);
 
  }
}
