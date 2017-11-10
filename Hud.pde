//----------------------------------------------------------
// HUD class
//----------------------------------------------------------

class HUD {
  // fields
  int condition;
  float x,y;
  float mapPX,mapPY = 0;
  float mappedSpeed = (player.speed*0.1)-.1;
  HashMap<float[],float[]> hm = new HashMap<float[],float[]>();
  
  //constructor
  HUD(float x, float y) {
    this.x = x;
    this.y = y;
    condition = 0;
    // save this for later
    for(int i=0; i<ss.size();i++){
      SpaceStation temp = ss.get(i);
      float[] coords = {temp.x,temp.y};
      float spaceX = temp.x;
      float spaceY = temp.y;
      //if(flag){
      float xdiff = spaceX - player.x;
      float ydiff = spaceY - player.y;
      float[] diffArray = {xdiff, ydiff};
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
       player.x = 4345.0;
       //println(player.getX());
    }
    if(farX <= ex+5){
       fill(155,0,255);
       ex = x+1300;
       mapPX = -300+5;
       //map/update real player
       player.x = -3045.0;
       //println(player.getX());
    }
    if(nearY >= ey-5){
       fill(155,0,255);
       ey = y-320;
       mapPY = 500-5;
       //map/update real player
       player.y = 6695.0;
       //println(player.getY());
    }
    if(farY <= ey+5){
       fill(155,0,255);
       ex = y-320;
       mapPY = -500+5;
       //map/update real player
       player.y= -5695.0;
       //println(player.getY());
    }
    ellipse(ex,ey,10,10);
    
    // enemy space station locations on map:
    for (Map.Entry ent : hm.entrySet()) {
      float[] keyCoords = (float[])ent.getKey();
      boolean flag = false;
      for(int i=0; i<ss.size(); i++){
        SpaceStation temp = ss.get(i);
        if(temp.x == keyCoords[0] && temp.y == keyCoords[1]){
          if(temp.count < 1){
            flag = true;
          }  
        }  
      }  
      float[] value = (float[])ent.getValue();
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
      //noStroke();
      rectMode(CENTER);
      tempLife.shipSprite();
      rectMode(CORNER);
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
    String hudDir = player.dirFlag;
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