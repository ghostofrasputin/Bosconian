//----------------------------------------------------------
// ParticleSystem class
//----------------------------------------------------------

class ParticleSystem {
  int num, count;
  float x, y;
  boolean activate;
  ArrayList<Particle> particles;
  
  ParticleSystem(float x, float y, int num){
    this.x = x;
    this.y = y;
    this.num = num;
    particles = new ArrayList<Particle>();
    count = 0;
    activate = false;
  }
  
  void update(){
    if(count<num){
      particles.add(new Particle(x, y, random(30,50), random(7,10)));
    }
    if(activate) {
      ArrayList<Particle> clearList = new ArrayList<Particle>();
      if(particles.isEmpty()){
        activate = false;
      } else {
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
}