import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;


class GameScreen implements Screen{
  ControlP5 cp5;
  Spaceship spaceship;
  GSBackground gsBackground;
  Asteroids asteroids;
  Explosion explosion;
  SoundFile dropPing;
  
  String godmodeSequence = "";
  boolean godmode = false;
  
  
  int fcStart = 0;
  int fcWait = 60*3;
  boolean alreadyHit = false;
  
  int lives = 3;
  boolean shield = false;
  int asteroidDecayOnHit = 20;
  
  private CopyOnWriteArrayList<Drop> drops = new CopyOnWriteArrayList();

  PImage shieldImage = loadImage("shield.png");
  PImage shieldNoneImage = loadImage("shield-none.png");
  PImage heartImage = loadImage("heart.png");
  PImage heartGreyImage = loadImage("heart-grey.png");
  PImage godmodeImage = loadImage("godmode.png");
  PImage[] statsBar = new PImage[5];
   
  public GameScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu").setPosition(25,25);
    cp5.hide();
    gsBackground = new GSBackground();
    spaceship = new Spaceship(cp5Applet);
    asteroids = new Asteroids();
    explosion = new Explosion(cp5Applet);
    
    statsBar[0] = heartImage; 
    statsBar[1] = heartImage;
    statsBar[2] = heartImage;
    statsBar[3] = shieldNoneImage;
    statsBar[4] = shieldNoneImage;
    dropPing = new SoundFile(cp5Applet, "ping.mp3");
  }
 
  public void draw(){
    
    background(0);
    if( (frameCount - fcStart) > fcWait ){
      noTint();
      alreadyHit = false;
    }
    
    
    cp5.show();
    gsBackground.draw();
    showStatsBar();
    spaceship.setShield(shield);
    spaceship.show();
    spaceship.update();
    asteroids.update();
    showDrops();
    
    detectSpaceShipDropCollision();
    explosion.show();
    detectBulletAtroidCollision();
    detectSpaceShipAstroidCollision();
    
    if(DEBUG){
      pushMatrix();
        fill(255);
        textAlign(LEFT);
        text("Score: " + stats.getScore() + " Lives: " + lives +" Shield: " + shield , 25, height - 50 );
        text(stats.getStatsDebug(), 25, height - 75 );
      popMatrix();
    }
  }
  
  public void showStatsBar(){
    
    if(godmode){
      statsBar[4] = godmodeImage;
    } else {
      statsBar[4] = shieldNoneImage;
    }
    
    if(shield){
      statsBar[3] = shieldImage;
    } else {
      statsBar[3] = shieldNoneImage;
    }
    
    switch(lives){
      case 1:
        statsBar[0] = heartImage; 
        statsBar[1] = heartGreyImage;
        statsBar[2] = heartGreyImage;
      break;
      case 2:
        statsBar[0] = heartImage; 
        statsBar[1] = heartImage;
        statsBar[2] = heartGreyImage;
      break;
      default:
        statsBar[0] = heartImage; 
        statsBar[1] = heartImage;
        statsBar[2] = heartImage;
    }
    
    for(int i = 0; i < statsBar.length; i++){
      image(statsBar[i], 100 + i * 16, 25 , 16,16 );
    }
    
    textSize(15);
    text("Punkte: " + stats.getScore(), 150 + statsBar.length * 16, 38);
    
    
    
  }
  
  public void showDrops(){
      for(Drop d : drops){
      d.show();
    }
  }
  
  public void dropItem(float x, float y){
  
    float dropRand = random(0, 1);
    
    if(dropRand < 0.15){
      if(lives < 3){
        drops.add(new HeartDrop(x, y));
      }
    } else if( dropRand<.75 && dropRand>.72) {
     drops.add(new ShieldDrop(x, y));
    }
  }
  
  public void detectSpaceShipDropCollision(){
    
    for( Drop d: drops ){
      
      if(DEBUG){
        stroke(31,180,255);
        line(d.x+d.size/2, d.y+d.size/2, spaceship.shipX,spaceship.shipY);
      }
      
      if(dist(d.x, d.y, spaceship.shipX, spaceship.shipY) < d.size + 5){
        
        switch(d.getClass().getSimpleName()){  
          case "HeartDrop":
            if(lives < 3){
              lives++;
              stats.addHeart();
            }
          break;
          case "ShieldDrop":
            shield = true;
            stats.addShield();
          break;
        }
        
            if(sound){
              dropPing.play();
            } 
        
        drops.remove(d);
      }
    }
  }
  
  public void detectSpaceShipAstroidCollision(){
    
    if(!godmode){
  
    for( Asteroid a : asteroids.asteroids ){
      
      if(DEBUG){
        stroke(0,255,0);
        line(a.x, a.y, spaceship.shipX,spaceship.shipY);
      }
   
     if(dist(a.x, a.y, spaceship.shipX, spaceship.shipY) < a.r + 5){
       
       if(!shield){
        if(!alreadyHit){
             asteroids.asteroids.remove(a);
             lives--;
             
             if(lives == 0){
               gameOver = true;
             }
             
             stats.decrementScore();
             explosion.emit(a.x, a.y);
             drops.clear();
          }
       }
       
       
        a.r -= asteroidDecayOnHit;
       
        fcStart = frameCount;
        alreadyHit = true;
        shield = false;
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
        
          stats.incrementScore();
          stats.addAsteroidHit();
          
          explosion.emit(a.x, a.y);
          a.r -= asteroidDecayOnHit;
          if(a.r < asteroidDecayOnHit){
            dropItem(a.x, a.y);
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
  
  public void checkGodmode(char c){
     
    if( c == 'g' || c == 'o' || c == 't'){
    
      if(godmodeSequence.length() < 4){
        godmodeSequence += c;
      }
      
      if(godmodeSequence.length() == 4){
        if(godmodeSequence.equals("gott")){
          godmode = !godmode;
          godmodeSequence = "";
        }
      }
    }
    
  }
  
}
