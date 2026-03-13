class Space {
  Ball[]balls;
  IBoundary boundary;
  int pMillis;
  boolean isRunning;
  
  SinOsc sound;
  int lap;

  float gravity=800;
  float addR=2;
  float rMin=40;
  float rMax=80;
  float vDef=400;
  float nSize=1.5;
  int sLength=300;
  float sDef=340;
  float sMult=2;

  Space(SinOsc s) {
    sound=s;
    float boundR=500;

    balls=new Ball[0];
    boundary=new CircleBoundary(width/2, height/2, boundR);
    pMillis=millis();
    colorMode(HSB, 100);
    for (int i=0; i<1; i++) {
      addBall();
    }
    isRunning=false;
  }

  void addBall() {
    float x=width/2;
    float y=height/2;
    float theta=random(0, 2)*PI;
    float vx=vDef*cos(theta);
    float vy=vDef*sin(theta);
    Ball newBall=new Ball(rMin, x, y, vx, vy);
    float value=random(0,1);
    color c=color(value*120, 120, 100);
    newBall.setColor(c);
    newBall.setType(value);
    
    int len=balls.length;
    Ball[] newBalls=new Ball[len+1];
    for (int i=0; i<len; i++) {
      newBalls[i]=balls[i];
    }
    newBalls[len]=newBall;
    balls=newBalls;
  }

  void update() {
    int nMillis=millis();
    float deltaTime=(nMillis-pMillis)*0.001f;
    move(deltaTime);
    bound();
    show();
    pMillis=nMillis;
  }
  
  void switchRunning(){
    isRunning=!isRunning;
    if(isRunning){
      pMillis=millis();
      lap=pMillis;
    }else{
      sound.stop();
    }
  }
  
  void show(){
    noStroke();
    rectMode(CENTER);
    textAlign(CENTER,CENTER);
    for(Ball b : balls){
      b.show();
      int count=(int)((rMax-b.r)/addR);
      b.showText(str(count),nSize,#ffffff);
    }
    strokeWeight(4);
    stroke(#ffffff);
    noFill();
    boundary.show();
    if(pMillis-lap>=sLength)sound.stop();
  }
  
  void move(float deltaTime){
    if(!isRunning)return;
    for(Ball b : balls){
      b.accel(0,gravity,deltaTime);
      b.move(deltaTime);
    }
  }
  
  void bound(){
    for (int i=0; i<balls.length-1; i++) {
      for (int j=i+1; j<balls.length; j++) {
        balls[i].bound(balls[j]);
      }
    }
    boolean added=false;
    for (Ball b : balls) {
      boundary.bound(b);
      if (b.bounded) {
        b.addRadius(addR);
        b.bounded=false;
        sound.freq(sDef*pow(sMult,b.type));
        sound.play();
        lap=pMillis;
      }
      if (b.r>=rMax) {
        b.r=rMax;
        if (!added) {
          b.r=rMin;
          addBall();
          added=true;
        }
      }
    }
  }
}
