import processing.sound.*;

import controlP5.*;

boolean DEBUG = true;

/* STEERING */
float mapval;
int val;

//Start is start and end 
PVector startPos, startSize;
//You could of course make more checkpoints mabye with an array or with an own class :)
PVector checkpointPos, checkpointSize;
boolean checkpointCleared = false;

boolean gameStarted = false;
Screens currentScreen = Screens.GAME;

// All Screens
StartScreen startScreen;
GameScreen gameScreen;
AboutScreen aboutScreen;

// Fonts
PFont titleFont;

void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  
  surface.setTitle("Space Wars");
  //surface.setResizable(true);
  size(1200, 675, P3D);
  
  // initialize Fonts
  titleFont = createFont("mandalore.otf", 200);
  
  // initialize all Screens needed
  startScreen = new StartScreen(this);
  gameScreen = new GameScreen(this);
  aboutScreen = new AboutScreen(this);
}

void draw() {
  
  if( currentScreen == Screens.GAME ){
    displayGameScreen();
  } else if(currentScreen == Screens.FINISHED ){
    displayFinishScreen();
  } else if(currentScreen == Screens.ABOUT ){
    displayAboutScreen();
  } else {
    displayStartScreen();
  }
 
}

void displayStartScreen(){
  aboutScreen.hideControls();
  startScreen.draw();
}

void displayGameScreen(){
   gameScreen.draw(); 
}

void displayFinishScreen(){}

void displayAboutScreen(){
  aboutScreen.draw();
}

boolean isInsideRect(PVector p, PVector rp, PVector rs) {
  if (p.x > rp.x - rs.x/2 && p.x < rp.x + rs.x/2 && 
    p.y > rp.y - rs.y/2 && p.y < rp.y + rs.y/2) {
    return true;
  }
  return false;
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    gameScreen.updateSpaceShip(true);
  }
}
void keyReleased() {
  if (key == 'w' || key == 'W') {
    gameScreen.updateSpaceShip(false);
  }
}

void mousePressed(){
  if(currentScreen == Screens.GAME){
    gameScreen.fireSpaceShip();
  }
}


// Control Inputs must be handled here and not in the classes
void speed(float newSpeed) {
  try{
    startScreen.setStarSpeed(newSpeed);
  } catch (NullPointerException e){}
}

// ControlP5 Functions
// Start the game
void startGame(){
  startScreen.hideControls();
  currentScreen = Screens.GAME;
}

// Go Back to Menu
void menu(){
  gameScreen.hideControls();
  gameScreen.setGameRunning(false);
  
  aboutScreen.hideControls();
  currentScreen = Screens.START;
}

void about(){
  startScreen.hideControls();
  aboutScreen.reset();
  currentScreen = Screens.ABOUT;
}
