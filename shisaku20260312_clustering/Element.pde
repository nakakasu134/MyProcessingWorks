class Element{
  float x;
  float y;
  int id;
  
  float distance(Element other){
    float dx=other.x-x;
    float dy=other.y-y;
    return sqrt(dx*dx+dy*dy);
  }
  
  Element(float _x,float _y,int _id){
    x=_x;
    y=_y;
    id=_id;
  }
  
  void show(float r,color fill_color){
    fill(fill_color);
    circle(x,y,r*2);
  }
}
