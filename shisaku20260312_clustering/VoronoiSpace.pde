class VoronoiSpace {
  float[]x, y;

  VoronoiSpace(int n,int c_count) {
    x=new float[n];
    y=new float[n];
    for (int i=0; i<n; i++) {
      x[i]=random(0, width);
      y[i]=random(0, height);
    }
    for(int i=0; i<c_count; i++){
      correction();
    }
  }
  
  void show(){
    for(int i=0; i<x.length; i++){
      point(x[i],y[i]);
    }
  }

  void correction() {
    int n=x.length;
    float[]nx=new float[n];
    float[]ny=new float[n];
    for (int i=0; i<n; i++) {
      float[]vx={-width*0.5f, width*0.5f, width*0.5f, -width*0.5f};
      float[]vy={-height*0.5f, -height*0.5f, height*0.5f, height*0.5f};
      for (int j=0; j<n; j++) {
        if (i==j)continue;
        float dx0=x[j]-x[i];
        float dy0=y[j]-y[i];
        float dx1=dx0+(dx0<0?0:0-width);
        float dy1=dy0+(dy0<0?0:0-height);
        float dx2=dx1+width;
        float dy2=dy1+height;
        float[]dx={dx1, dx2, dx2, dx1};
        float[]dy={dy1, dy1, dy2, dy2};
        for (int k=0; k<4; k++) {
          float a=dx[k];
          float b=dy[k];
          float c=(a*a+b*b)*0.5f;
          float[]nvx={};
          float[]nvy={};
          int len=vx.length;
          for (int l=0; l<len; l++) {
            float vx0=vx[l];
            float vy0=vy[l];
            float vx1=vx[(l+1)%len];
            float vy1=vy[(l+1)%len];
            float f0=a*vx0+b*vy0-c;
            float f1=a*vx1+b*vy1-c;
            if (f0<=0) {
              nvx=append(nvx, vx0);
              nvy=append(nvy, vy0);
            }
            if (f0*f1<0) {
              nvx=append(nvx, (f1*vx0-f0*vx1)/(f1-f0));
              nvy=append(nvy, (f1*vy0-f0*vy1)/(f1-f0));
            }
          }
          vx=nvx;
          vy=nvy;
        }
      }
      nx[i]=0;
      ny[i]=0;
      float s=0;
      int len=vx.length;
      for (int l=0; l<len; l++) {
        float vx0=vx[l];
        float vy0=vy[l];
        float vx1=vx[(l+1)%len];
        float vy1=vy[(l+1)%len];
        float area=vx0*vy1-vx1*vy0;
        nx[i]+=(vx0+vx1)*area;
        ny[i]+=(vy0+vy1)*area;
        s+=area;
      }
      nx[i]/=s*3;
      ny[i]/=s*3;
      nx[i]+=x[i];
      ny[i]+=y[i];
      while(nx[i]<0)nx[i]+=width;
      while(nx[i]>=width)nx[i]-=width;
      while(ny[i]<0)ny[i]+=height;
      while(ny[i]>=height)ny[i]-=height;
    }
    x=nx;
    y=ny;
  }
}
