class Pivot{
  Element pos;
  float px;
  float py;
  float nx;
  float ny;
  color type;
  
  float distance(Element e){
    return pos.distance(e);
  }
  
  Pivot(float x,float y,int id,color _type,int listLength){
    pos=new Element(x,y,id);
    px=nx=x;
    py=ny=y;
    type=_type;
  }
  
  void updatePos(float lerp){
    if(lerp>=1){
      px=nx;
      py=ny;
    }
    pos.x=px+(nx-px)*lerp;
    pos.y=py+(ny-py)*lerp;
  }
  
  void setPos(float x,float y){
    nx=0; ny=0;
  }
  
  void addPos(Element e){
    addPos(e.x,e.y);
  }
  
  void addPos(float x,float y){
    nx+=x; ny+=y;
  }
  
  void divPos(float v){
    nx/=v; ny/=v;
  }
  
  void show(float r){
    pos.show(r,type);
  }
  
  void drawEdge(Element e,float wid){
    strokeWeight(wid);
    stroke(type);
    line(pos.x,pos.y,e.x,e.y);
  }
}
