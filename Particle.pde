//----------------------------------------------------------
// Particle class
//----------------------------------------------------------

import java.util.Random;

class Particle {
  float x, y, size, fade, lifeSpan;
  color c;
  PVector pos, vel;
  
  Particle(float x, float y, float size, float fade, color[] colors){
    this.x = x;
    this.y = y;
    this.size = size; 
    this.fade = fade;
    lifeSpan = 255.0;
    pos =  new PVector(x, y);
    vel = new PVector(random(-2.2, 2.2), random(-2.2, 2.2));
    Random generator = new Random();
    int randomIndex = generator.nextInt(colors.length);
    c = colors[randomIndex];
  }
  
  void update(){
    pos.add(vel);
    lifeSpan-=fade;
  }
  
  void display(){
    fill(c,lifeSpan);
    ellipse(pos.x, pos.y, size, size);
  }
  
  void execute(){
    update();
    display();
  }
  
  boolean isDead() {
    if(lifeSpan<0){
      return true;
    } else {
      return false;
    }
  }
  
}