/***********************************************************
 * Program: Namco's Bosconian remake project               *
 * Author: Jacob Preston                                   *
 *                                                         *
 * Instructions:                                           *
 * move using WASD                                         *
 * shoot by pressing the O button                          * 
 *                                                         *
 ***********************************************************/

import java.util.Map;
import processing.sound.*;
 
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
ArrayList<Formation> forms = new ArrayList<Formation>();
ArrayList<Mine> mines = new ArrayList<Mine>();
ArrayList<PVector> stars = new ArrayList<PVector>();
HashMap<Character, Boolean> keyInput = new HashMap<Character, Boolean>();
HashMap<String, SoundFile> sfx = new HashMap<String, SoundFile>();
Formation f = new Formation("squadron", width/2, height/2);


//----------------------------------------------------------
// Setup function
//----------------------------------------------------------
void setup(){
  size(1300,1000,P3D);
  frameRate(60);
  forms.add(f);
  // setup key input
  keyInput.put('w',false);
  keyInput.put('a',false);
  keyInput.put('s',false);
  keyInput.put('d',false);
  keyInput.put('o',false);
  keyInput.put('p',false);
  
  // music/sfx library
  sfx.put("shoot", new SoundFile(this, "sfx/shoot.wav"));
  sfx.put("background", new SoundFile(this, "sfx/background.wav"));
  sfx.put("mine", new SoundFile(this, "sfx/mine.wav"));
  sfx.put("section", new SoundFile(this, "sfx/section.wav"));
  sfx.get("background").play();
  sfx.get("background").stop();
  sfx.get("background").loop(1.0,0.0,0.5);
  
  // generate first level
  generate();
  
}

//----------------------------------------------------------
// Draw function
//----------------------------------------------------------
void draw() {
  
  background(0);
  drawStars();
  
  if(numDestroyed==numStations){
    numDestroyed = 0;
    level++;
    ss.clear();
  }
  // Generate new level
  if(progress == level){
    generate();
    progress++;
    delay(2000);
  }
  
  // Display/update space stations:
  for(int i=0; i<ss.size();i++){
    SpaceStation current = ss.get(i);
    current.display();
    current.update();
  }
  
  // display mines
  for(int i=0; i<mines.size(); i++){
    Mine m = mines.get(i);
    m.display();
  }
  
  for(int i=0; i<forms.size(); i++){
    Formation f = forms.get(i);
    f.display();
    f.update();
  }
  
  // display/update HUD information
  hud.display();
  hud.update();
  
  // setup camera:
  // the camera needs to follow the player, but there should be an 
  // offset in the x coords in order to make room for the HUD
  camera(player.x+300, player.y, 0.1, player.x+300, player.y, 0.0, 0.0, 1.0, 0.0);
  ortho(-width, width, -height, height);
  
  // display/update ship
  player.update(); 
  player.display();
  
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
  if(key=='p' || key == 'P')
    keyInput.put('p',true); 
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
  if(key=='p' || key == 'P')
    keyInput.put('p',false);  
}

//----------------------------------------------------------
// Level Generation Functions
//----------------------------------------------------------

// creates procedurally generated levels
void generate(){
  // bounds
  float nearX = -3045+1000;
  float farX  = 4345-1000;
  float nearY = -5695+1000;
  float farY  = 6695-1000;
  numStations = (int)random(level+2,level+5);
  for(int i=0; i<numStations; i++){
    float x = random(nearX,farX);
    float y = random(nearY,farY);
    SpaceStation temp = new SpaceStation(Math.random()<.5,x,y);
    ss.add(temp);
  }
  player = new Ship(width/2,height/2);
  hud = new HUD(player.x,player.y);
  for(int i=0; i<400; i++){
    Mine m = new Mine(random(-3045.0,4345.0),random(-5695.0,6695.0));
    if(!mineCollision(m)){
      mines.add(m);
    }
  }
  for(int i=0; i<1000; i++){
    stars.add(new PVector(random(-3045.0,4345.0),random(-5695.0,6695.0)));
  }
}

void drawStars(){
  fill(255);
  float size = 3.0;
  for(int i=0; i< stars.size(); i++){
    PVector p = stars.get(i);
    ellipse(p.x,p.y,size,size);
  }
}