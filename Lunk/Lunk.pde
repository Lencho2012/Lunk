Parser settings;
int i = 0;
boolean end = false;

String[] d = {"this", "is", "a", "test"};

void setup()
{
  size(500, 500);
  settings = new Parser("settings.xml");
  XML[] options = settings.getSettings();
}

void draw()
{
  background(100);
  dialogue(d);
}

void dialogue(String[] _d)
{
  
  textSize(24);
  fill(255);
  print(i);
  println(_d[i]);
  text(_d[i], width/2, height/2);
}

void keyReleased()
{
  if(i < d.length-1)
  {
    i++;
  }
}