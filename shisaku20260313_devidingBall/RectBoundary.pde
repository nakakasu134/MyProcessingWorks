class RectBoundary implements IBoundary{
  float x;
  float y;
  float w;
  float h;
  
  RectBoundary(float _x,float _y,float _w,float _h){
    x=_x;
    y=_y;
    w=_w;
    h=_h;
  }
  
  void bound(Ball ball){
    leftBound(ball);
    rightBound(ball);
    upBound(ball);
    downBound(ball);
  }
  
  void leftBound(Ball ball){
    float boundary=x-w/2;
    float d=ball.x-ball.r;
    if(boundary<d)return;
    float vc=ball.vx;
    ball.setVelocityComponent(-vc,1,0);
    ball.setPos(boundary+ball.r,ball.y);
    ball.bounded=true;
  }
  
  void rightBound(Ball ball){
    float boundary=x+w/2;
    float d=ball.x+ball.r;
    if(boundary>d)return;
    float vc=ball.vx;
    ball.setVelocityComponent(-vc,1,0);
    ball.setPos(boundary-ball.r,ball.y);
    ball.bounded=true;
  }
  
  void upBound(Ball ball){
    float boundary=y-h/2;
    float d=ball.y-ball.r;
    if(boundary<d)return;
    float vc=ball.vy;
    ball.setVelocityComponent(-vc,0,1);
    ball.setPos(ball.x,boundary+ball.r);
    ball.bounded=true;
  }
  
  void downBound(Ball ball){
    float boundary=y+h/2;
    float d=ball.y+ball.r;
    if(boundary>d)return;
    float vc=ball.vy;
    ball.setVelocityComponent(-vc,0,1);
    ball.setPos(ball.x,boundary-ball.r);
    ball.bounded=true;
  }
  
  void show(){
    rectMode(CENTER);
    rect(x,y,w,h);
  }
}
