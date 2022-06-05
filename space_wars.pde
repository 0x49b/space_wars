import processing.sound.*;
import controlP5.*;

boolean DEBUG = false;

boolean startSoundPlaying = false;
boolean gameOver = false;
Screens currentScreen = Screens.START;

// All Screens
StartScreen startScreen;
GameScreen gameScreen;
AboutScreen aboutScreen;
FinishedScreen finishedScreen;

// Stats for FinishedScreen
Stats stats;

// Fonts
PFont titleFont;
PFont cf1;

ControlP5 cp5;

String playerName;
boolean sound = true;

void setup() {  
  surface.setTitle("Space Wars");
  
  // only one can be used
  size(1200, 675, P3D);
  // fullScreen(P3D);
  
  // initialize Fonts
  titleFont = createFont("mandalore.otf", 200);
  cf1 = createFont("opensans.ttf",14);
  
  cp5 = new ControlP5(this);
  
  // initialize all Screens needed
  startScreen = new StartScreen(this);
  gameScreen = new GameScreen(this);
  aboutScreen = new AboutScreen(this);
  finishedScreen = new FinishedScreen(this);
  
  // intialize stats
  stats = new Stats();
  
}

void draw() {
  
  if(!gameOver){
    if( currentScreen == Screens.GAME ){
      displayGameScreen();
    } else if(currentScreen == Screens.ABOUT ){
      displayAboutScreen();
    } else {
      displayStartScreen();
    }
  } else {
    currentScreen = Screens.FINISHED;
    displayFinishScreen();
  }
 
}


void stopStartScreenSound(){
    if(startSoundPlaying){
      startScreen.startsound.amp(0.0);
      startScreen.startsound.stop();
      startSoundPlaying = false;
    }
}

void startStartScreenSound(){
  if(sound){
  if(!startSoundPlaying){
    startScreen.startsound.amp(1.0);
      startScreen.startsound.loop();
      startSoundPlaying = true;
    }
  } else {
    stopStartScreenSound();
  }
}

void displayStartScreen(){
  stats.resetStats();
  startStartScreenSound();
  aboutScreen.hideControls();
  startScreen.draw();
}

void displayGameScreen(){
   stopStartScreenSound();
   gameScreen.draw(); 
}

void displayFinishScreen(){
  startStartScreenSound();
  finishedScreen.draw();
}

void displayAboutScreen(){
  stopStartScreenSound();
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
      case 32:
        gameScreen.spaceship.shoot();
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
        
    gameScreen.checkGodmode(key);
  }
}

void mouseWheel(MouseEvent event){
  
 
  float current = startScreen.getStarSpeed();
  
    float newCurrent = 0;
    if(event.getCount() > 0){
      if(current < 100) { newCurrent = current + 5;}else {newCurrent = current;}
    }
    else {
      if(current > 2) { newCurrent = current - 5;} else {newCurrent = current;}
    }
    
    try{
      startScreen.setStarSpeed(newCurrent);
    } catch (NullPointerException e){}
 
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
  gameScreen.lives = 3;
  stats.resetScore();
  startScreen.hidePlayerNameError();
  currentScreen = Screens.GAME;
}


void sound(boolean theFlag) {
  sound = !theFlag;
}

void debug(boolean theFlag) {
  DEBUG = !theFlag;
}



// Go Back to Menu
void menu(){
  gameOver = false;
  gameScreen.hideControls();
  gameScreen.reset();
  aboutScreen.hideControls();
  finishedScreen.hideControls();
  currentScreen = Screens.START;
}

void about(){
  startScreen.hideControls();
  aboutScreen.reset();
  currentScreen = Screens.ABOUT;
}
