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
HashMap<Character, Boolean> keyInput = new HashMap<Character, Boolean>();

//----------------------------------------------------------
// Setup function
//----------------------------------------------------------
void setup(){
  size(1300,1000,P3D);
  frameRate(120);
  
  // setup key input
  keyInput.put('w',false);
  keyInput.put('a',false);
  keyInput.put('s',false);
  keyInput.put('d',false);
  keyInput.put('o',false);
  
  // generate first level
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
  if(frameCount%10 == 0 && keyInput.get('o')){
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
// Handle Key Input: keeps track of multiple key presses
//---------------------------------------------------------- 
void keyPressed(){
  if(key=='w' || key == 'W')
    keyInput.put('w',true);
  if(key=='a' || key == 'A')
    keyInput.put('a',true);
  if(key=='s' || key == 'S')
    keyInput.put('s',true);
  if(key=='d' || key == 'D')
    keyInput.put('d',true);
  if(key=='o' || key == 'O')
    keyInput.put('o',true);
}

void keyReleased(){
  if(key=='w' || key == 'W')
    keyInput.put('w',false);
  if(key=='a' || key == 'A')
    keyInput.put('a',false);
  if(key=='s' || key == 'S')
    keyInput.put('s',false);
  if(key=='d' || key == 'D')
    keyInput.put('d',false);
  if(key=='o' || key == 'O')
    keyInput.put('o',false);
}

//----------------------------------------------------------
// HELPER FUNCTIONS
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