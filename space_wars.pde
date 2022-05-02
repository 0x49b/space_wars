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
Screens currentScreen = Screens.START;

// All Screens
StartScreen startScreen;
GameScreen gameScreen;
AboutScreen aboutScreen;

// Fonts
PFont titleFont;

ControlP5 cp5;

String textValue ="";
String playerName;

void setup() {  
  surface.setTitle("Space Wars");
  //surface.setResizable(true);
  size(1200, 675, P3D);
  
  // initialize Fonts
  titleFont = createFont("mandalore.otf", 200);
  
  cp5 = new ControlP5(this);
  
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

void keyPressed(){
  
  if(currentScreen == Screens.GAME){
    switch(keyCode){
      case 65:
      case 37: 
        gameScreen.spaceship.toggleLeft(true);
        break;
      case 68:
      case 39:
        gameScreen.spaceship.toggleRight(true);
        break;
      case 87:
      case 38:
        gameScreen.spaceship.toggleBooster(true);
        break;
     }
  }
}

void mousePressed(){
  if (mousePressed && (mouseButton == LEFT) && currentScreen == Screens.GAME) {
    gameScreen.spaceship.shoot(); 
  }
}

void keyReleased(){
  
  if(currentScreen == Screens.GAME){
    switch(keyCode){
      case 65:
      case 37: 
        gameScreen.spaceship.toggleLeft(false);
        break;
      case 68:
      case 39:
        gameScreen.spaceship.toggleRight(false);
        break;
      case 87:
      case 38:
        gameScreen.spaceship.toggleBooster(false);
        break;
    }
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
  playerName = startScreen.cp5.get(Textfield.class, "textValue").getText();
  if(playerName.length() < 3 || playerName.length() > 8){
     startScreen.showPlayerNameError();
     return;
  }
  startScreen.hidePlayerNameError();
  currentScreen = Screens.GAME;
}

// Go Back to Menu
void menu(){
  gameScreen.hideControls();
  gameScreen.reset();
   
  aboutScreen.hideControls();
  currentScreen = Screens.START;
}

void about(){
  startScreen.hideControls();
  aboutScreen.reset();
  currentScreen = Screens.ABOUT;
}
