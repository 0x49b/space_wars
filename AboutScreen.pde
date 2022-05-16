class AboutScreen implements Screen{
  
  ControlP5 cp5;
  PFont scroller;
  PFont introFont;
  PFont textFont;
  
  String scrollerFont;
  String txt;
  String introText = "Es war einmal vor langer Zeit in einer weit,\nweit entfernten Galaxis....";
  
  float y;
  float z;
  float size;
  float alpha;
  float scrollSpeed = .3;
  
  int framecount;
 
  int introFrames = 150;
  int titleFrames = 130;
  int textFrames = 2500;
  int transitionFrames = 40;
  

  public AboutScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
     
    hideControls();
    
    scrollerFont = "mandalore_hollow.otf";
    scroller = createFont(scrollerFont, 128);
    
    introFont = createFont("opensans.ttf", 25);
    textFont = createFont("opensans.ttf", 18);
    
    reset();
  }
  
  public void reset(){
    framecount = 0;
    z = 500;
    size = 0.0;
    alpha = 0.0;
    y = height/2;
    
    String[] lines = loadStrings("scroller.txt");
    txt = join(lines, "\n");
  }
 
 
  public void hideControls(){
    cp5.hide();
  }
  
  private void introText(){
    pushMatrix();
    fill(75,213,238);
    textFont(introFont);
    textAlign(LEFT,CENTER);
    rectMode(CENTER);
    text(introText, width/2-250, height/2);
    popMatrix();
  }
  
  private void titleScroller(){
    z = z+1;
    float r = map(z, 0, width/2, 20, 0);
    
    if(r > 0){
      fill(#ffe817);
      textAlign(CENTER, CENTER);
      pushMatrix();
      scroller = createFont(scrollerFont, r*100);
      textFont(scroller);
      text("Space", width/2, height/2);
      text("Wars", width/2, height/2 + r*100 - 20);
      popMatrix();
    }
  }
  
  private void textScroller(){
    pushMatrix();    
    
      translate(width/4, height/2);
      rotateX(PI/4);
      textAlign(LEFT);
      fill(#ffe817);
      textFont(textFont);
      float w = -width*0.6;
      text(txt, -w/2, y*2, w, height);
      y-=scrollSpeed;
      
    popMatrix();
  }
  
  public void transition(){
    size += 95;
    alpha += 255/40;
    noStroke();
    fill(color(alpha));
    ellipseMode(CENTER);
    ellipse(width,height, size, size);
  }

  public void draw(){
    
    background(0);
    cp5.show();
    
    framecount++;
    if(framecount >= (introFrames + titleFrames + textFrames + transitionFrames)){
      currentScreen = Screens.START;
    } else if(framecount >= (introFrames + titleFrames + textFrames)){
      transition();
    } else if(framecount >= (introFrames + titleFrames )){
      textScroller();
    } else if(framecount >= (introFrames)){
      titleScroller();
    } else {
      introText();
    }
  }

}
