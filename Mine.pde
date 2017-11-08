//----------------------------------------------------------
// Mine class
//----------------------------------------------------------

class Mine {
  float x, y, size, rad, side;
  
  Mine(float x, float y){
    this.x = x;
    this.y = y;
    size = 40.0;
    rad = size/2;
    side = 10;
  }
  
  void update(){
    // check player collision
  }
  
  void display(){
    sprite();
  }
  
  void sprite(){
    fill(10,100,200);
    ellipse(x,y,size,size);
    fill(200,0,0);
    triangle(x,y-size,x-side,y-rad,x+side,y-rad);
    triangle(x,y+size,x-side,y+rad,x+side,y+rad);
    
    triangle(x-size,y,x-rad,y-side,x-rad,y+side);
    triangle(x+size,y,x+rad,y-side,x+rad,y+side);
    
  }
}