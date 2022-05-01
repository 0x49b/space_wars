import controlP5.*;

PImage background;
PVector backgroundPos;

Spaceship spaceship;

/* STEERING */
float mapval;
int val;

//Start is start and end 
PVector startPos, startSize;
//You could of course make more checkpoints mabye with an array or with an own class :)
PVector checkpointPos, checkpointSize;
boolean checkpointCleared = false;

boolean gameStarted = false;
int currentScreen = 0;

// All Screens
StartScreen startScreen;

// Fonts
PFont titleFont;


// Controls
ControlP5 cp5;


void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
  
  // initialize Fonts
  titleFont = createFont("mandalore.otf", 128);
  
  // initialize Controls --> Change to init in class like in github repo https://github.com/sojamo/controlp5
  cp5 = new ControlP5(this);
  
   cp5.addSlider("speed")
     .setPosition(25,25)
     .setSize(100,10)
     .setRange(0.5,100)
     .setValue(0.5);
     
      cp5.getController("speed").getValueLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      cp5.getController("speed").getCaptionLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
      
  
  // initialize all Screens needed
  startScreen = new StartScreen();
 
  surface.setTitle("Space Wars");
  surface.setResizable(true);

  size(1200, 675, P3D);

  background = loadImage("stars.jpeg");
  background.resize(1200,675);
  
  spaceship = new Spaceship(width/2, height/2);
  backgroundPos = new PVector(background.width/2, background.height/2);
}

void draw() {
  
  if( currentScreen == 1 ){
    displayGameScreen();
  } else if(currentScreen == 2 ){
    displayFinishScreen();
  } else if(currentScreen == 3 ){
    displayAboutScreen();
  } else {
    displayStartScreen();
  }
 
}

void displayStartScreen(){
  startScreen.draw();
}

void displayGameScreen(){
  background(0);

  pushMatrix();
  translate(backgroundPos.x, backgroundPos.y);
  image(background, 0, 0);
  popMatrix();

  spaceship.show();
  spaceship.update();
}

void displayFinishScreen(){}

void displayAboutScreen(){}


void updateStart() {
  if (isInsideRect(spaceship.pos, startPos, startSize)) {
    if (gameStarted == false && checkpointCleared == false) {
      gameStarted = true;
      println("Race Started");
    } else if (checkpointCleared == true) {
      //If raceStarted then test if the checkpoint is clear 
      gameStarted = false;
      println("Race finished");
    }
  }
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
    spaceship.setMove(true);
  }
}
void keyReleased() {
  if (key == 'w' || key == 'W') {
  spaceship.setMove(false);
  }
}

void moveBackground(PVector vel) {
  vel.x = -vel.x;
  vel.y = -vel.y;
  backgroundPos.add(vel);
}

// Control INputs must be handled here and not in the classes
void speed(float newSpeed) {
  try{
    startScreen.setStarSpeed(newSpeed);
  } catch (NullPointerException e){}
}
