import processing.sound.*;

Space space;
SinOsc sound;

void settings(){
  size(1080,1440,P2D);
  pixelDensity(1);
}

void setup(){
  sound=new SinOsc(this);
  space=new Space(sound);
  frameRate(30);
}

void draw(){
  background(#000000);
  space.update();
}

void keyPressed(){
  if(key=='p'){
    space.switchRunning();
  }
}
