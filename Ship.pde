//----------------------------------------------------------
// Ship class
//----------------------------------------------------------

class Ship {
  // fields
  float x, y, speed;
  String dirFlag;
  BulletEmitter emitter;
  ParticleSystem ps;
  
  Ship(float x, float y){
    this.x = x;
    this.y = y;
    this.dirFlag = "w";
    this.speed = 10;
    emitter = new BulletEmitter();
    ps = new ParticleSystem(x,y,30,new color[]{color(255,255,0),color(255,100,0),color(255,200,0)});
  }
  
  void update(){
    shipCollision();
    
    // Fire Bullets!!!
    if(keyInput.get('o')){
      emitter.direction_player_is_facing(bullets, new float[]{x,y}, 2.5*player.speed, 1.0, millis()/100);
    }
    
    // Drop Bombs
    if(keyInput.get('p')){
      emitter.bomb_behind(bombs, new float[]{x,y}, 1.2*player.speed, 1.0, millis()/100);
    }
    
    // Animate bullets 
    ArrayList<Bullet> clearList = new ArrayList<Bullet>();
    for(int i=0; i<bullets.size(); i++){
      Bullet b = bullets.get(i);
      if(b.y > (player.y-len) && b.y < (player.y+len) &&
         b.x > (player.x-len) && b.x < (player.x+len)){
           b.display();
           b.update();
           if(playerBulletCollision(b)){
             clearList.add(b);
           }
      } else{
          clearList.add(b);
      }
    }
    
    // Animate Bombs
    // Animate bullets 
    ArrayList<Bomb> clearList2 = new ArrayList<Bomb>();
    for(int i=0; i<bombs.size(); i++){
      Bomb b = bombs.get(i);
      if(b.y > (player.y-len) && b.y < (player.y+len) &&
         b.x > (player.x-len) && b.x < (player.x+len)){
           b.display();
           b.update();
           // note: no collision yet
      } else{
          clearList2.add(b);
      }
    }
    
    // clear bullets that collided
    bullets.removeAll(clearList);
    
    // set direction:
    if(keyInput.get('w'))
      dirFlag = "w";
    if(keyInput.get('a'))
      dirFlag = "a";
    if(keyInput.get('s'))
      dirFlag = "s";
    if(keyInput.get('d'))
      dirFlag = "d";  
    
    // north
    if(dirFlag == "w")
      y-=speed;
    //west
    if(dirFlag == "a")
      x-=speed;
    // south
    if(dirFlag == "s")
      y+=speed;
    // east
    if(dirFlag == "d")
      x+=speed;
    
    ps.update();  
  }
  
  void display(){
    noStroke();
    rectMode(CENTER);
    pushMatrix();
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
    popMatrix();
    rectMode(CORNER);
  }
  
  // private function that draws ship sprite
  void shipSprite(){
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
  
  void die(){
    numLives--;
    ps.setXY(x,y);
    ps.act();
    if(numLives == 0){
      
    }
  }
  
}