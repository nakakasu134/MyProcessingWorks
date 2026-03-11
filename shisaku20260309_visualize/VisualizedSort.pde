class VisualizedSort {
  Element[] elements;
  int max;
  int[] area;
  int confirmed;
  int bottom;
  int top;
  boolean countTop;

  VisualizedSort(Element[] array, int m) {
    elements=array;
    max=m;
    area=new int[elements.length];
    area[0]=elements.length;
    confirmed=0;
    bottom=0;
    top=elements.length-1;
    countTop=true;
  }
  
  void Update(){
    Show();
    if(bottom>=0)Practice();
  }

  void Show() {
    int h1=height/max;
    int w=width/elements.length;
    for (int i=0; i<elements.length; i++) {
      if(bottom==-1 && i<=confirmed){
        fill(#00ffff);
      } else if(i==top || i==bottom){
        fill(countTop?#ff0000:#0000ff);
      } else fill(#00ff00);
      int h=h1*elements[i].value;
      rect(w*i, height-h, w, h);
    }
  }
  
  void SetFreq(SinOsc s,float def,float mult){
    if(bottom==-1){
      s.freq(def+confirmed*mult);
      confirmed++;
      if(confirmed==elements.length){
        noLoop();
        s.stop();
      }
      return;
    }
    int value=elements[countTop?top:bottom].value;
    s.freq(def+value*mult);
  }

  void Practice() {
    if (elements[bottom].value>elements[top].value) {
      Element temp=elements[bottom];
      elements[bottom]=elements[top];
      elements[top]=temp;
      countTop=!countTop;
    }
    if (countTop)top--;
    else bottom++;
    if (top==bottom) {
      int currentArea=area[confirmed];
      area[confirmed]=bottom-confirmed;
      area[bottom]=1;
      if (bottom+1<confirmed+currentArea)area[bottom+1]=confirmed+currentArea-bottom-1;
      while (area[confirmed]==1) {
        confirmed++;
        if (confirmed==elements.length) {
          bottom=top=-1;
          confirmed=0;
          return;
        }
      }
      bottom=confirmed;
      top=bottom+area[confirmed]-1;
      countTop=!countTop;
    }
  }
}
