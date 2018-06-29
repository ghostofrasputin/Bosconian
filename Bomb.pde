//----------------------------------------------------------
// Bomb class
//----------------------------------------------------------

class Bomb {
  // fields
  float x, y, size, speed, angle;
  color col;
  boolean show, s_flag;
  float[] startPoint;
  ParticleSystem ps;
  
  // constructor
  Bomb(float x, float y, float size, float speed, float angle, color col, boolean s_flag){
    this.x = x;
    this.y = y;
    this.size = size;
    this.speed = speed;
    this.angle = angle;
    this.col = col;
    this.s_flag = s_flag; // 3 bombs deploy, only one makes a sound
    this.show = true;
    startPoint = new float[] {this.x, this.y};
    ps = new ParticleSystem(x,y,50,new color[]{color(0,255,0),color(0,255,100),color(0,255,200)});
  }

  void update(){
    if(show){
      x += Math.cos(angle)*speed;
      y += Math.sin(angle)*speed;
    }

    if( 200 < dist(startPoint[0], startPoint[1], x, y) && show==true){
      if(s_flag){
        sfx.get("bomb").play(1.0,0.0,0.6);
      }
      show = false;
      ps.setXY(x,y);
      ps.setRange(50,50);
      ps.setFade(15);
      ps.act();
    }
    
    if(ps.isActing()==false && show==false){
      bombs.remove(this);
    }
    
    ps.update();
  }
  
  void display(){
    if(show){
      fill(col);    
      ellipse(x,y,size,size);
    }
  }
  
}