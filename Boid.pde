//----------------------------------------------------------
// Boid class
// heavily based on Daniel Shiffman's Flocking code
// Source: https://processing.org/examples/flocking.html
//----------------------------------------------------------

class Boid {
  float r, speed, force;
  String type;
  PVector pos, vel, acc;
  
  Boid(String type, float x, float y){
    pos = new PVector(x,y);
    vel = PVector.random2D();
    acc = new PVector(0,0);
    switch(type){
      // Eich Missiles
      case "I-Type":
        r = 13.0;
        speed = 10;
        force = 0.03;
        break;
      // Ploor Missiles
      case "P-Type":
        break;
      // Eddore Missiles 
      case "E-Type":
        break;  
      // Spy Ship
      case "S-Type":
        break;
    }
  }
  
  void update(ArrayList<Boid> boids){
    flock(boids);
    vel.add(acc);
    vel.limit(speed);
    pos.add(vel);
    acc.mult(0);
  }
  
  void display() {
    float theta = vel.heading() + radians(90);
    
    fill(255,0, 0);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void flock(ArrayList<Boid> boids){
    PVector sep = separation(boids);
    PVector ali = alignment(boids);
    PVector coh = cohesion(boids);
    PVector tar = target(new PVector(player.x,player.y));
    sep.mult(5.5);
    ali.mult(1.0);
    coh.mult(1.0);
    tar.mult(4.0);
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
    applyForce(tar);
  }
  
  PVector separation(ArrayList<Boid> boids){
    float separation = 100.0;
    PVector steer = new PVector(0,0);
    float count = 0.0;
    for(int i=0; i<boids.size(); i++){
      Boid b = boids.get(i);
      float dist = PVector.dist(pos, b.pos);
      if(dist > 0 && dist < separation){
        PVector diff = PVector.sub(pos, b.pos);
        diff.normalize();
        diff.div(dist);
        steer.add(diff);
        count += 1.0;
      }
    }
    if(count > 0.0){
        steer.div(count);
    }
    if(steer.mag() > 0){
      steer.normalize();
      steer.mult(speed);
      steer.sub(vel);
      steer.limit(force);
    }
    return steer;
  }
  
  PVector alignment(ArrayList<Boid> boids){
    float neighborDist = 50.0;
    PVector sum = new PVector(0,0);
    float count = 0.0;
    for(int i=0; i<boids.size(); i++){
      Boid b = boids.get(i);
      float dist = PVector.dist(pos,b.pos);
      if( dist > 0 && dist < neighborDist){
        sum.add(b.vel);
        count += 1.0;
      }
    }
    if (count > 0.0){
      sum.div(count);
      sum.normalize();
      sum.mult(speed);
      PVector steer = PVector.sub(sum, vel);
      steer.limit(force);
      return steer;
    } else {
      return new PVector(0,0);
    }
  }
  
  PVector cohesion(ArrayList<Boid> boids){
    float neighborDist = 50.0;
    PVector sum = new PVector(0,0);
    float count = 0.0;
    for(int i=0; i<boids.size(); i++){
      Boid b = boids.get(i);
      float dist = PVector.dist(pos,b.pos);
      if( dist > 0 && dist < neighborDist){
        sum.add(b.pos);
        count += 1.0;
      }
    }
    if (count > 0.0){
      sum.div(count);
      return seek(sum);
    } else {
      return new PVector(0,0);
    }
  }
  
  PVector seek(PVector tar){
    PVector targetDirection = PVector.sub(tar, pos);
    targetDirection.normalize();
    targetDirection.mult(speed);
    PVector steer = PVector.sub(targetDirection, vel);
    steer.limit(force);
    return steer;
  }
  
  PVector target(PVector p){
    PVector targetDirection = PVector.sub(p, pos);
    targetDirection.normalize();
    targetDirection.mult(speed);
    PVector steer = PVector.sub(targetDirection, vel);
    steer.limit(force);
    return steer;
  }
  
}