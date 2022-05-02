class GameScreen implements Screen{

  ControlP5 cp5;
  
  PImage background;
  PVector backgroundPos;
  
  boolean gameRunning = false;
  
  Spaceship spaceship;
    
  Asteroid[] asteroids = new Asteroid[10];
  
  public GameScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    
    cp5.addButton("menu")
     .setPosition(25,25);
    cp5.hide();
    
    background = loadImage("stars.jpeg");
    background.resize(1200,675);
    backgroundPos = new PVector(background.width/2, background.height/2);
    spaceship = new Spaceship(width/2, height/2, backgroundPos, cp5Applet);
    
    for(int i = 0; i< asteroids.length; i++){
      asteroids[i] = new Asteroid();
    }

  }
  
  public void hideControls(){
    cp5.hide();
  }
  
  public void draw(){
    background(0);
    cp5.show();
    setGameRunning(true);
    
    pushMatrix();
    translate(backgroundPos.x, backgroundPos.y);
    image(background, 0, 0);
    

    
    popMatrix();
    
    spaceship.show();
    spaceship.update();
    
    updateAsteroids();
    checkAsteroidHit();
    
     
     
     if(DEBUG){
        showDistance();
     }
  }
  
  void updateAsteroids(){
    for(Asteroid a: asteroids){
      a.update();
      a.show();
    } 
  }
  
  void showDistance(){
    CopyOnWriteArrayList<Shot> shots = spaceship.getShots();
    
    
    for(Shot s: shots){
      for(Asteroid a: asteroids){
            stroke(255,0,0);
            line(s.x, s.y, a.x, a.y);
      }
    }
    
    
  }
  
  public void checkAsteroidHit(){
    CopyOnWriteArrayList<Shot> shots = spaceship.getShots();
    
    // todo implement hitLogic
     for(Shot s: shots){
      for(int i = 0; i < asteroids.length; i++){
            
            if( (asteroids[i].pos.dist(s.pos) - (asteroids[i].r + s.r)) < 0  ){
              asteroids[i].hit();
              spaceship.removeShot(s);
              if(asteroids[i].destroyed()){
                asteroids[i] = new Asteroid();
              }
            }
            println(asteroids[i].pos.dist(s.pos) - (asteroids[i].r + s.r));
            
      }
    }
    
    
  }
  
  public void updateSpaceShip(boolean move){
    spaceship.setMove(move);
  }
  
  public void fireSpaceShip(){
    spaceship.fire();
  }
  
  public void setGameRunning(boolean state){
    gameRunning = state;
  }
  
}
