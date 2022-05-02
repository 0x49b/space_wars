class StartScreen implements Screen{
  
  ControlP5 cp5;
  ControlFont cf2 = new ControlFont(createFont("Times",18));
  Star[] stars = new Star[1000];

  public StartScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addSlider("speed")
     .setPosition(25,25)
     .setSize(100,10)
     .setRange(0.5,100)
     .setValue(0.5);
     
      cp5.getController("speed").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      cp5.getController("speed").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      
     cp5.addButton("startGame")
     .setSize(150, 50)
     .setFont(cf2)
     .setPosition(width/2-75,height/4 + 120);
     
     cp5.addButton("about")
     .setPosition(width-100,25);
     
     cp5.hide();
   
    for( int i = 0; i < stars.length; i++ ){
      stars[i] = new Star();
    }
  }
  
  public void showControls(){
    cp5.show(); //<>//
  }
  
  public void hideControls(){
    cp5.hide();
  }

  public void draw(){
    background(0);
    
    cp5.show();
    
    pushMatrix();
    translate(width/2, height/2);
    for( int i = 0; i < stars.length; i++ ){
      if(stars[i].getZ() > 1.0){
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
