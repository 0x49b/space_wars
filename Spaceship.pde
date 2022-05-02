
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

class Spaceship {
  
  PVector backgroundPos;
  
  PImage spaceshipAccelerate;
  PImage spaceshipIdle;
  
  PVector pos;
  float angle;
  
  float deceleration = 0.25;
  float acceleration = 0.15;
  float speed = 0.0;
  boolean move = false;
  
  SoundFile pew;
  
  CopyOnWriteArrayList<Shot> shots = new CopyOnWriteArrayList();
  
  Spaceship(float x, float y, PVector bgPos, PApplet game) {
    spaceshipAccelerate = loadImage("spaceship.png");
    spaceshipIdle = loadImage("spaceship-idle.png");
    pos = new PVector(x, y);
    backgroundPos = bgPos;
    
    pew = new SoundFile(game, "pew.mp3");
  }
  
  public void setMove(boolean move){
    this.move = move;
  }
  
  
  void show() {
    
    updateShots();
    
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
  
  void moveBackground(PVector vel) {
    vel.x = -vel.x;
    vel.y = -vel.y;
    backgroundPos.add(vel);
  }
  
  void updateShots(){
    for(Shot shot: shots){
      if(shot.x < 0 || shot.y < 0 || shot.x > width || shot.y > height){
        shots.remove(shot);
      } else {
        shot.update();
        shot.show();
      } 
    }
  }
  
  void fire(){
    println("pew pew");
    pew.play();
    PVector vel = PVector.sub(new PVector(mouseX, mouseY), pos);
    Shot shot = new Shot(pos.x, pos.y, angle, vel);
    shots.add(shot);
  }
  
  void removeShot(Shot shot){
    shots.remove(shot);
  }
  
  CopyOnWriteArrayList<Shot> getShots(){
    return shots;
  }
}
