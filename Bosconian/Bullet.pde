//----------------------------------------------------------
// Bullet class
//----------------------------------------------------------

class Bullet {
  // fields
  float x, y, size, speed, angle;
  color col;
  boolean offScreen;
  
  // constructor
  Bullet(float x, float y, float size, float speed, float angle, color col){
    this.x = x;
    this.y = y;
    this.size = size;
    this.speed = speed;
    this.angle = angle;
    this.col = col;
    this.offScreen = false;
  }

  void update(){
    x += Math.cos(angle)*speed;
    y += Math.sin(angle)*speed;
    //x %= mapWidth;
    //y %= mapHeight;
  }
  
  void display(){
    fill(col);    
    ellipse(x,y,size,size); 
  }
  
}