/***********************************************************
 * Program: Namco's Bosconian remake project               *
 * Author: Jacob Preston                                   *
 *                                                         *
 * Instructions:                                           *
 * move using WASD                                         *
 * shoot by pressing the O button                          * 
 *                                                         *
 * Description: I really like playing the arcade game,     *
 * Bosconian, so I tried to recreate it while also         *
 * adding new features                                     *
 ***********************************************************/
 
import java.util.Map;
 
//----------------------------------------------------------
// Global variables
//----------------------------------------------------------
Ship player;
HUD hud;
int len = 1000;
int level = 0;
int progress = 1;
int numStations = 1;
int numDestroyed = 0;
int numRounds = 0;
int highscore = 0;
int oneUp = 0;
int numLives = 4;
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<SpaceStation> ss = new ArrayList<SpaceStation>();

//----------------------------------------------------------
// Setup function
//----------------------------------------------------------
void setup(){
  size(1300,1000,P3D);
  frameRate(120);
  generate();
}

//----------------------------------------------------------
// Draw function
//----------------------------------------------------------
void draw() {
  background(0);

  if(numDestroyed==numStations){
    numDestroyed = 0;
    level++;
    ss = new ArrayList<SpaceStation>();
  }
  // Generate new level
  if(progress == level){
    generate();
    progress++;
    delay(2000);
  }
  
  // Fire Bullets!!!
  if(frameCount%10 == 0 /**&& mousePressed){ */ && keyPressed && key== 'o' || key == 'O' ){
    Bullet b = new Bullet("",player.getX(), player.getY());
    bullets.add(b);
  }
  // Animate bullets 
  for(int i=0; i<bullets.size(); i++){
    Bullet b = bullets.get(i);
    if(b.y > (player.y-len) && b.y < (player.y+len) &&
       b.x > (player.x-len) && b.x < (player.x+len)){
         b.display();
         b.update();
         collision(b,i);
    } else{
        // Clean-up bullets that go off screen
        bullets.remove(i);
    }
  }
  
  // Display/update space stations:
  for(int i=0; i<ss.size();i++){
    SpaceStation current = ss.get(i);
    current.display();
    current.update();
  }
  
  // display/update HUD information
  hud.display();
  hud.update();
  
  // setup camera:
  // the camera needs to follow the player, but there should be an 
  // offset in the x coords in order to make room for the HUD
  camera(0.0, 0.0, 1000000000, player.getX()+300, player.y, 0.0, 0.0, 1.0, 0.0);
  ortho(-width, width, -height, height);
  
  // display/update ship
  shipCollision();
  player.display();
  player.update(); 
  
  //BUG: anything here will be fucked by translation/rotation 
}

//----------------------------------------------------------
// Ship class - creates the player's ship
//----------------------------------------------------------
class Ship {
  //fields
  private int x, y, speed;
  private String dirFlag;
  Ship(int x, int y){
    this.x = x;
    this.y = y;
    this.dirFlag = "w";
    this.speed = 5;
  }
  void display(){
    noStroke();
    rectMode(CENTER);
    switch(dirFlag){
      case "w":
        shipSprite();
        break;
      case "a":
        translate(x,y);
        rotate(radians(-90));
        translate(-x,-y);
        shipSprite();
        break;
      case "s":
        translate(x,y);
        rotate(radians(180));
        translate(-x,-y);
        shipSprite();
        break;
      case "d":
        translate(x,y);
        rotate(radians(90));
        translate(-x,-y);
        shipSprite();
        break;
    } 
  }
  // private function that draws ship sprite
  private void shipSprite(){
    fill(255);
    // tall part
    rect(x,y-10,5,45);
    // 2nd tall part
    rect(x,y+5,15,60);
    // chubby white middle
    rect(x,y+5,25,45);
    // left side
    rect(x-14,y+5,5,20);
    rect(x-18,y+7,5,15);
    rect(x-22,y+5,5,50);
    rect(x-27,y+15,5,15);
    rect(x-31,y+12,5,20);
    // right side
    rect(x+14,y+5,5,20);
    rect(x+18,y+7,5,15);
    rect(x+22,y+5,5,50);
    rect(x+27,y+15,5,15);
    rect(x+31,y+12,5,20);
    //red part
    fill(255,0,0,255);
    //red middle sqaure
    rect(x,y,15,10);
    //left middle
    rect(x-5,y+7,5,5);
    //right middle
    rect(x+5,y+7,5,5);
    //top middle
    rect(x,y-7,5,10);
    //bottom red
    rect(x,y+35,15,2.5);
    //right bottom
    rect(x+29,y+23,9,2.5);
    //left bottom
    rect(x-29,y+23,9,2.5);
    //right top
    rect(x+22,y-21,5,2.5);
    //left top
    rect(x-22,y-21,5,2.5);
  }  
  // updates position and performs
  // boundary check of the map
  void update(){
    // north
    if(key == 'w' || key == 'W' || dirFlag == "w"){
      y-=speed;
      dirFlag = "w";
    }
    //west
    if(key == 'a' || key == 'A' || dirFlag == "a"){
      x-=speed;
      dirFlag = "a";
    }
    // south
    if(key == 's' || key == 'S' || dirFlag == "s"){
      y+=speed;
      dirFlag = "s";
    }
    // east
    if(key == 'd' || key == 'D' || dirFlag == "d"){
      x+=speed;
      dirFlag = "d";
    }  
  }
  
  // get direction
  String getDir(){
    return dirFlag;
  }
  
  void setX(int num){
    x = num;
  }
  void setY(int num){
    y = num;
  }
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }  
}  

//----------------------------------------------------------
// SpaceStation class - creates a space station that fires
// bullets and has panel that opens closes over the station's
// core
//----------------------------------------------------------
class SpaceStation {
  // fields
  private int x,y;
  ArrayList<Section> sections;
  private boolean position;
  private boolean destroyed=false;
  int[] ffData;
  // constructor
  SpaceStation(boolean pos, int x, int y){
    position = pos;
    this.x = x;
    this.y = y;
    ffData = new int[3];
    ffData[0] = x;
    ffData[1] = y;
    ffData[2] = 100;
    sections = new ArrayList<Section>();
    // space station with vertical openings:
    if(position == true){
      int xdist = 100;
      int ydist = 150;
      int oDist = 175;
      Section topLeft = new Section(x-xdist,y-ydist);
      sections.add(topLeft);
      Section topRight = new Section(x+xdist,y-ydist);
      sections.add(topRight);
      Section midLeft = new Section(x-oDist,y);
      sections.add(midLeft);
      Section midRight = new Section(x+oDist,y);
      sections.add(midRight);
      Section botLeft = new Section(x-xdist,y+ydist);
      sections.add(botLeft);
      Section botRight = new Section(x+xdist,y+ydist);
      sections.add(botRight);
      Section powerCore = new Section(x,y);
      sections.add(powerCore);
    } 
    // space station with vertical openings:
    else{
      int xdist = 100;
      int ydist = 150;
      int oDist = 175;
      Section topLeft = new Section(x-ydist,y-xdist);
      sections.add(topLeft);
      Section topRight = new Section(x+ydist,y-xdist);
      sections.add(topRight);
      Section midTop = new Section(x,y-oDist);
      sections.add(midTop);
      Section midBot = new Section(x,y+oDist);
      sections.add(midBot);
      Section botLeft = new Section(x-ydist,y+xdist);
      sections.add(botLeft);
      Section botRight = new Section(x+ydist,y+xdist);
      sections.add(botRight);
      Section powerCore = new Section(x,y);
      sections.add(powerCore);
    }  
  }
  //draws the inital space station
  void display(){
    // protective ring of power core:
    if(sections.size() > 1){
      fill(255,0,0,135);
      ellipse(x, y, 200, 200);
      fill(0);
      ellipse(x,y,150,150);
      noStroke();
    }
    for(int i=0; i<sections.size();i++){
      Section current = sections.get(i);
      current.display();
    }
  }
  void update(){
    //update hud score if ss is destroyed:
    if(sections.size()==0 && destroyed==false){
      oneUp+=1000;
      if(oneUp>highscore){
        highscore+=1000;
      }
      destroyed = true;
    }
    for(int i=0; i<sections.size();i++){
      Section current = sections.get(i);
      current.update();
    }
  }
  // helper functions
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
}

//----------------------------------------------------------
// Section class - creates a section, a space station
// needs 6
//----------------------------------------------------------
class Section {
  // fields
  private int x,y,size;
  ArrayList<Bullet> sBullets;
  // constructor
  Section(int x, int y){
    this.x = x;
    this.y = y;
    this.size = 100;
    sBullets = new ArrayList<Bullet>();
  }
  void display(){
    fill(0,255,0);
    ellipse(x,y,size,size);
  }
  void update(){
    // shoot at player within range
    if(withinShootingRange(x,y) /**&& Math.random() < 0.1*/){
       Bullet sb = new Bullet("enemy",x, y);
       sBullets.add(sb);
    }
   for(int i=0; i<sBullets.size(); i++){
      Bullet b = sBullets.get(i);
      if(b.y > (player.y-len) && b.y < (player.y+len) &&
         b.x > (player.x-len) && b.x < (player.x+len)){
           b.display();
           b.update();
      } else{
          // Clean-up bullets that go off screen
          sBullets.remove(i);
      }
    }
       //sb.display();
       //sb.update();  
    // write explosion code
  }
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  int getS(){
    return size;
  }
  
  // checks if player is within shooting range of a SS section
  private boolean withinShootingRange(int x, int y){
    int range = 600;
    int xDist = abs(player.getX() - x);
    int yDist = abs(player.getY() - y);
    if (xDist < range && yDist < range){
      return true;
    }
    return false;
  } 

}

//----------------------------------------------------------
// Bullet class - creates bullet objects that the player
// can shoot
//----------------------------------------------------------
class Bullet {
  // fields
  int x, y, x2, y2;
  private String type = "";
  //int w,h;
  private int bulletSpeed;
  private String bDir;
  private float easingAmount = .01; //interesting effects: .01
  private boolean flag = false;
  private int[] dists;
  // constructor
  Bullet(String type, int x, int y){
    this.x = this.x2 = x;
    this.y = this.y2 = y;
    this.bulletSpeed = 15;
    this.bDir = player.getDir();
    this.type = type;
    dists = new int[2];
  }
  // fucntions:
  void display(){
    fill(255);
    if(type=="enemy"){
      fill(255,0,0);
    }    
    ellipse(x,y,10,10); 
  }
  void update(){
    if(type == "enemy"){
      if(flag == false){
        int xDist = player.getX() - x;
        int yDist = player.getY() - y;
        dists[0] = xDist;
        dists[1] = yDist;
        flag = true;
      }
      x += dists[0] * easingAmount;
      y += dists[1] * easingAmount;
    }  
    else{
      switch(bDir){
      case "w":
          y-=bulletSpeed;
          //y2+=bulletSpeed;
          break;
        case "a":
          x-=bulletSpeed;
          //x2+=bulletSpeed;
          break;
        case "s":
          y+=bulletSpeed;
          //y2-=bulletSpeed;
          break;
        case "d":
          x+=bulletSpeed;
          //x2-=bulletSpeed;
          break;
     }
   } 
  }
}

//----------------------------------------------------------
// Asteroid class - creates asteroid obstacles
//----------------------------------------------------------
class Asteroid {
  
}

//----------------------------------------------------------
// Mine class - creates mine obstacles
//----------------------------------------------------------
class Mine {
  
}

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

//----------------------------------------------------------
// FUNCTIONS
//----------------------------------------------------------

//checks space station/bullet collisions
void collision(Bullet bullet, int bulletNum){
  // run through all the space stations in the level
  for(int i=0; i<ss.size(); i++){
    SpaceStation temp = ss.get(i);
    ArrayList<Section> sections = temp.sections;
    // run through all the sections of that space station
    for(int j=0; j<sections.size();j++){
      Section sTemp = sections.get(j);
      // section circle stuff
      int secX = sTemp.getX();
      int secY = sTemp.getY();
      int secR = sTemp.getS()/2;
      // forcefield stuff
      int ffDX = temp.ffData[0];
      int ffDY = temp.ffData[1];
      int ffDR = temp.ffData[2];
      // bullet circle stuff
      int bulX = bullet.x;
      int bulY = bullet.y;
      int bulR = 10;
      
      // collision check bullet and sections:
      if(((bulX-secX)*(bulX-secX) + (bulY-secY)*(bulY-secY)) <= ((bulR+secR)*(bulR+secR))){
        // j is last, which is the powercore to be removed
        if(j == sections.size()-1 && sections.size()==1){
          sections.remove(j);
          numDestroyed++;
          break;
        } 
        // if j isn't last or equal to 1, so it isn't the power core
        if(j != sections.size()-1 && sections.size()!=1){
          sections.remove(j);
        }          
      }
      // collision check bullet and force field:
      if(((bulX-ffDX)*(bulX-ffDX) + (bulY-ffDY)*(bulY-ffDY)) <= ((bulR+ffDR)*(bulR+ffDR))){
        if(sections.size()>1){
          bullets.remove(bulletNum);
          break;
        }
      }  
    }
  }
}

// checks ship collision with sections, forcefields, and enemy bulletsa
void shipCollision(){
    for(int i=0; i<ss.size(); i++){
      SpaceStation temp = ss.get(i);
      ArrayList<Section> sections = temp.sections;
      // run through all the sections of that space station
      for(int j=0; j<sections.size();j++){
        Section sTemp = sections.get(j);
        // player rect stuff
        int plyX = player.getX()-29;
        int plyY = player.getY()-21;
        int plyW = 65;
        int plyH = 47;
        // section circle stuff
        int secX = sTemp.getX();
        int secY = sTemp.getY();
        int secR = sTemp.getS()/2;
        // forcefield stuff
        int ffDX = temp.ffData[0];
        int ffDY = temp.ffData[1];
        int ffDR = temp.ffData[2];
        // collison check sections and player
        int distX = abs(secX - plyX-plyW/2);
        int distY = abs(secY - plyY-plyH/2);
        int dx=distX-plyW/2;
        int dy=distY-plyH/2;
        if (dx*dx+dy*dy<=(secR*secR)){
          numLives--;
        }
        //collision check forcefield and player
        //only check when forcefield is up
        if(sections.size()>1){
          int distX2 = abs(ffDX - plyX-plyW/2);
          int distY2 = abs(ffDY - plyY-plyH/2);
          int dx2=distX2-plyW/2;
          int dy2=distY2-plyH/2;
          if (dx2*dx2+dy2*dy2<=(ffDR*ffDR)){  
            numLives--;
          }
        }
        // collison check bullets and player
        for(int k=0; k<sTemp.sBullets.size();k++){
          Bullet tempBullet = sTemp.sBullets.get(k);
          // enemy bullet circle stuff
          int bulX = tempBullet.x;
          int bulY = tempBullet.y;
          int bulR = 10;
          int distX3 = abs(bulX - plyX-plyW/2);
          int distY3 = abs(bulY - plyY-plyH/2);
          int dx3=distX3-plyW/2;
          int dy3=distY3-plyH/2;
          if (dx3*dx3+dy3*dy3<=(bulR*bulR)){
            numLives--;
          }
        }  
     }
   }  
} 

// creates procedurally generated levels
void generate(){
  // bounds
  float nearX = -3045+1000;
  float farX  = 4345-1000;
  float nearY = -5695+1000;
  float farY  = 6695-1000;
  numStations = (int)random(level+2,level+5);
  for(int i=0; i<numStations; i++){
    int x = (int)random(nearX,farX);
    int y = (int)random(nearY,farY);
    SpaceStation temp = new SpaceStation(Math.random()<.5,x,y);
    ss.add(temp);
  }
  player = new Ship(width/2,height/2);
  hud = new HUD(player.x,player.y);
}  

// end