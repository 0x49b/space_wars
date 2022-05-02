class GameScreen implements Screen{

  ControlP5 cp5;
  
  PImage background;
  PVector backgroundPos;
  
  boolean gameRunning = false;
  
  Spaceship spaceship;
  
  public GameScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    
    cp5.addButton("menu")
     .setPosition(25,25);
    
    cp5.hide();
    
    background = loadImage("stars.jpeg");
    background.resize(1200,675);
    backgroundPos = new PVector(background.width/2, background.height/2);
    spaceship = new Spaceship(width/2, height/2, backgroundPos);

  }
  
  public void hideControls(){
    cp5.hide();
  }
  
  public void draw(){
    background(0);
    cp5.show();
    setGameRunning(true);
    
    pushMatrix();
    translate(backgroundPos.x, backgroundPos.y);
    image(background, 0, 0);
    popMatrix();
    
    spaceship.show();
    spaceship.update();
  
  }
  
  public void updateSpaceShip(boolean move){
    spaceship.setMove(move);
  }
  
  public void fireSpaceShip(){
    spaceship.fire();
  }
  
  public void setGameRunning(boolean state){
    gameRunning = state;
  }
  
}
