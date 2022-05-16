class GameScreen implements Screen{
  ControlP5 cp5;
  Spaceship spaceship;
  GSBackground gsBackground;
  Asteroids asteroids;
  
  
    int fcStart = 0;
    int fcWait = 60*3;
    boolean alreadyHit = false;
   
  public GameScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu").setPosition(25,25);
    cp5.hide();
    gsBackground = new GSBackground();
    spaceship = new Spaceship(cp5Applet);
    asteroids = new Asteroids();
  }
 
  public void draw(){
    
    
    if( (frameCount - fcStart) > fcWait ){
      noTint();
      alreadyHit = false;
    }
    
    background(0);
    cp5.show();
    gsBackground.draw();
    spaceship.show();
    spaceship.update();
    asteroids.update();
    detectSpaceShipAstroidCollision();
    detectBulletAtroidCollision();
  }
  
  public void detectSpaceShipAstroidCollision(){
  
    for( Asteroid a : asteroids.asteroids ){
      
      if(DEBUG){
        stroke(255,0,0);
        line(a.x, a.y, spaceship.shipX,spaceship.shipY);
      }
   
     if(dist(a.x, a.y, spaceship.shipX, spaceship.shipY) < a.r + 5){
       
        if(!alreadyHit){
           fcStart = frameCount;
           alreadyHit = true;
           tint(255,0,0);
           println("BOING!!!!");
           asteroids.asteroids.remove(a);
        }
     }
    } 
  }
  
  public void detectBulletAtroidCollision(){
     for( Asteroid a : asteroids.asteroids ){
       for(Bullet b : spaceship.bullets){
         
        if(DEBUG){
          stroke(255,0,255);
          line(a.x, a.y, b.x,b.y);
        }
        
        if(dist(a.x, a.y, b.x, b.y) < a.r + b.r){
          
          // Add points to counter --> for Ranking no current Variable for that
          a.r -= 20;
          if(a.r < 20){
            asteroids.asteroids.remove(a);
          }
          spaceship.bullets.remove(b);
        }
       
       } 
     }
  }
  
  public void fireSpaceShip(){
    spaceship.shoot();
  }
  
  
  public void reset(){
    spaceship.reset();
  }
  
  public void hideControls(){
    cp5.hide();
  }
  
}
