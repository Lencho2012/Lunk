Parser settings;
int i = 0;
int health;
int time;
int dx;
int px;

boolean intro = true;

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
               

void setup()
{
  size(500, 500);
  settings = new Parser("settings.xml");
  String[] options = settings.getSettings();  //Options from xml input: health/timelimit/damagex/pointsx
  
  health = options[0];
  time = options[1];
  dx = options[2];
  px = options[3];
}

void draw()
{
  background(0);
  noStroke();
  
  if(intro == true)
  {
    dialogue(d_intro);
  }
}

void dialogue(String[] _d)
{
  
  textSize(16);
  fill(255);
  print(i, " - ");
  println(_d[i]);
  textAlign(LEFT, TOP);
  text(_d[i], 0, height/2);
  
  fill(255, 0, 0, 63);  //Opacity at 25%
  rect(0, height/2, textWidth(_d[i]), 40);
}

void keyReleased()
{
  if(key == 'f')
  {
    if(i < d.length-1)
    {
      i++;
    }
    
    else
    {
      intro = false;
      i = 0;
    }
  }
}
