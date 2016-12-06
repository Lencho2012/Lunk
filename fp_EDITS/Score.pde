class Score{
  float x,y;
  float points;
  float score;
  float booster_pts=10;
  float save_pts = 15;
  float health_pts=20;
  float shield_pts=5;
  PFont  scoreDisplay= createFont("Inconsolata-Regular.ttf",24);
  PFont  scoreBold = createFont("Inconsolata-Regular.ttf",50);
  
   Score(){
      score=0;
      x=75;
      y=30;
  }
  
  //updating score with new information
  void update(float points){
    score+=points;
  }
  //this is to help move the board with camera
  void updateX(float _x){
    if(_x!=0)
      x=_x-width/2+75;
  }
  
  void display(){
    fill(255, 75);                            //white with 75% opacity
    rect(x, y, 140, 60, 10);
    fill(255);
    textFont(scoreDisplay);
    text("Score",x+10,y+15);
    textFont(scoreBold);
    text(int(score),x+80,y+5);
  } 
}