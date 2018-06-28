//----------------------------------------------------------
// Torus class
//   the seamless wrapping world is toroidal and the Torus
//   class is used to manage 9 zones of the game to 
//   establish the effect.
//----------------------------------------------------------


class Torus {
  /*Zone A = new Zone();
  Zone B = new Zone();
  Zone C = new Zone();
  Zone D = new Zone();
  Zone E = new Zone(); // golden
  Zone F = new Zone();
  Zone G = new Zone();
  Zone H = new Zone();
  Zone I = new Zone();*/
  ArrayList<Zone> zones = new ArrayList<Zone>();
  Torus(){
  
  }
  
  // generates the objects on the 
  // the world map and assigns those
  // objects to a zone
  void generateMap(){
  
  }
  
  void update(){
    for(int i=0; i<zones.size(); i++){
      Zone current = zones.get(i);
      current.update();
    }
  }
  
  void display(){
    for(int i=0; i<zones.size(); i++){
      Zone current = zones.get(i);
      current.display();
    }
  }
  
}


//----------------------------------------------------------
// Zone class
//   There are 9 zones, 8 of which control another mirrored
//   side of the map. The "golden zone" is the middle area
//   of the map (E) where the camera AABB doesn't intersect
//   with the 4 map edges. The other 8 zones reflect a 
//   a mirrored copy to create a buffer zone around the map
//
//   basic visualization of the concept:
//   ________________ 
//   |A|     B    |C|
//   |_|__________|_|
//   | |  |    |  | |     
//   | |----------| |
//   | |  |    |  | |
//   |D|  |  E |  |F|
//   | |  |    |  | |
//   | |----------| |
//   | |  |    |  | |
//   |-|----------|-|
//   |G|    H     |I|
//   ----------------
//
//   Advantage: Each zone can manage it's own collision
//     so collision only needs to be calculated if the player
//     is within that zone, which makes up for the mirrored
//     copy objects that are added.
//
//----------------------------------------------------------
class Zone {
  
  // AABB bounds arrays
  float[] real_bounds = new float[4];
  float[] mirr_bounds = new float[4];
  
  // motionless objects
  ArrayList<SpaceStation> ss = new ArrayList<SpaceStation>();
  ArrayList<Mine> mines = new ArrayList<Mine>();
  ArrayList<PVector> stars = new ArrayList<PVector>();
  
  // moving objects
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Formation> forms = new ArrayList<Formation>();
  
  Zone(float x, float y, float w, float h, float x_offset, float y_offset, float mw, float mh){
    real_bounds[0] = x;
    real_bounds[1] = y;
    real_bounds[2] = w;
    real_bounds[3] = h;
    mirr_bounds[0] = x + x_offset;
    mirr_bounds[1] = y + y_offset;
    mirr_bounds[2] = mw;
    mirr_bounds[3] = mh;
  }
  
  void update(){
  
  }
  
  void display(){
  
  }
  
}