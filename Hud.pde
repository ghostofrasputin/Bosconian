//----------------------------------------------------------
// HUD class - head-up display for map, score, lives, etc
//----------------------------------------------------------

class HUD {
  // fields
  int condition;
  private int x,y;
  private float mapPX,mapPY = 0;
  private float mappedSpeed = .4;
  private HashMap<int[],int[]> hm = new HashMap<int[],int[]>();
  
  //constructor
  HUD(int x, int y) {
    this.x = x;
    this.y = y;
    condition = 0;
    // save this for later
    for(int i=0; i<ss.size();i++){
      SpaceStation temp = ss.get(i);
      int[] coords = {temp.getX(),temp.getY()};
      int spaceX = temp.getX();
      int spaceY = temp.getY();
      //if(flag){
      int xdiff = spaceX - player.getX();
      int ydiff = spaceY - player.getY();
      int[] diffArray = {xdiff, ydiff};
      // they key will be the x/y coords cause it's a unique id
      hm.put(coords,diffArray);
    }    
  }
    
  void display(){
    rectMode(CORNER);
    fill(0);
    //rect(x+1350,y-900,600,1800); 
    rect(x+1000,y-1000,700,2000);
    
    // display highscore:
    fill(255,0,0);
    textSize(75);
    text("Hi-Score", x+1000, y-900);
    fill(255);
    text(highscore, x+1000, y-800);
    
    // display 1 up:
    text("1UP", x+1000, y-700);
    text(oneUp, x+1000, y-600);
    
    // display condition:
    text("CONDITION", x+1000, y-500);
    //green
    if(condition == 0){
      fill(0,255,0);
      rect(x+1000, y-450,600,100);
      fill(0);
      textSize(105);
      text("GREEN", x+1125, y-360);
    }
    //yellow
    if(condition == 1){
      fill(255,255,0);
      rect(x+1000, y-450,600,100);
      fill(0);
      textSize(105);
      text("YELLOW", x+1100, y-360);
    }
    textSize(100);
    
    // map
    fill(155,0,255);
    rect(x+1000, y-320,600,1000);
    
    // set map limits:
    float nearX = x+1000;
    float farX  = x+1600;
    float nearY = y-320;
    float farY  = y+680;
    
    // mapped player circle
    //
    // BUG: x (y?) moves circle to middle briefly
    // when crossing a limit, fill covers this mistake
    //eColor = eColor == 0 ? 255 : 0; // for blinking effect
    fill(255);
    float ex = x+1300+mapPX;
    float ey = y+180+mapPY;
    // check limits
    if(nearX >= ex-5){
       fill(155,0,255);
       ex = x+1300;
       mapPX = 300-5;
       //map/update real player
       player.setX(4345);
       //println(player.getX());
    }
    if(farX <= ex+5){
       fill(155,0,255);
       ex = x+1300;
       mapPX = -300+5;
       //map/update real player
       player.setX(-3045);
       //println(player.getX());
    }
    if(nearY >= ey-5){
       fill(155,0,255);
       ey = y-320;
       mapPY = 500-5;
       //map/update real player
       player.setY(6695);
       //println(player.getY());
    }
    if(farY <= ey+5){
       fill(155,0,255);
       ex = y-320;
       mapPY = -500+5;
       //map/update real player
       player.setY(-5695);
       //println(player.getY());
    }
    ellipse(ex,ey,10,10);
    
    // enemy space station locations on map:
    for (Map.Entry ent : hm.entrySet()) {
      int[] keyCoords = (int[])ent.getKey();
      boolean flag = false;
      for(int i=0; i<ss.size(); i++){
        SpaceStation temp = ss.get(i);
        if(temp.getX() == keyCoords[0] && temp.getY() == keyCoords[1]){
          if(temp.sections.size() == 0){
            flag = true;
          }  
        }  
      }  
      int[] value = (int[])ent.getValue();
      // draw map representation here:
      if(flag == false){
        fill(0,255,0);
        ellipse(x+1300+value[0]/12.5,y+180+value[1]/12.5,13,13);
      }
    }
    
    // lives
    int distance = 0;
    for(int i=0; i<numLives; i++){
      Ship tempLife = new Ship(x+1050+distance,y+725);
      tempLife.display();
      distance+=100;
    }
    
    // round number
    fill(255);
    text("ROUND:", x+1000, y+875);
    text(level, x+1400, y+875);
  }
  
  void update(){
    x = player.x;
    y = player.y;
    String hudDir = player.getDir();
    switch(hudDir){
      case "w":
        mapPY-=mappedSpeed;
        break;
      case "a":
        mapPX-=mappedSpeed;
        break;
      case "s":
        mapPY+=mappedSpeed;
        break;
      case "d":
        mapPX+=mappedSpeed;
        break;
     }
  }  
}