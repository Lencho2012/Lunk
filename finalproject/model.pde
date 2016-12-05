
class model {
  PShape PSlleg = loadShape("objects/lleg.obj");
  PShape PSrleg = loadShape("objects/rleg.obj");
  PShape PSlarm = loadShape("objects/larm.obj");
  PShape PSrarm = loadShape("objects/rarm.obj");
  PShape head = loadShape("objects/head.obj");
  PShape torso = loadShape("objects/torso.obj");
  PShape bottom = loadShape("objects/bottom.obj");
  animate larm;
  animate rarm;
  animate lleg;
  animate rleg;

  int char_x, char_z;          //location
  float char_y;               //char_ground
  float char_jump=-30;        //initial velocity
  boolean didjump;           //keeping track of jumps
  float step=10;             //amount each step takes
  float vY;                  //y velocity
  float gravity=1;           //for jump
  float ground=700;          //ground plane
  float direction;           //turn direction of model if a new key is pressed

  //default constructor
  model() {
    char_x=0;
    char_z=0;
    char_y=ground;
    didjump=false;
    vY=0;
    direction=0;
    rarm = new animate(.03, radians(-65), radians(60), PSrarm,radians(-45));
    larm = new animate(.03, radians(-60), radians(60), PSlarm,radians(45));
    lleg = new animate(.04, radians(-45), radians(45), PSlleg,radians(-30));
    rleg = new animate(.04, radians(-45), radians(45), PSrleg,radians(30));
    fixModel();
  }

  //constructor to set your character in any location.
  //could possibly be used to setup checkpoints in the game
  model(int x_loc, int z_loc) {
    char_x=x_loc;
    char_z=z_loc;
    char_y=ground;
    didjump=false;
    vY=0;
    direction=0;
    rarm = new animate(.05, radians(-45), radians(45), PSrarm,radians(-45));
    larm = new animate(.05, radians(-45), radians(45), PSlarm,radians(45));
    lleg = new animate(.05, radians(-20), radians(20), PSlleg,radians(30));
    rleg = new animate(.05, radians(-20), radians(20), PSrleg,radians(-30));
    fixModel();
  }

  void fixModel() {
    head.rotateZ(PI);
    head.translate(0, 310);
    torso.rotateZ(PI);
    torso.translate(0, 160);
    bottom.rotateZ(PI);
    bottom.translate(0, 180);
  }

  void getXZ(boolean [] keys) {
    int x=0;
    int z=0;
    if (keys[0]==true)
      z+=-1;
    if (keys[1]==true)
      z+=1;
    if (keys[2]==true)
      x+=1;
    if (keys[3]==true)
      x+=-1;
    updateZ(z);
    updateX(x);
    if (keys[0] == true || keys[1] == true || keys[2] ==true || keys[3]==true) {
      larm.update();
      rarm.update();
      lleg.update();
      rleg.update();
    }
  }
  void updateX(int x) {
    char_x+=x*step;
    if (x==1)
      direction=PI/2;
    else if (x==-1)
      direction=3*PI/2;
  }
  void updateZ(int z) {
    char_z+=z*step;
    if (z==1)
      direction=0;
    else if (z==-1)
      direction=PI;
  }

  void updateY(boolean jumped) {
    if (jumped && didjump==false) {
      vY=char_jump;
      didjump=true;
    }
    if (didjump) {
      vY+=gravity;
      char_y+=vY;
    }
    if (char_y>=ground) {
      didjump=false;
      vY=0;
      char_y=ground;
    }
  }

  void displayChar() {
    translate(char_x, char_y, char_z);
    pushMatrix();
    rotateY(direction);
    displayModel();
    popMatrix();
  }

  void displayModel() {
    shape(head, head.width, head.height); 
    shape(torso, torso.width, torso.height); 
    shape(bottom, bottom.width, bottom.height);
    animatedLimbs();
  }
  void animatedLimbs() {
    pushMatrix();
    translate(0, -140);
    pushMatrix();
    translate(-40, 0);
    lleg.display();
    popMatrix();
    pushMatrix();
    translate(40, 0);
    rleg.display();
    popMatrix();
    popMatrix();
    pushMatrix();
    translate(0, -290);
    pushMatrix();
    translate(45, 0);
    rarm.display();
    popMatrix();
    pushMatrix();
    translate(-45, 0);
    larm.display();
    popMatrix();
    popMatrix();
  }
  float getX() {
    return char_x;
  }

  float getY() {
    return char_y;
  }

  float getZ() {
    return char_z;
  }
}