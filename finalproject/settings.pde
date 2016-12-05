
class Parser
{
  XML settings;
  
  Parser(String _settings)                    //Initiate with xml file string
  {
    settings = loadXML(_settings);
  }
  
  
  String[] getSettings()
  {
    XML[] options = settings.getChildren();
    
    String h = options[1].getContent();      //Health options
    String t = options[3].getContent();      //Time settings
    String dx = options[5].getContent();     //Damage mutliplier
    String cx = options[7].getContent();     //Score multiplier

    String[] o = new String[]{h, t, dx, cx};
    for(String s : o)
    {
      println(s);
    }
    
    return o;                                 //Return array of options in string formats
  }
}