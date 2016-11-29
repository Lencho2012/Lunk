Parser settings;
int i = 0;

String[] d = {"this is a test", 
              "this is another sentence"};

void setup()
{
  size(500, 500);
  settings = new Parser("settings.xml");
  XML[] options = settings.getSettings();
}

void draw()
{
  background(0);
  noStroke();
  dialogue(d);
  
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
  }
}