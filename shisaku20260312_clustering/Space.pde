class Space {
  Pivot[] pivots;
  Element[]elements;
  int[]elements_count;

  int count;
  int lap;
  boolean clustered;
  color black=#333333;
  SinOsc sound;
  
  boolean isRunning;

  Space(color[]types, int cLength,SinOsc _sound) {
    int pLength=types.length;
    pivots=new Pivot[pLength];
    elements=new Element[cLength];
    elements_count=new int[pLength];
    sound=_sound;
    count=0;
    clustered=true;
    isRunning=false;
    lap=millis();
    for (int i=0; i<pLength; i++) {
      pivots[i]=new Pivot(random(0, width), random(0, height), i, types[i], cLength);
    }
    VoronoiSpace voronoi=new VoronoiSpace(cLength, 3);
    for (int i=0; i<cLength; i++) {
      elements[i]=new Element(voronoi.x[i], voronoi.y[i], 0);
    }
    cluster();
  }
  
  void switchRunning(){
    isRunning=!isRunning;
    lap=millis();
    if(isRunning){
      sound.play();
    }else{
      sound.stop();
    }
  }

  void update() {
    show(60, 40, 10);
    if(!isRunning)return;
    if(clustered)onClustering(50);
    else onClustered(500);
    setSound(350,1.1);
  }
  
  void onClustering(int time){
    int nMillis=millis();
    if(nMillis-lap<time)return;
    lap+=time;
    count++;
    if(count<=elements.length)return;
    sound.stop();
    lap=nMillis;
    clustered=false;
    correction();
  }
  
  void onClustered(int time){
    int nMillis=millis();
    float t=(nMillis-lap)*1f/time;
    for(Pivot p : pivots){
      p.updatePos(t);
    }
    if(t<1)return;
    sound.play();
    count=0;
    lap=nMillis;
    clustered=true;
    cluster();
  }

  void cluster() {
    for (Element element : elements) {
      float d_m=pivots[0].distance(element);
      element.id=0;
      for (int i=1; i<pivots.length; i++) {
        float d=pivots[i].distance(element);
        if (d_m<d)continue;
        d_m=d;
        element.id=i;
      }
    }
  }

  void correction() {
    int p_length=pivots.length;
    int[]e_count=new int[p_length];
    for (int i=0; i<p_length; i++) {
      pivots[i].setPos(0, 0);
    }
    for (Element e : elements) {
      int i=e.id;
      pivots[i].addPos(e);
      e_count[i]++;
    }
    boolean correct=false;
    for (int i=0; i<p_length; i++) {
      int ec_i=e_count[i];
      if (ec_i==0)continue;
      pivots[i].divPos(ec_i);
      if (elements_count[i]==ec_i)continue;
      correct=true;
      elements_count[i]=ec_i;
    }
    if (!correct){
      sound.stop();
      noLoop();
    }
  }
  
  void setSound(float def,float mult){
    if(count>=elements.length){
      return;
    }
    int i=elements[count].id;
    sound.freq(def*pow(mult,i));
  }

  void show(float pr, float cr, float wid) {
    noStroke();
    for (int i=0; i<elements.length; i++) {
      Element e=elements[i];
      color c=black;
      if (i<=count) {
        Pivot p=pivots[e.id];
        c=p.type;
      }
      e.show(cr, c);
    }
    for (int i=0; i<elements.length; i++) {
      Element e=elements[i];
      if (i<count) {
        Pivot p=pivots[e.id];
        p.drawEdge(e, wid);
      }
    }
    strokeWeight(wid);
    stroke(black);
    for (Pivot p : pivots) {
      p.show(pr);
    }
  }
}
