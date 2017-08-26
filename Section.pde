//----------------------------------------------------------
// Section class
//----------------------------------------------------------

class Section {
  // fields
  float x,y,size;
  ArrayList<Bullet> sBullets;
  BulletEmitter emitter;
  // constructor
  Section(int x, int y){
    this.x = x;
    this.y = y;
    this.size = 100;
    sBullets = new ArrayList<Bullet>();
    emitter = new BulletEmitter();
  }
  void display(){
    fill(0,255,0);
    ellipse(x,y,size,size);
  }
  void update(){
    // shoot at player within range
    if(withinShootingRange(x,y)){
       emitter.at_player(sBullets, new float[]{x,y}, 4.0, 2.0, millis()/100);
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
  
  // checks if player is within shooting range of a SS section
  private boolean withinShootingRange(float x, float y){
    float range = 775.0;
    float xDist = abs(player.x - x);
    float yDist = abs(player.y - y);
    return xDist < range && yDist < range;
  } 

}