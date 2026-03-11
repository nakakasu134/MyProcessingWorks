import processing.sound.*;
VisualizedSort instance;

SinOsc sound;

void setup(){
  int len=256;
  Element[] elements=new Element[len];
  for(int i=0; i<len; i++){
    int r=floor(random(0,i+1));
    for(int j=0; j<i-r; j++){
      elements[i-j]=elements[i-j-1];
    }
    elements[r]=new Element(i+1);
  }
  for(int i=0; i<len; i++){
    elements[i].id=i;
  }
  
  size(512,512);
  //frameRate(10);
  noStroke();
  instance=new VisualizedSort(elements,len);
  //Sort(elements);
  background(255);
  instance.Show();
  sound=new SinOsc(this);
}

boolean loop=false;

void draw(){
  if(!loop)return;
  background(255);
  instance.Update();
  instance.SetFreq(sound,440,1);
}

void keyPressed(){
  if(key=='p')Switch();
}

void Switch(){
  loop=!loop;
  if(loop)sound.play();
  else sound.stop();
}
