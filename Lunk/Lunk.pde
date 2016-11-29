Parser settings;

void setup()
{
  settings = new Parser("settings.xml");
  XML[] options = settings.getSettings();
}

void intro()
{
  
}