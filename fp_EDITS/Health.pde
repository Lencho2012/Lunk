class Health {
  float x, y;                              //pos of health bar
  int health;                             //health starts at 100, can be changed to start at a different number
  float max=110;                          //max is used to get the len of outer bar of health bar
  float w=30;                             //width of health bar
  PFont  font= createFont("Inconsolata-Regular.ttf", 16);  //loading a font from googlefonts

  //health bar color changes depending on how critical health is. 
  //red for health less than 10, orange for health less than 25, 
  //and green for above 25
  color health_c=color(0, 255, 0);       
  color font_c=color(0);                   // font color changes to make it visible when the health bar color changes;
  float textpos;                           //pos to place text


  //default constructor
  Health() {
    x=width-125;
    y= 30;
    health = 100;
  }

  //constructor if want to start at a lesser health, maybe in the future for harder games
  Health(int _health) {
    x=width-125;
    y= 30;
    health=_health;
  }

  void updateX(float _x) {
    if (_x!=0)
      x=_x+width/2-125;
  }

  //if the ship collides or pickups objects then the health may be affected
  //colliding with meteors hurts the health  These are neg numbers
  //picking up boosters or health packs recovers health. These are pos numbers;
  void update(float pickup, float shield) {
    if (health+pickup>100)
      health=100;                     // health is never greater than 100;
    else if (health+pickup<=0)         // health never less than 0;
      health=0;
    else
      health+=pickup;                 //increase or decrease health depending on pickup
    update_color(shield);                   //change color of health depending on amount of health
  }

  //this changes the color of the health bar to green, orange, or red 
  //to give visual representation of status of health;
  //also changes font color to be used depending on the bar color for better 
  //visibility
  void update_color(float shield) {
    if (shield>0){
      print(shield + "\n");
      health_c=color(0, 255, 255);
    }
    else {
      if (health<=25 && health>10) {                    // orange for warning health
        health_c=color(255, 255, 0);
        font_c=color(0);
      } else if (health<=10) {                           //red for bad health
        health_c=color(255, 0, 0);
        font_c=color(255);
      } else {                                            //green for good enough health
        health_c=color(0, 255, 0);
        font_c=color(0);
      }
    }
  }

  //checks to see if the player still has health to play
  //if not then returns a false letting know if the game has ended
  boolean isDead() {
    if (health<=0)
      return true;
    else
      return false;
  }

  //displays the actual health bar
  void display() {
    textFont(font);
    noStroke();
    fill(255, 75);                            //white with 75% opacity
    rect(x, y, max, w, 10);

    fill(health_c);
    rect(x+5, y+5, health, w-10, 10);
    fill(font_c);
    text("HP", x+10, y+8);
    if (health==100)
      textpos=x+80;
    else
      textpos=x+85;
    text(health, textpos, y+8);
  }
}