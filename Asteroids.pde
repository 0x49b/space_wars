import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

class Asteroids{

  private CopyOnWriteArrayList<Asteroid> asteroids = new CopyOnWriteArrayList();
  
  public Asteroids(){}
  
  public void update(){
    
    if(DEBUG){
      pushMatrix();
        fill(255);
        textAlign(LEFT);
        text("Asteroids: " + asteroids.size()+ " frameRate: " +  round(frameRate) + "FPS", 25, height - 25 );
      popMatrix();
    }
    
    if(frameCount % 10 == 0 && asteroids.size() < 50){
      spawnAsteroid();
    }
    
    
    for( Asteroid a : asteroids ){
        a.update();
      
      if( a.x < 0 - (2*a.r) || a.x > width + (2*a.r) || a.y < 0 - (2*a.r) || a.y > height + (2*a.r)){
        asteroids.remove(a);
      }
      
      a.show();
    
  }
    
  }
  
  private void spawnAsteroid(){
    
    float radius = random(20, 75);
    float x = 0;
    float y = 0;
    
    float speedModifier = random(2, 3);
    
    float rand = random(0,2);
    
    
    if(rand <= 0.5){ //left Border spawnpoint
    
      x = 0 - radius;
      y = random(0, height);
    
    } else if(rand > 0.5 && rand <= 1.0){ //top Border spawnpoint
    
      x = width + radius;
      y = random(0, height);
    
    } else if(rand > 1.0 && rand <= 1.5){ //right Border spawnpoint
    
      x = random(0, width);
      y = 0 - radius;
    
    } else if(rand > 1.5 && rand <= 2.0){ //bottom Border spawnpoint
    
      x = random(0, width);
      y = height + radius;
    
    }
    
     
    float angle = atan2(x, y) + random(0, 15);
    
    PVector velocity = new PVector( cos(angle), sin(angle) );

    asteroids.add( new Asteroid(x, y, radius, velocity, speedModifier));
    
  
  }

}
