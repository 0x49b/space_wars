class StartScreen implements Screen{
  
  ControlP5 cp5;
  
  PFont cf1 = createFont("opensans.ttf",14);
  ControlFont cf2 = new ControlFont(createFont("opensans.ttf",18));
  
  Star[] stars = new Star[1000];
  
  boolean playerNameError = false;
  
  SoundFile startsound;
 
  public StartScreen(PApplet cp5Applet){
    
    startsound = new SoundFile(cp5Applet, "startsound.mp3");
      
    cp5 = new ControlP5(cp5Applet);
    cp5.addSlider("speed")
     .setPosition(25,25)
     .setSize(100,10)
     .setRange(0.5,100)
     .setValue(0.5);
      cp5.getController("speed").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      cp5.getController("speed").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      
     cp5.addToggle("sound")
     .setPosition(150,25)
     .setSize(50,10)
     .setValue(!sound)
     .setMode(ControlP5.SWITCH);
     cp5.getController("sound").setCaptionLabel("Sound & Effects");
      
     cp5.addButton("startGame")
     .setSize(150, 50)
     .setFont(cf2)
     .setPosition(width/2-75,height/4 + 220);
     
     cp5.addButton("multiplayer")
     .setSize(150, 50)
     .setFont(cf2)
     .setPosition(width/2-75,height/4 + 290);
     
     
     cp5.addButton("about")
     .setPosition(width-100,25);
          
     cp5.addTextfield("textValue")
     .setPosition(width/2-100,height/4 + 120)
     .setSize(200,40)
     .setFont(cf2)
     .setFocus(true)
     .setAutoClear(false);
     
     cp5.getController("textValue").setCaptionLabel("Playername");
          
     cp5.hide();
   
    for( int i = 0; i < stars.length; i++ ){
      stars[i] = new Star();
    }
  }
  
  public void showPlayerNameError(){
    playerNameError = true;
  }
  
  public void hidePlayerNameError(){
    playerNameError = false;
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
    
    if(playerNameError){
      pushMatrix();
        fill(250, 0, 160);
        textFont(cf1);
        textAlign(CENTER);
        text("Spielername muss zwischen 3 und 8 Zeichen lang sein.", width/2,height/4 + 360 );
      popMatrix();
    }
    
  }
  
  
  public void setStarSpeed(float newSpeed){
  for( int i = 0; i < stars.length; i++ ){
      stars[i].setSpeed(newSpeed);
    }
  }
 
}
