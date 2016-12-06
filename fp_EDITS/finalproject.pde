int state = 0;
final int MAIN_MENU = 0;
final int INSTRUCTIONS = 1;
final int GAME1 = 2;
final int SELECT = 3;
final int INTRO = 4;
final int SELECT1 = 5;
final int SELECT2 = 6;
final int SELECT3 = 7;
final int GAME2 = 8;
final int GAME3 = 9;

Health bar;
Score score;
float healthCounter=0;
PImage menu;
PImage instruct;
PImage spacebar;
import ddf.minim.*;
Minim minim;
AudioPlayer song;


model player;
model player2;
model player3;
boolean[] keys = new boolean[]{false, false, false, false, false, false};
//for room1
PImage floor1;
PImage wall1;
PImage ceiling;
PImage endwall;
//for room2
PImage floor2;
PImage wall2;
PImage ceiling2;
PImage endwall2;
//for room3
PImage floor3;
PImage wall3;
PImage ceiling3;
PImage endwall3;

Parser settings;  //Parser object for getting xml file game settings
int health;      
int time;
int dx;
int px;

int timerStart;
int timer;

Parser output;
/*
Dialogue Options

Booleans can be set to true for when you wish to display dialogue

Run dialogue(String[] _d) with whichever dialogue array you need for a particular part

Running through array - keyReleased() will update index of array and display next line when releasing 'f'
*/
int i_d = 0;      //index for dialogue arrays
boolean intro;
boolean puzzle1;      
boolean puzzle2;      
boolean puzzle3;

String[] d_intro = {"Lunk: Wh.. where am I?", 
               "B: Lunk, you must find the secret treasure… Only then can you escape this land...",
               "Lunk: Who… who is speaking to me?",
               "B: I am the one who will guide you through this journey...",
               "Lunk: So, like, are you gonna guide me through the tutorial and stuff?",
               "B: No, Sir. Lunk, you should have done that while in the menu screen when you started the game.",
               "Lunk: Game?",
               "B: Alright, look, there are three keys you need in order to access the secret treasure. You can try to get them in any order. But BEWARE! They are each guarded by puzzles that will prove to be the greatest adversaries you have ever faced...",
               "Lunk: How can a puzzle be an adversary?",
               "B: You take damage if you get them wrong. Get it wrong enough… and you DIE!",
               "Lunk: Ouch.",
               "B: Indeed.",
               "Lunk: So, where do I start?",
               "B: I just said you can start anywhere.",
               "Lunk: Oh, yeah. Alright. Hey, maybe along the way you can, like, give more exposition so the player knows what’s really going on and stuff.",
               "B: Stop talking and pick a puzzle. Ugh."};
               
String[] d_puzzle1 = {"B: A new puzzle!"};
                
//Tutorial and dialogue for room 2 ******************************
String[] d_puzzle2 = {"B: It's a maze! A spooky, spooky maze! Press 'm' once you find the key and 'r' to continue to next puzzle"};
boolean p2DONE = false;
                
String[] d_puzzle3 = {"B: A new puzzle!"};


void setup() {
  size(900,700, OPENGL);
  menu = loadImage("menu.png");
  menu.resize(900,700);
  instruct = loadImage("arrowKeys.png");
  spacebar = loadImage("spacebar.png");
  spacebar.resize(450, 70);
  bar = new Health();
  score = new Score();
  player= new model(400, 0);
  player2= new model(400, 0);
  player3= new model(400, 0);
  floor1 = loadImage("textures/floor1.jpg");
  wall1 = loadImage("textures/mossbrick.jpg");
  ceiling = loadImage("textures/ceiling.jpg");
  endwall = loadImage("textures/endwall.jpg");
  floor2 = loadImage("textures/floor2.jpg");
  wall2 = loadImage("textures/wall2.jpg");
  ceiling2 = loadImage("textures/ceiling2.jpg");
  endwall2 = loadImage("textures/endwall2.jpg");
  floor3 = loadImage("textures/floor3.jpg");
  wall3 = loadImage("textures/wall3.jpg");
  ceiling3 = loadImage("textures/ceiling3.jpg");
  endwall3 = loadImage("textures/endwall3.jpg");
  textureMode(NORMAL);
  minim = new Minim(this);
  song = minim.loadFile("dungeon.mp3");
  
  settings = new Parser("settings.xml");
  String[] options = settings.getSettings();  //Options from xml input: health/timelimit/damagex/pointsx
  
  output = new Parser("output.xml");
  
  health = int(options[0]);
  time = int(options[1]) * 60 * 1000;        //in milli seconds
  dx = int(options[2]);
  px = int(options[3]);
  timerStart = minute();
  
}


void draw(){
  timer = timerStart - minute();
  
  switch(state) {
    case MAIN_MENU:
      menu();
      song.play();
      break;
    
    case INSTRUCTIONS:
      background(0);
      howto();
      break;
      
    case INTRO:
      background(0);
      noStroke();
      intro = true;
      dialogue(d_intro);
      break;
    
      
    case GAME1:
      song.close();
      healthCounter = 0;
      bar.display();
      score.display();
      background(0, 0,0);
      camera(player.getX(), player.getY()-300, player.getZ()+600, player.getX(),height/2, -8000 ,0,1,0);
      room1();
      lights();
      puzzle1 = true;
      dialogue(d_puzzle1);
      checkKeys();
      break;
      
    case GAME2:
      song.close();
      healthCounter = 0;
      bar.display();
      score.display();
      background(0, 0,0);
      camera(player2.getX(), player2.getY()-300, player2.getZ()+600, player2.getX(),height/2, -8000 ,0,1,0);
      room2();
      lights();
      puzzle2 = true;
      dialogue(d_puzzle2);
      checkKeys2();
      break;
      
    case GAME3:
      song.close();
      healthCounter = 0;
      bar.display();
      score.display();
      background(0, 0,0);
      camera(player3.getX(), player3.getY()-300, player3.getZ()+600, player3.getX(),height/2, -8000 ,0,1,0);
      room3();
      lights();
      puzzle3 = true;
      dialogue(d_puzzle3);
      checkKeys3();
      break;
    
    case SELECT:
      background(0);
      selectRoom();
      break;
  }

}

void menu() {
  
  
  background(menu);
  fill(0);
  rect(width/2 - 125,height/2 - 100, 250, 75);
  fill(255);
  textSize(24);
  text("NEW GAME", width/2 - 65,height/2 - 65);
  textSize(14);
  text("PRESS [ENTER]", width/2 - 50,height/2 - 45);
  
  fill(0);
  rect(width/2 - 125,height/2 , 250, 75);
  fill(255);
  textSize(24);
  text("INSTRUCTIONS", width/2 - 85,height/2 + 35);
  textSize(14);
  text("PRESS [SPACE]", width/2 - 50,height/2 + 55);

  if(keyPressed && key == ENTER){
    state = 4;
  }
  
  if(keyPressed && key == ' '){
    state = 1;
  }
  
}

void howto() {
  
  image(instruct, 50, 50);
  textSize(24);
  text("MOVE", 100, 325);
  image(spacebar, 50, 400);
  text("JUMP", 100, 525);
  textSize(16);
  text("Press BACKSPACE to return to menu", width - 300, height -40);
  if(keyPressed && key == BACKSPACE){
    state = 0;
  }
  
  
}

void checkKeys() {
  player.getXZ(keys);
  player.updateY(keys[4]);
  player.displayChar();
  
}

void checkKeys2() {
  player2.getXZ(keys);
  player2.updateY(keys[4]);
  player2.displayChar();
  
}

void checkKeys3() {
  player3.getXZ(keys);
  player3.updateY(keys[4]);
  player3.displayChar();
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)
      keys[0]=true;
    if (keyCode==DOWN)
      keys[1]=true;
    if (keyCode==RIGHT)
      keys[2]=true;
    if (keyCode==LEFT)
      keys[3]=true;
  }
  if (key==' ')
    keys[4]=true;
  keys[5]=true;
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)
      keys[0]=false;
    if (keyCode==DOWN)
      keys[1]=false;
    if (keyCode==RIGHT)
      keys[2]=false;
    if (keyCode==LEFT)
      keys[3]=false;
  }
  if (key==' ')
    keys[4]=false;
  keys[5]=false;
  
  if(key == 'f')  //*******************************
  {
    if(intro)
    {
      if(i_d < d_intro.length-1)  //Display next line of dialogue - hard coded for d_intro, can change for other dialogues
      {
        i_d++;  
      }
      
      else
      {
        intro = false;          //Remove dialogue box and reset index value for next dialogue
        i_d = 0;
        state = 3;
      }
    }

    if(puzzle1)
    {
      if(i_d < d_puzzle1.length-1)  //Display next line of dialogue - hard coded for d_intro, can change for other dialogues
      {
        i_d++;  
      }
      
      else
      {
        puzzle1 = false;          
        i_d = 0;
      }
    }
    
    if(puzzle2)
    {
      if(i_d < d_puzzle2.length-1)  
      {
        i_d++;  
      }
      
      else
      {
        puzzle2 = false;     
        i_d = 0;
      }
    }
    
    if(puzzle3)
    {
      if(i_d < d_puzzle3.length-1)  
      {
        i_d++;  
      }
      
      else
      {
        puzzle3 = false;          
        i_d = 0;
      }
    }
  }
  
  if(key == 'r'){
     state = 3;
  }
  
  if(key == 'm')  //////////////////////**********************************
  {
    p2DONE = true;
  }
}

void dialogue(String[] _d)
{
  textSize(20);
  fill(255);
  print(i_d, " - ");
  println(_d[i_d]);
  textAlign(LEFT, TOP);
  text(_d[i_d], 0, height - height/4, width, height/2);
  
  fill(255, 0, 0, 63);  //Opacity at 25%
  rect(0, height - height/4, width, height/2);
}

void selectRoom() {
  
  if (keyPressed) {
    if (key == '1') {
      state = 2;
    }
  }
  if (keyPressed) {
    if (key == '2') {
      state = 8;
    }
  }  
  if (keyPressed) {
    if (key == '3') {
      state = 9;
    }
  }
   
}

void room1() {
  //floor
  noStroke();
  beginShape();
  texture(floor1);
  textureWrap(REPEAT);
  vertex(-3000, height,1000,0,0);
  vertex(-3000, height, -8000,3,0);
  vertex(3000, height, -8000,3,3);
  vertex(3000, height, 1000,0,3);
  endShape();
  
  //left wall
  beginShape();
  texture(wall1);
  textureWrap(REPEAT);
  vertex(-3000,height,1000,0,0);
  vertex(-3000,height,-8000,2,0);
  vertex(-3000,-2000,-8000,2,2);
  vertex(-3000,-2000,1000,0,2);
  endShape();
  
  //right wall
  beginShape();
  texture(wall1);
  textureWrap(REPEAT);
  vertex(3000,height,3000,0,0);
  vertex(3000,height,-8000,2,0);
  vertex(3000,-2000,-8000,2,2);
  vertex(3000,-2000,8000,0,2);
  endShape();
  
  //ceiling
  beginShape();
  texture(ceiling);
  textureWrap(REPEAT);
  vertex(-3000, -2000,1000,0,0);
  vertex(-3000, -2000, -8000,3,0);
  vertex(3000, -2000, -8000,3,3);
  vertex(3000, -2000, 1000,0,3);
  endShape();
  
  //farwall
  beginShape();
  texture(endwall);
  textureWrap(REPEAT);
  vertex(-3000,height,-8000,0,0);
  vertex(-3000,-2000,-8000,1,0);
  vertex(3000,-2000,-8000,1,1);
  vertex(3000,height,-8000,0,1);
  endShape();
  
  //key
  fill(255,215,0);
  pushMatrix();
  translate(width/2-200, height - 200, -7500);
  sphere(50);
  popMatrix();
}


//Angel  **********************
void room2() {
  //floor
  noStroke();
  beginShape();
  texture(floor2);
  textureWrap(REPEAT);
  vertex(-3000, height,1000,0,0);
  vertex(-3000, height, -8000,1,0);
  vertex(3000, height, -8000,1,1);
  vertex(3000, height, 1000,0,1);
  endShape();
  
  //left wall
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(-3000,height,1000,0,0);
  vertex(-3000,height,-8000,1,0);
  vertex(-3000,-2000,-8000,1,1);
  vertex(-3000,-2000,1000,0,1);
  endShape();
  
  //right wall
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(3000,height,1000,0,0);
  vertex(3000,height,-8000,1,0);
  vertex(3000,-2000,-8000,1,1);
  vertex(3000,-2000,1000,0,1);
  endShape();
  
  //TESTING
  //Path1 Right - Start Path
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(3000/5,height,0,0,0);
  vertex(3000/5,height,-4000,1,0);
  vertex(3000/5,-2000,-4000,1,1);
  vertex(3000/5,-2000,0,0,1);
  endShape();

  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(3000-3000/5*2,height,-1500,0,0);
  vertex(3000-3000/5*2,height,-8000,1,0);
  vertex(3000-3000/5*2,-2000,-8000,1,1);
  vertex(3000-3000/5*2,-2000,-1500,0,1);
  endShape();
  
  //Path1 Left - Start Path
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(-3000/5,height,0,0,0);
  vertex(-3000/5,height,-4000,1,0);
  vertex(-3000/5,-2000,-4000,1,1);
  vertex(-3000/5,-2000,0,0,1);
  endShape();
  
  //Middle Left
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(-3000,height,0,0,0);
  vertex(-3000,-2000,0,1,0);
  vertex(-3000/5,-2000,0,1,1);
  vertex(-3000/5,height,0,0,1);
  endShape();

  //Middle Right
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(3000,height,0,0,0);
  vertex(3000,-2000,0,1,0);
  vertex(3000/5,-2000,0,1,1);
  vertex(3000/5,height,0,0,1);
  endShape();

  //farwall2
  beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(-2000,height,-6000,0,0);
  vertex(-2000,-2000,-6000,1,0);
  vertex(2400,-2000,-6000,1,1);
  vertex(2400,height,-6000,0,1);
  endShape();
  
   beginShape();
  texture(wall2);
  textureWrap(REPEAT);
  vertex(-3000+3000/5*2,height,-1500,0,0);
  vertex(-3000+3000/5*2,height,-6000,1,0);
  vertex(-3000+3000/5*2,-2000,-6000,1,1);
  vertex(-3000+3000/5*2,-2000,-1500,0,1);
  endShape();
  
  
  //ceiling
  beginShape();
  texture(ceiling2);
  textureWrap(REPEAT);
  vertex(-3000, -2000,1000,0,0);
  vertex(-3000, -2000, -8000,2,0);
  vertex(3000, -2000, -8000,2,2);
  vertex(3000, -2000, 1000,0,2);
  endShape();
  
  //farwall
  beginShape();
  texture(endwall2);
  textureWrap(REPEAT);
  vertex(-3000,height,-8000,0,0);
  vertex(-3000,-2000,-8000,1,0);
  vertex(3000,-2000,-8000,1,1);
  vertex(3000,height,-8000,0,1);
  endShape();
  
  //key
  fill(255,215,0);
  pushMatrix();
  translate(width/2-200, height - 200, -7500);
  sphere(50);
  popMatrix();
}

void room3() {
  //floor
  noStroke();
  beginShape();
  texture(floor3);
  textureWrap(REPEAT);
  vertex(-3000, height,1000,0,0);
  vertex(-3000, height, -8000,1,0);
  vertex(3000, height, -8000,1,1);
  vertex(3000, height, 1000,0,1);
  endShape();
  
  //left wall
  beginShape();
  texture(wall3);
  textureWrap(REPEAT);
  vertex(-3000,height,1000,0,0);
  vertex(-3000,height,-8000,1,0);
  vertex(-3000,-2000,-8000,1,1);
  vertex(-3000,-2000,1000,0,1);
  endShape();
  
  //right wall
  beginShape();
  texture(wall3);
  textureWrap(REPEAT);
  vertex(3000,height,3000,0,0);
  vertex(3000,height,-8000,1,0);
  vertex(3000,-2000,-8000,1,1);
  vertex(3000,-2000,8000,0,1);
  endShape();
  
  //ceiling
  beginShape();
  texture(ceiling3);
  textureWrap(REPEAT);
  vertex(-3000, -2000,1000,0,0);
  vertex(-3000, -2000, -8000,1,0);
  vertex(3000, -2000, -8000,1,1);
  vertex(3000, -2000, 1000,0,1);
  endShape();
  
  //farwall
  beginShape();
  texture(endwall3);
  textureWrap(REPEAT);
  vertex(-3000,height,-8000,0,0);
  vertex(-3000,-2000,-8000,1,0);
  vertex(3000,-2000,-8000,1,1);
  vertex(3000,height,-8000,0,1);
  endShape();
  
  //key
  fill(255,215,0);
  pushMatrix();
  translate(width/2-200, height - 200, -7500);
  sphere(50);
  popMatrix();
}