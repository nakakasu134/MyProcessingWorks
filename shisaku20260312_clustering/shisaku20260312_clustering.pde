import processing.sound.*;

Space space;
VoronoiSpace p;

void setup(){
  size(1440,1440,P2D);
  pixelDensity(1);
  noStroke();
  color[]types={
    #ff0000,
    #ffff00,
    #00ff00,
    #00ffff,
    #0080ff,
    #8000ff,
    #ff00ff
  };
  
  space=new Space(types,64,new SinOsc(this));
}

void draw(){
  background(255);
  space.update();
}

void keyPressed(){
  if(key=='p'){
    space.switchRunning();
  }
}
