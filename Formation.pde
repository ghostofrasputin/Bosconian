//----------------------------------------------------------
// Formation class
//----------------------------------------------------------

import java.util.Arrays;

class Formation {
  float x, y;
  ArrayList<Boid> boids;
  
  Formation(String type, float x, float y){
    this.x = x;
    this.y = y;
    boids = new ArrayList<Boid>();
    switch(type){
      case "squadron":
        createSquadron();
        break;
      case "vic":
        break;
      case "arrow":
        break;
    }
  }
  
  void update(){
    for(int i=0; i<boids.size(); i++){
      boids.get(i).update(boids);
    }
  }
  
  void display(){
    for(int i=0; i<boids.size(); i++){
      boids.get(i).display();
    }
  }
  
  //    B    (1)
  //  B B B  (2,3,4)
  //    B    (5)
  // (card 5 formation)
  void createSquadron(){
    /*Boid b1 = new Boid("I-Type",x,y-50);
    Boid b2 = new Boid("I-Type",x-50,y);
    Boid b3 = new Boid("I-Type",x,y);
    Boid b4 = new Boid("I-Type",x+50,y);
    Boid b5 = new Boid("I-Type",x,y+50);
    boids = new ArrayList<Boid>(Arrays.asList(new Boid[]{b1,b2,b3,b4,b5}));*/
    for(int i=0; i<100; i++){
      boids.add(new Boid("I-Type",random(x-1000,x+1000),random(y-1000,y+1000)));
    }
  }
  
  
}