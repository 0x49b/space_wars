class GameScreen implements Screen{
  ControlP5 cp5;
  Spaceship spaceship;
  GSBackground gsBackground;
   
  public GameScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu").setPosition(25,25);
    cp5.hide();
    gsBackground = new GSBackground();
    spaceship = new Spaceship(cp5Applet);
  }
 
  public void draw(){
    background(0);
    cp5.show();
    gsBackground.draw();
    spaceship.show();
    spaceship.update();
  }
  
  public void fireSpaceShip(){
    spaceship.shoot();
  }
  
  public void hideControls(){
    cp5.hide();
  }
  
}
