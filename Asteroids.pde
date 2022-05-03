import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

class Asteroids{

  private CopyOnWriteArrayList<Asteroid> asteroids = new CopyOnWriteArrayList();
  
  public Asteroids(){}
  
  public void update(){
    
    spawnAsteroid();
    
    for( Asteroid a : asteroids ){
      println(a.x +" "+ a.y);
      a.update();
      a.show();
    }
  }
  
  private void spawnAsteroid(){
    
    float radius = random(30, 100);
    float x;
    float y;
    
    float rand = random(0,2);
    
    if(rand < 0.5){
      x = 0 - radius;
      y = random(0, height);
      
    } else if (rand>0.5 && rand <1.0) {
      
      x = random(0, width);
      y = 0 - radius;
      
    } else if( rand>1.0 && rand <1.5 ){
    
      x = width;
      y = 0 - radius;
      
      
    } else {
    
      
      
    }
    
    float angle = atan2(x, y);
    
    PVector velocity = new PVector( cos(angle), sin(angle) );
    
    float speedModifier = random(2, 3); 
    
    asteroids.add( new Asteroid(x, y, radius, velocity, speedModifier));
    
  
  }

}
