class GSBackground{

  Particle[] stars = new Particle[200];

  public GSBackground(){
    createStars();  
  }
  
  public void createStars(){
  for(int i = 0; i< stars.length; i++){
      stars[i] = new Particle();
    }
  }
  
  public void draw(){
    background(0);
    for(int i = 0; i< stars.length; i++){
      stars[i].show();
    }
  }

}
