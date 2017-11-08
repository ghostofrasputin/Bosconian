//----------------------------------------------------------
// Section class
//----------------------------------------------------------

class Section {
  // fields
  float x, y, size;
  ArrayList<Bullet> sBullets;
  BulletEmitter emitter;
  boolean destroyed;
  boolean useless;
  
  Section(float x, float y){
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
    if(withinShootingRange()){
       emitter.at_player(sBullets, new float[]{x,y}, 4.0, 2.0, millis()/100);
    }
   
   // animate bullets
   ArrayList<Bullet> clearList = new ArrayList<Bullet>();
   for(int i=0; i<sBullets.size(); i++){
      Bullet b = sBullets.get(i);
      if(!outOfRange(b.x,b.y)){
        b.display();
        b.update();
      } else {
        clearList.add(b);
      }
    }
    
    // clear bullets that collided
    for(int i=0; i< clearList.size(); i++){
      Bullet b = clearList.get(i);
      sBullets.remove(b);
    }
    
  }
  
  // checks if player is within shooting range of a SS section
  boolean withinShootingRange(){
    float range = 775.0;
    float xDist = abs(player.x - x);
    float yDist = abs(player.y - y);
    return xDist < range && yDist < range;
  }
  
  // checks to see if bullet should be removed
  // if too far away, for efficency
  boolean outOfRange(float x, float y){
    float range = 1000.0;
    float xDist = abs(player.x - x);
    float yDist = abs(player.y - y);
    return xDist > range || yDist > range;
  }
  
  void destroy(){
    // explosion code HERE:
    x = Float.POSITIVE_INFINITY;
    y = Float.POSITIVE_INFINITY;
  }

}