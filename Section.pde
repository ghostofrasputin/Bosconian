//----------------------------------------------------------
// Section class - creates a section, a space station
// needs 6
//----------------------------------------------------------

class Section {
  // fields
  private int x,y,size;
  ArrayList<Bullet> sBullets;
  // constructor
  Section(int x, int y){
    this.x = x;
    this.y = y;
    this.size = 100;
    sBullets = new ArrayList<Bullet>();
  }
  void display(){
    fill(0,255,0);
    ellipse(x,y,size,size);
  }
  void update(){
    // shoot at player within range
    if(withinShootingRange(x,y) /**&& Math.random() < 0.1*/){
       Bullet sb = new Bullet("enemy",x, y);
       sBullets.add(sb);
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
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  int getS(){
    return size;
  }
  
  // checks if player is within shooting range of a SS section
  private boolean withinShootingRange(int x, int y){
    int range = 600;
    int xDist = abs(player.getX() - x);
    int yDist = abs(player.getY() - y);
    if (xDist < range && yDist < range){
      return true;
    }
    return false;
  } 

}