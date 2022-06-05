class FinishedScreen implements Screen{

  ControlP5 cp5;
  PFont finishFont;
  
  public FinishedScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu").setPosition(25,25);
    hideControls();
    finishFont = createFont("opensans.ttf",18);
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
    text("Punkte: " + stats.getScore()                       ,  width/2, height/4 + 120);
    text("Herzen gesammelt: " + stats.getHeartsCollected()   ,  width/2, height/4 + 140);
    text("Schilde gesammelt: " + stats.getShieldsCollected() ,  width/2, height/4 + 160);
    text("Schüsse: " + stats.getShotsFired()                 ,  width/2, height/4 + 180);
    text("Asteroiden getroffen: " + stats.getAsteroidsHit()  ,  width/2, height/4 + 200);
    
    
  }
  
}
