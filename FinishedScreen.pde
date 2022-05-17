class FinishedScreen implements Screen{

  ControlP5 cp5;
  
  public FinishedScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu").setPosition(25,25);
    hideControls();
  }
  
  public void hideControls(){
    cp5.hide();
  }
  
  public void draw(){
    
    background(0);
    cp5.show();
    
    fill(#ffe817);
    textAlign(CENTER, CENTER);
    textFont(titleFont);
    text("Gameover", width/2, height/4);
    
    fill(#FFFFFF);
    textFont(cf1);
    text(stats.getStatsDebug(),  width/2, height/4 + 100);
    
    
  }
  
}
