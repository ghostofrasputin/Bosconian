//----------------------------------------------------------
// ParticleSystem class
//----------------------------------------------------------

class ParticleSystem {
  int num, count;
  float x, y, fade;
  boolean activate;
  ArrayList<Particle> particles;
  
  ParticleSystem(float x, float y, int num){
    this.x = x;
    this.y = y;
    this.num = num;
    particles = new ArrayList<Particle>();
    count = 0;
    activate = false;
    fade = random(7,10);
  }
  
  void update(){
    if(activate) {
      if(count<num){
        particles.add(new Particle(x, y, random(30,50), fade));
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
  
  void setFade(float f){
    fade = f;
  }
  
  
}