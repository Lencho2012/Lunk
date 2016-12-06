
class animate{
  float speed,c1,c2;        //c1 and c2 are constraints
  float angle =0;
  boolean switched = false;
  PShape limb;
  
  animate(){
    speed=0;
    c1=0;
    c2=0;
  }
  animate(float _speed, float _c1, float _c2, PShape _limb, float start){
   speed =_speed;
   c1 = _c1;
   c2 = _c2;
   angle = start;
   limb = _limb;
   limb.rotateZ(PI);
  }
  
  void update(){
      if(angle >=c2)
        switched = true;
      else if(angle <=c1)
        switched = false;
      if(switched)
        angle -=speed;
      else
        angle+=speed;
  }
  
  void display(){
    pushMatrix();
    rotateX(angle);
    shape(limb, limb.width, limb.height);
    popMatrix();
  } 
}