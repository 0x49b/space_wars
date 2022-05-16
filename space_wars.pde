import processing.sound.*;
import controlP5.*;

boolean DEBUG = true;

boolean gameOver = false;
boolean startSoundPlaying = false;
Screens currentScreen = Screens.START;

// All Screens
StartScreen startScreen;
GameScreen gameScreen;
AboutScreen aboutScreen;
MultiplayerScreen multiplayerScreen;
FinishedScreen finishedScreen;

// Stats for FinishedScreen
Stats stats;

// Fonts
PFont titleFont;

ControlP5 cp5;

String playerName;
boolean sound = true;

void setup() {  
  surface.setTitle("Space Wars");
  //surface.setResizable(true);
  
  // only one can be used
  size(1200, 675, P3D);
  // fullScreen(P3D);
  
  // initialize Fonts
  titleFont = createFont("mandalore.otf", 200);
  
  cp5 = new ControlP5(this);
  
  // initialize all Screens needed
  startScreen = new StartScreen(this);
  gameScreen = new GameScreen(this);
  aboutScreen = new AboutScreen(this);
  multiplayerScreen = new MultiplayerScreen(this);
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
    } else if(currentScreen == Screens.MULTIPLAYER ){
      displayMultiplayerScreen();
    }else {
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

void displayMultiplayerScreen(){
  stopStartScreenSound();
  multiplayerScreen.draw();
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
  gameScreen.lives = 3;
  stats.resetScore();
  startScreen.hidePlayerNameError();
  currentScreen = Screens.GAME;
}


void multiplayer(){
  startScreen.hideControls();
  playerName = startScreen.cp5.get(Textfield.class, "textValue").getText();
  if(playerName.length() < 3 || playerName.length() > 8){
     startScreen.showPlayerNameError();
     return;
  }
  startScreen.hidePlayerNameError();
  multiplayerScreen.connectClient();
  currentScreen = Screens.MULTIPLAYER;
}

void sound(boolean theFlag) {
  sound = !theFlag;
}


// Go Back to Menu
void menu(){
  gameOver = false;
  gameScreen.hideControls();
  gameScreen.reset();
  aboutScreen.hideControls();
  finishedScreen.hideControls();
  try{
    multiplayerScreen.hideControls();
    multiplayerScreen.disconnectClient();
  } catch (Exception e){}

  currentScreen = Screens.START;
}

void about(){
  startScreen.hideControls();
  aboutScreen.reset();
  currentScreen = Screens.ABOUT;
}


// MQTT Callbacks
void clientConnected() {
  println("client connected");
}

void connectionLost() {
  println("connection lost");
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}
