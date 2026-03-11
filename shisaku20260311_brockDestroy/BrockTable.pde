class BrockTable {
  int h;
  int w;

  int[] table;
  int[] original;
  color[] parret;
  SoundFile[] se;
  int nextPlay;

  int[] largestBrock;
  int destroyed;

  BrockTable(int _h, int _w, color[] p,SoundFile[] _se) {
    h=_h;
    w=_w;
    parret=p;
    se=_se;
    table=new int[h*w];
    original=new int[h*w];
    for (int i=0; i<h*w; i++) {
      original[i]=floor(random(1, p.length));
      table[i]=original[i];
    }
    getLargestBrock();
  }

  void update() {
    show();
    if (largestBrock.length==0) {
      reset();
    } else if (destroyed<largestBrock.length) {
      destroy();
    } else {
      fall();
    }
  }

  void reset() {
    nextPlay=0;
    for(int i=0; i<destroyed+1; i++){
      for(int j=0; j<w; j++){
        table[i*w+j]=original[(i+h-destroyed-1)*w+j];
      }
    }
    destroyed++;
    if(destroyed==h){
      getLargestBrock();
    }
  }

  void fall() {
    boolean endFall=true;
    nextPlay=0;
    for (int j=0; j<w; j++) {
      boolean hasHole=false;
      for (int i=h-1; i>0; i--) {
        if (table[i*w+j]==0) {
          hasHole=true;
        }
        if (hasHole) {
          table[i*w+j]=table[(i-1)*w+j];
          if (table[i*w+j]!=0)endFall=false;
        }
      }
      if (hasHole) {
        table[j]=0;
      }
    }
    if (endFall) {
      getLargestBrock();
      if (largestBrock.length>0) {
        destroy();
      }else{
        reset();
      }
    }
  }

  void destroy() {
    nextPlay=table[largestBrock[destroyed]];
    table[largestBrock[destroyed]]=0;
    destroyed++;
  }

  void getLargestBrock() {
    int[]table_copy=new int[h*w];
    for (int i=0; i<h*w; i++) {
      table_copy[i]=table[i];
    }
    largestBrock=new int[0];
    for (int i=0; i<h*w; i++) {
      if (table_copy[i]==0)continue;
      int[]brock=new int[h*w];
      brock[0]=i;
      int type=table[i];
      table_copy[i]=0;
      int brock_count=1;
      int search_count=0;
      while (brock_count>search_count) {
        int index=brock[search_count];
        search_count++;
        if (index>=w) {
          if (table_copy[index-w]==type) {
            brock[brock_count]=index-w;
            table_copy[index-w]=0;
            brock_count++;
          }
        }
        if (index%w>0) {
          if (table_copy[index-1]==type) {
            brock[brock_count]=index-1;
            table_copy[index-1]=0;
            brock_count++;
          }
        }
        if (index<(h-1)*w) {
          if (table_copy[index+w]==type) {
            brock[brock_count]=index+w;
            table_copy[index+w]=0;
            brock_count++;
          }
        }
        if (index%w<w-1) {
          if (table_copy[index+1]==type) {
            brock[brock_count]=index+1;
            table_copy[index+1]=0;
            brock_count++;
          }
        }
      }
      if (largestBrock.length<=brock_count) {
        largestBrock=new int[brock_count];
        for (int j=0; j<brock_count; j++) {
          largestBrock[j]=brock[j];
        }
      }
    }
    destroyed=0;
  }

  void show() {
    se[nextPlay].play();
    float brock_h=1f*height/h;
    float brock_w=1f*width/w;
    for (int i=0; i<h; i++) {
      float y=brock_h*i;
      for (int j=0; j<w; j++) {
        float x=brock_w*j;
        fill(parret[table[i*w+j]]);
        rect(x, y, brock_w, brock_h);
      }
    }
  }
}
