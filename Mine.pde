//----------------------------------------------------------
// Mine class
//----------------------------------------------------------

class Mine {
  float x, y, size, rad, side;
  boolean isDead;
  ParticleSystem ps;
  
  Mine(float x, float y){
    this.x = x;
    this.y = y;
    size = 40.0;
    rad = size/2;
    side = 10;
    ps = new ParticleSystem(x,y,10,new color[]{color(255,255,0),color(255,100,0),color(255,200,0)});
    isDead = false;
  }
  
  void display(){
    sprite();
  }
  
  void sprite(){
    if(!isDead){
      fill(10,100,200);
      ellipse(x,y,size,size);
      fill(200,0,0);
      triangle(x,y-size,x-side,y-rad,x+side,y-rad);
      triangle(x,y+size,x-side,y+rad,x+side,y+rad);
      triangle(x-size,y,x-rad,y-side,x-rad,y+side);
      triangle(x+size,y,x+rad,y-side,x+rad,y+side);
    } else {
      if(ps.isActing()){
        ps.update();
      } else {
        mines.remove(this);
      }
    }
  }
  
  void explode(){
    isDead = true;
    x = 10000;
    y = 10000;
    ps.setFade(15);
    ps.act();
  }
 
}