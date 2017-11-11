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
    switch(type){
      // Eich Missiles
      case "I-Type":
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
  
  void update(){
  
  }
  
  void display() {
  
  }
  
  void applyForce(PVector force){
  
  }
  
  void flock(ArrayList<Boid> boids){
  
  }
  
  void seek(ArrayList<Boid> boids){
  
  }
  
  void seperation(ArrayList<Boid> boids){
  
  }
  
  void alignment(ArrayList<Boid> boids){
  
  }
  
  void cohesion(ArrayList<Boid> boids){
  
  }
  
}