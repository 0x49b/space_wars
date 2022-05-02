class AboutScreen implements Screen{
  
  ControlP5 cp5;
  PFont scroller;
  String scrollerFont;
  String txt;
  
  float y;
  float z;


  public AboutScreen(PApplet cp5Applet){
    cp5 = new ControlP5(cp5Applet);
    cp5.addButton("menu")
     .setPosition(25,25);
     
    hideControls();
    
    z = 500;
    scrollerFont = "mandalore_hollow.otf";
    scroller = createFont(scrollerFont, 128);
    
    String[] lines = loadStrings("scroller.txt");
    txt = join(lines, "\n");
    y = height/2;
  
  }
  
  public void hideControls(){
    cp5.hide();
  }

  public void draw(){
    background(0);
    cp5.show();
    
    
    z = z+1;
   
    float r = map(z, 0, width/2, 20, 0);
    
    fill(#ffe817);
    textAlign(CENTER, CENTER);
    
    if(r>0){
      pushMatrix();
      scroller = createFont(scrollerFont, r*100);
      textFont(scroller);
      text("Space", width/2, height/2);
      text("Wars", width/2, height/2 + r*100 - 20);
      popMatrix();
    } 
    
    if( r < -5){
      
 
      pushMatrix();
      
      //translate(width/2, height/2);

      fill(238, 213, 75);
      
      textSize(width*0.04);
      textAlign(LEFT);
      
      //rotateX(PI/4);
      float w = -width*0.6;
      text(txt, -w/2, y, w, height*10);
    
      y-=2;
      
      popMatrix();
      
      
    }
    
    
 
  }

}
