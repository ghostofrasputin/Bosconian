//----------------------------------------------------------
// Bullet class - creates bullet objects that the player
// can shoot
//----------------------------------------------------------

class Bullet {
  // fields
  int x, y, x2, y2;
  private String type = "";
  //int w,h;
  private int bulletSpeed;
  private String bDir;
  private float easingAmount = .01; //interesting effects: .01
  private boolean flag = false;
  private int[] dists;
  // constructor
  Bullet(String type, int x, int y){
    this.x = this.x2 = x;
    this.y = this.y2 = y;
    this.bulletSpeed = 15;
    this.bDir = player.getDir();
    this.type = type;
    dists = new int[2];
  }
  // fucntions:
  void display(){
    fill(255);
    if(type=="enemy"){
      fill(255,0,0);
    }    
    ellipse(x,y,10,10); 
  }
  void update(){
    if(type == "enemy"){
      if(flag == false){
        int xDist = player.getX() - x;
        int yDist = player.getY() - y;
        dists[0] = xDist;
        dists[1] = yDist;
        flag = true;
      }
      x += dists[0] * easingAmount;
      y += dists[1] * easingAmount;
    }  
    else{
      switch(bDir){
      case "w":
          y-=bulletSpeed;
          //y2+=bulletSpeed;
          break;
        case "a":
          x-=bulletSpeed;
          //x2+=bulletSpeed;
          break;
        case "s":
          y+=bulletSpeed;
          //y2-=bulletSpeed;
          break;
        case "d":
          x+=bulletSpeed;
          //x2-=bulletSpeed;
          break;
     }
   } 
  }
}