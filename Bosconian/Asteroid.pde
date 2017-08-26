//----------------------------------------------------------
// Asteroid class
//----------------------------------------------------------

class Asteroid {
  float x,y,size;
  
  Asteroid(float x, float y){
    this.x = x;
    this.y = y;
    this.size = 55.0;
  }
  
  void update(){
    // check player collision
  }
  
  void display(){
    sprite();
  }
  
  void sprite(){
    fill(191,126,56);
    ellipse(x,y,size,size);
  }
}