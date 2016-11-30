Parser settings;  //Parser object for getting xml file game settings
int health;      
int time;
int dx;
int px;

/*
Dialogue Options

Booleans can be set to true for when you wish to display dialogue

Run dialogue(String[] _d) with whichever dialogue array you need for a particular part

Running through array - keyReleased() will update index of array and display next line when releasing 'f'
*/
int i_d = 0;                //index for dialogue arrays

//intro, puzzle1, puzzle2, puzzle3
boolean[] d_show = {false, true, false, false};

String[] d_intro = {"Lunk: Wh.. where am I?", 
               "B: Lunk, you must find the secret treasure… Only then can you escape this land...",
               "Lunk: Who… who is speaking to me?",
               "B: I am the one who will guide you through this journey...",
               "Lunk: So, like, are you gonna guide me through the tutorial and stuff?",
               "B: No, Sir. Lunk, you should have done that while in the menu screen when you started the game.",
               "Lunk: Game?",
               "B: Alright, nevermind. Let's just go through it. You can move with the directional keys. The spacebar will bring you to greater heights that you never thought possible...", 
               "Lunk: Right... And so my goal here is?",
               "B: Look, there are three puzzles you must solve to find the secret treasure. You can try to get them in any order. But BEWARE! Each will prove to be the greatest adversary you have ever faced...",
               "Lunk: How can a puzzle be an adversary?",
               "B: You take damage if you get them wrong. Get it wrong enough… and you DIE!",
               "Lunk: Ouch.",
               "B: Indeed.",
               "Lunk: So, where do I start?",
               "B: I just said you can start anywhere.",
               "Lunk: Oh, yeah. Alright. Hey, maybe along the way you can, like, give more exposition so the player knows what’s really going on and stuff.",
               "B: Stop talking and pick a puzzle. Ugh."};
               
String[] d_puzzle1 = {"B: A new puzzle!", 
                "Lunk: Looks hard.", 
                "B: Deal with it. Now go find my lettu- I mean the treasure."};
                

String[] d_puzzle2 = {"B: A new puzzle!", 
                "Lunk: Looks easy.", 
                "B: It's not."};
                
String[] d_puzzle3 = {"B: A new puzzle!", 
                "Lunk: Looks moderately challenging.", 
                "B: Sigh. Just go."};
               

void setup()
{
  size(1000, 500);
  settings = new Parser("settings.xml");
  String[] options = settings.getSettings();  //Options from xml input: health/timelimit/damagex/pointsx
  
  //health = options[0];
  //time = options[1];
  //dx = options[2];
  //px = options[3];
}

void draw()
{
  background(0);
  noStroke();
  
  dialogue();
}

void dialogue()      //Single method for all dialogue display
{
  if(d_show[0] == true)
  {
    dialogueDisplay(d_intro);
  }
  
  else if(d_show[1] == true)
  {
    dialogueDisplay(d_puzzle1);
  }
  
  else if(d_show[2] == true)
  {
    dialogueDisplay(d_puzzle2);
  }
  
  else if(d_show[3] == true)
  {
    dialogueDisplay(d_puzzle3);
  }
}

void dialogueDisplay(String[] _d)    //Display a dialogue
{
  textSize(16);
  fill(255);
  print(i_d, " - ");
  println(_d[i_d]);
  textAlign(LEFT, TOP);
  text(_d[i_d], 0, height - height/4, width, height/2);
  
  fill(255, 0, 0, 63);  //Opacity at 25%
  rect(0, height - height/4, width, height/2);
}

void progressDialogue(int _db, String[] _da)  //Update displayed dialogue line and remove dialogue box when finished
{
  if(key == 'f' && d_show[_db] == true)
  {
    if(i_d < _da.length-1)  //Display next line of dialogue - hard coded for d_intro, can change for other dialogues
    {
      i_d++;  
    }
    
    else
    {
      d_show[_db] = false;          //Remove dialogue box and reset index value for next dialogue
      i_d = 0;
    }
  }
}

void keyReleased()
{
  progressDialogue(0, d_intro);
  progressDialogue(1, d_puzzle1);
  progressDialogue(2, d_puzzle2);
  progressDialogue(3, d_puzzle3);
}