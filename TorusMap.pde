//----------------------------------------------------------
// TorusMap class
//   the seamless wrapping world is toroidal and the Torus
//   class is used to manage 9 zones of the game to 
//   establish the effect.
//----------------------------------------------------------


class TorusMap {
  
  ArrayList<Zone> zones;
  
  TorusMap(){
    float xMin = -3045;
    float xMax =  4345;
    float yMin = -5695;
    float yMax =  6695;
    float off = 500;
    float xRange = abs(xMin)+xMax;
    float yRange = abs(yMin)+yMax;
    zones = new ArrayList<Zone>();
    Zone A = new Zone(xMax-off, yMax-off, xMin-off, yMin-off, off, off);
    zones.add(A);
    Zone B = new Zone(xMin, yMax-off, xMin, yMin-off, xRange, off);
    zones.add(B);
    Zone C = new Zone(xMin, yMax-off, xMax, yMin-off, off, off);
    zones.add(C);
    Zone D = new Zone(xMax-off, yMin, xMin-off, yMin, off, yRange);
    zones.add(D);
    Zone E = new Zone(xMin+off, yMin+off, xRange-(2*off), yRange-(2*off));
    zones.add(E);
    Zone F = new Zone(xMin, yMin, xMax, yMin, off, yRange);
    zones.add(F);
    Zone G = new Zone(xMax-off, yMin, xMin-off, yMax, off, off);
    zones.add(G);
    Zone H = new Zone(xMin, yMin, xMin, yMax, xRange, off);
    zones.add(H);
    Zone I = new Zone(xMin, yMin, xMax, yMax, off, off);
    zones.add(I);
  }
  
  // generates the objects on the 
  // the world map and assigns those
  // objects to a zone
  void generateMap(){
    
  }
  
  void assignZone(Zone zone){
    for(int i=0; i<zones.size(); i++){
      //Zone current = zones.get(i);
      
    }
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
  
  // golden zone doesn't need mirror effect
  Zone(float x, float y, float w, float h){
    real_bounds[0] = x;
    real_bounds[1] = y;
    real_bounds[2] = w;
    real_bounds[3] = h;
  }
  
  Zone(float x, float y, float mx, float my, float w, float h){
    real_bounds[0] = x;
    real_bounds[1] = y;
    real_bounds[2] = w;
    real_bounds[3] = h;
    mirr_bounds[0] = mx;
    mirr_bounds[1] = my;
    mirr_bounds[2] = w;
    mirr_bounds[3] = h;
  }
  
  void update(){
  
  }
  
  void display(){
  
  }
  
}