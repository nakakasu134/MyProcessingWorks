class Ball{
  float r;
  float x,y;
  float vx,vy;
  color c;
  float type;
  
  boolean bounded;
  
  float velocityComponent(float nx,float ny){
    float n=sqrt(nx*nx+ny*ny);
    return (vx*nx+vy*ny)/n;
  }
  
  Ball(float _r,float _x,float _y,float _vx,float _vy){
    r=_r;
    x=_x;
    y=_y;
    vx=_vx;
    vy=_vy;
    c=#808080;
    bounded=false;
  }
  
  void setColor(color _c){
    c=_c;
  }
  
  void setType(float _type){
    type=_type;
  }
  
  void show(){
    fill(c);
    circle(x,y,r*2);
  }
  
  void showText(String t,float s,color tc){
    textSize(r*s);
    fill(tc);
    text(t,x,y);
  }
  
  void move(float deltaTime){
    x+=vx*deltaTime;
    y+=vy*deltaTime;
  }
  
  void accel(float ax,float ay,float deltaTime){
    vx+=ax*deltaTime;
    vy+=ay*deltaTime;
  }
  
  void setPos(float _x,float _y){
    x=_x;
    y=_y;
  }
  
  void setVelocityComponent(float v,float nx,float ny){
    float n2=nx*nx+ny*ny;
    float k=v/sqrt(n2)-(vx*nx+vy*ny)/n2;
    vx+=k*nx;
    vy+=k*ny;
  }
  
  void bound(Ball ball){
    float dx=ball.x-x;
    float dy=ball.y-y;
    float d=sqrt(dx*dx+dy*dy);
    float dr=r+ball.r;
    if(d>dr)return;
    float m1=r*r;
    float m2=ball.r*ball.r;
    float v1=velocityComponent(dx,dy);
    float v2=ball.velocityComponent(dx,dy);
    float v1a=(m1*v1+2*m2*v2-m2*v1)/(m1+m2);
    float v2a=(2*m1*v1+m2*v2-m1*v2)/(m1+m2);
    setVelocityComponent(v1a,dx,dy);
    ball.setVelocityComponent(v2a,dx,dy);
    ball.setPos(x+dr*dx/d,y+dr*dy/d);
    bounded=true;
    ball.bounded=true;
  }
  
  void addRadius(float vr){
    r+=vr;
    float v=sqrt(vx*vx+vy*vy);
    setPos(x+vr*vx/v,y+vr*vy/v);
  }
}
