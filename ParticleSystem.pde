//----------------------------------------------------------
// ParticleSystem class
//----------------------------------------------------------

class ParticleSystem {
  int num, count, xr, yr;
  float x, y, fade;
  color[] colors;
  boolean activate;
  ArrayList<Particle> particles;
  
  ParticleSystem(float x, float y, int num, color[] colors){
    this.x = x;
    this.y = y;
    this.num = num;
    this.colors = colors;
    particles = new ArrayList<Particle>();
    xr = 0;
    yr = 0;
    count = 0;
    activate = false;
    fade = random(7,10);
  }
  
  void update(){
    if(activate) {
      if(count<num){
        particles.add(new Particle(random(x-xr,x+xr), random(y-yr,y+yr), random(30,50), fade, colors));
      }
      if(particles.isEmpty()){
        activate = false;
        reset();
      } else {
        ArrayList<Particle> clearList = new ArrayList<Particle>();
        for(int i=0; i<particles.size(); i++){
          Particle p = particles.get(i);
          if(p.isDead()){
            clearList.add(p);
          } else {
            p.execute();
          }
        }
        particles.removeAll(clearList);
        count++;
      }
    }
  }
  
  void act(){
    activate = true;
  }
  
  boolean isActing(){
    return activate;
  }
  
  void reset(){
    particles.clear();
    count = 0;
  }
  
  // for moving game objects
  void setXY(float newX, float newY){
    x = newX;
    y = newY;
  }
  
  void setRange(int xRange, int yRange){
    xr = xRange;
    yr = yRange;
  }
  
  void setFade(float f){
    fade = f;
  }
  
  
}