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

boolean raceStarted = false;

float raceTime = 0;

void setup() {
  rectMode(CENTER);
  imageMode(CENTER);
 
  surface.setTitle("Space Wars");
  surface.setResizable(true);

  size(1200, 675, P3D);

  background = loadImage("stars.jpeg");
  background.resize(1200,675);
  
  spaceship = new Spaceship(width/2, height/2);
  backgroundPos = new PVector(background.width/2, background.height/2);
}
void draw() {
  
  background(0);

  pushMatrix();
  translate(backgroundPos.x, backgroundPos.y);
  image(background, 0, 0);
  popMatrix();

  spaceship.show();
  spaceship.update();
}

void updateStart() {
  if (isInsideRect(spaceship.pos, startPos, startSize)) {
    if (raceStarted == false && checkpointCleared == false) {
      raceStarted = true;
      println("Race Started");
    } else if (checkpointCleared == true) {
      //If raceStarted then test if the checkpoint is clear 
      raceStarted = false;
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
