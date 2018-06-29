//----------------------------------------------------------
// Section class
//----------------------------------------------------------

class Section {
  // fields
  float x, y, size;
  ArrayList<Bullet> sBullets;
  BulletEmitter emitter;
  ParticleSystem ps;
  boolean destroyed;
  boolean useless;
  
  Section(float x, float y){
    this.x = x;
    this.y = y;
    this.size = 100;
    sBullets = new ArrayList<Bullet>();
    emitter = new BulletEmitter();
    ps = new ParticleSystem(x,y,30, new color[]{color(255,255,0),color(255,100,0),color(255,200,0)});
  }
  
  void display(){
    fill(0,255,0);
    ellipse(x,y,size,size);
  }
  
  void update(){
    // shoot at player within range
    if(withinShootingRange()){
       emitter.at_player(sBullets, new float[]{x,y}, 12.0, 5.0, millis()/100);
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
    
    // clear out of collided and out-of-range bullets
    sBullets.removeAll(clearList);
    
    // explosion
    ps.update();
    
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
    sfx.get("section").play(1.0,0.0,0.5);
    ps.act();
    x = 10000.0;
    y = 10000.0;
  }

}