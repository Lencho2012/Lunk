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
int i_d = 0;      //index for dialogue arrays
boolean intro = true;
boolean puzzle1 = false;      
boolean puzzle2 = false;      
boolean puzzle3 = false;

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
               
String[] d_puzzle1 = {"B: A new puzzle!", 
                "Lunk: Looks hard.", 
                "B: Deal with it. Now go find my lettu- I mean the treasure"};
                

String[] d_puzzle2 = {"B: A new puzzle!", 
                "Lunk: Looks easy.", 
                "B: It's not"};
                
String[] d_puzzle3 = {"B: A new puzzle!", 
                "Lunk: Looks moderatly challenging.", 
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
  
  if(intro == true)
  {
    dialogue(d_intro);
  }
}

void dialogue(String[] _d)
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

void keyReleased()
{
  if(key == 'f')
  {
    if(i_d < d_intro.length-1)  //Display next line of dialogue - hard coded for d_intro, can change for other dialogues
    {
      i_d++;  
    }
    
    else
    {
      intro = false;          //Remove dialogue box and reset index value for next dialogue
      i_d = 0;
    }
  }
}