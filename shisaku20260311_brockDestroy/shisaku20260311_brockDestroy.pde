import processing.sound.*;

int h=16,w=9;

color[]parret={
  #ffffff,
  #ff0000,
  #ffff00,
  #00ff00
};

SoundFile[] se;

BrockTable table;

void setup(){
  size(540,960);
  frameRate(10);
  noStroke();
  se=new SoundFile[4];
  se[0]=new SoundFile(this,"fall.wav");
  se[1]=new SoundFile(this,"se1.wav");
  se[2]=new SoundFile(this,"se2.wav");
  se[3]=new SoundFile(this,"se3.wav");
  table=new BrockTable(h,w,parret,se);
  noLoop();
}

void draw(){
  table.update();
}

void keyPressed(){
  if(key=='p'){
    loop();
  }
}
