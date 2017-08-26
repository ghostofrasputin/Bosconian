//----------------------------------------------------------
// Ship class
//----------------------------------------------------------

class Ship {
  // fields
  float x, y, speed;
  String dirFlag;
  BulletEmitter emitter;
  
  Ship(float x, float y){
    this.x = x;
    this.y = y;
    this.dirFlag = "w";
    this.speed = 5;
    emitter = new BulletEmitter();
  }
  
  void update(){
    
    // Fire Bullets!!!
    if(keyInput.get('o')){
      emitter.direction_player_is_facing(bullets, new float[]{x,y}, 2*player.speed, 1.0, millis()/100);
    }
      
    // north
    if(keyInput.get('w') || dirFlag == "w"){
      y-=speed;
      dirFlag = "w";
    }
    //west
    if(keyInput.get('a') || dirFlag == "a"){
      x-=speed;
      dirFlag = "a";
    }
    // south
    if(keyInput.get('s') || dirFlag == "s"){
      y+=speed;
      dirFlag = "s";
    }
    // east
    if(keyInput.get('d') || dirFlag == "d"){
      x+=speed;
      dirFlag = "d";
    }  
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
  
}