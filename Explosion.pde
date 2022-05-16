import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

class Explosion{

  CopyOnWriteArrayList<ExplosionParticle> particles = new CopyOnWriteArrayList();
  
  
  public void emit(float mx, float my){
    for(int i = 0; i<20; i++){
      particles.add(new ExplosionParticle(mx, my));
    }
  }
  
  public void show(){
    for(ExplosionParticle p: particles){
    
      p.update();
      p.show();
      
      if(p.r <=0){
        particles.remove(p);
      }
    }
  }
  
}
