class CircleBoundary implements IBoundary{
  float x;
  float y;
  float r;
  
  CircleBoundary(float _x,float _y,float _r){
    x=_x;
    y=_y;
    r=_r;
  }
  
  void bound(Ball ball){
    float dx=ball.x-x;
    float dy=ball.y-y;
    float d=sqrt(dx*dx+dy*dy);
    float dr=r-ball.r;
    if(d<dr)return;
    float vc=ball.velocityComponent(dx,dy);
    ball.setVelocityComponent(vc,-dx,-dy);
    ball.setPos(x+dr*dx/d,y+dr*dy/d);
    ball.bounded=true;
  }
  
  void show(){
    circle(x,y,r*2);
  }
}
