class StartScreen implements Screen{

  Star[] stars = new Star[1000];

  public StartScreen(){ 
    for( int i = 0; i < stars.length; i++ ){
      stars[i] = new Star();
    }
  }
  
  public void initializeControls(){
     //<>//
  }

  public void draw(){
    background(0);
    
    
    pushMatrix();
    translate(width/2, height/2);
    for( int i = 0; i < stars.length; i++ ){
      if(stars[i].getZ() > 1){
      stars[i].update();
      stars[i].show();
      } else {
        stars[i] = new Star();
      }
    }
    popMatrix();
     
    fill(#ffe817);
    textAlign(CENTER, CENTER);
    textFont(titleFont);
    text("SpaceWars", width/2, height/4); 
  }
  
  
  public void setStarSpeed(float newSpeed){
  for( int i = 0; i < stars.length; i++ ){
      stars[i].setSpeed(newSpeed);
    }
  }

}
