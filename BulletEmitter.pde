//----------------------------------------------------------
// BulletEmitter class
//----------------------------------------------------------

class BulletEmitter {
  float bulletPause;
  
  BulletEmitter(){
    bulletPause = 0.0;
  }
  
  void at_player(ArrayList<Bullet> list, float[] loc, float speed, float frequency, float rate){
    if (rate > bulletPause+frequency){
      float x = loc[0];
      float y = loc[1];
      float delta_x = player.x - x;
      float delta_y = player.y - y;
      float angle = (float)atan2(delta_y, delta_x);
      list.add(new Bullet(x, y, 20.0, speed, angle, color(255,0,0)));
      bulletPause = rate;
    }
  }
  
  void direction_player_is_facing(ArrayList<Bullet> list, float[] loc, float speed, float frequency, float rate){
    if (rate > bulletPause+frequency){
      String direction = player.dirFlag;
      float x = loc[0];
      float y = loc[1];
      float angle = 0.0;
      switch(direction){
        case "w":
          angle = 3.0*PI/2.0;
          break;
        case "a":
          angle = PI;
          break;
        case "s":
          angle = PI/2.0;
          break;
        case "d":
          angle = 0.0;
          break;
      }
      //println(direction+ " " + angle);
      list.add(new Bullet(x, y, 10.0, speed, angle, color(255,255,255)));
      bulletPause = rate;
    }
  }
  
}