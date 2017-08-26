//----------------------------------------------------------
// Mine class
//----------------------------------------------------------

class Mine {
  float x,y,size;
  
  Mine(float x, float y){
    this.x = x;
    this.y = y;
    this.size = 30.0;
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