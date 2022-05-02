import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

class Spaceship{
  
  //Sounds
  SoundFile pew;
  
  // SpaceShip Image
  PImage spaceship;
  PImage spaceshipIdle;
  int size = 64;
  
  // SpaceShip pos and movement
  //PVector pos;
  
  float shipX = width/2;
  float shipY = height/2;
  float shipDir = 0;
  float shipXSpeed = 0;
  float shipYSpeed = 0;
  float shipSpeed = 0.1;
  float shipDrag = 0.05;
  
  boolean right = false;
  boolean left = false;
  boolean booster = false;
     //<>//
  // Bullets
  CopyOnWriteArrayList<Bullet> bullets = new CopyOnWriteArrayList();
   
  public Spaceship(PApplet game){
    spaceship = loadImage("spaceship.png");
    spaceshipIdle = loadImage("spaceship-idle.png");
    pew = new SoundFile(game, "pew.mp3");
  }
  
  public String toString(){
    return "Spaceship left " + left +" right " + right + " booster " + booster; 
  }
  
  
  public void update(){
    updateShip();
    updateBullets();
  }
  
  public void updateBullets(){
  
    for(Bullet bullet : bullets){
      if(bullet.x < 0 || bullet.y < 0 || bullet.x > width || bullet.y > height){
        bullets.remove(bullet);
      } else {
        bullet.update();
        bullet.show();
      } 
    }
  
  }
  
  public void updateShip(){
        
    if (booster) {
      shipXSpeed += shipSpeed * sin(radians(shipDir));
      shipYSpeed += -shipSpeed * cos(radians(shipDir));
    } else {
      if (shipXSpeed > shipDrag) {
        shipXSpeed -= shipDrag;
      } else if (shipXSpeed < -shipDrag) {
        shipXSpeed += shipDrag;
      }
      
      if (shipYSpeed > shipDrag) {
        shipYSpeed -= shipDrag;
      } else if (shipYSpeed < -shipDrag) {
        shipYSpeed += shipDrag;
      }
      
    }
    
    if (left) {
      if( shipDir < 0 ){
        shipDir = shipDir + 360;
      } else {
        shipDir -= 5;
      }
    }
    
    if (right) {
      if(shipDir > 360){
        shipDir = shipDir-360;
      }else{
        shipDir += 5;
      }
    }
        
    shipX += shipXSpeed;
    shipY += shipYSpeed;
    
    if (shipX < 0) {
      shipX = width;
    }
    if (shipX > width) {
      shipX = 0;
    }
    if (shipY < 0) {
      shipY = height;
    }
    if (shipY > height) {
      shipY = 0;
    }
        
  }
  
    
  public void show(){
    pushMatrix();
      translate(shipX, shipY); 
      rotate(radians(shipDir));
     
      if(booster){
        image(spaceship, -size/2, -size/2, size, size);
      } else {
        image(spaceshipIdle, -size/2, -size/2, size, size);
      }
    popMatrix();
  } 

  
  
  //Steering & Firing
  public void toggleLeft(boolean toggleLeft){
    left = toggleLeft;
  }
  
  public void toggleRight(boolean toggleRight){
    right = toggleRight;
  }
  
  public void toggleBooster(boolean toggleBooster){
    booster = toggleBooster;
  }
  
  public void shoot(){
    pew.play();  
    Bullet bullet = new Bullet(shipX, shipY, radians(shipDir - 90));
    bullets.add(bullet);
  }
  
 CopyOnWriteArrayList<Bullet> getShots(){
    return bullets;
  }
  
  
  
}
