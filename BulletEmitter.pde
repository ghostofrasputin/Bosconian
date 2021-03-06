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
      sfx.get("shoot").play(1.0,0.0,0.18);
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
  
  void bomb_behind(ArrayList<Bomb> list, float[] loc, float speed, float frequency, float rate){
    if (rate > bulletPause+frequency){
      //sfx.get("shoot").play(1.0,0.0,0.18);
      String direction = player.dirFlag;
      float x = loc[0];
      float y = loc[1];
      switch(direction){
        case "w":
          list.add(new Bomb(x, y, 30.0, speed, PI/2, color(0,255,0), true));
          list.add(new Bomb(x, y, 30.0, speed, 0.0, color(0,255,0), false));
          list.add(new Bomb(x, y, 30.0, speed, PI, color(0,255,0), false));
          print("fuck");
          break;
        case "a":
          list.add(new Bomb(x, y, 30.0, speed, 0.0, color(0,255,0), true));
          list.add(new Bomb(x, y, 30.0, speed, PI/2, color(0,255,0), false));
          list.add(new Bomb(x, y, 30.0, speed, 3.0*PI/2.0, color(0,255,0), false));
          break;
        case "s":
          list.add(new Bomb(x, y, 30.0, speed, 3.0*PI/2.0, color(0,255,0), true));
          list.add(new Bomb(x, y, 30.0, speed, PI, color(0,255,0), false));
          list.add(new Bomb(x, y, 30.0, speed, 0.0, color(0,255,0), false));
          break;
        case "d":
          list.add(new Bomb(x, y, 30.0, speed, PI, color(0,255,0), true));
          list.add(new Bomb(x, y, 30.0, speed, PI/2, color(0,255,0), false));
          list.add(new Bomb(x, y, 30.0, speed, 3.0*PI/2.0, color(0,255,0), false));
          break;
      }
      
      
      bulletPause = rate;
    }
  }
  
  
}