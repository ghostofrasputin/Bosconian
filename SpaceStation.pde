//----------------------------------------------------------
// SpaceStation class
//----------------------------------------------------------

class SpaceStation {
  // fields
  private int x,y;
  ArrayList<Section> sections;
  private boolean position;
  private boolean destroyed=false;
  int[] ffData;
  // constructor
  SpaceStation(boolean pos, int x, int y){
    position = pos;
    this.x = x;
    this.y = y;
    ffData = new int[3];
    ffData[0] = x;
    ffData[1] = y;
    ffData[2] = 100;
    sections = new ArrayList<Section>();
    // space station with vertical openings:
    if(position == true){
      int xdist = 100;
      int ydist = 150;
      int oDist = 175;
      Section topLeft = new Section(x-xdist,y-ydist);
      sections.add(topLeft);
      Section topRight = new Section(x+xdist,y-ydist);
      sections.add(topRight);
      Section midLeft = new Section(x-oDist,y);
      sections.add(midLeft);
      Section midRight = new Section(x+oDist,y);
      sections.add(midRight);
      Section botLeft = new Section(x-xdist,y+ydist);
      sections.add(botLeft);
      Section botRight = new Section(x+xdist,y+ydist);
      sections.add(botRight);
      Section powerCore = new Section(x,y);
      sections.add(powerCore);
    } 
    // space station with vertical openings:
    else{
      int xdist = 100;
      int ydist = 150;
      int oDist = 175;
      Section topLeft = new Section(x-ydist,y-xdist);
      sections.add(topLeft);
      Section topRight = new Section(x+ydist,y-xdist);
      sections.add(topRight);
      Section midTop = new Section(x,y-oDist);
      sections.add(midTop);
      Section midBot = new Section(x,y+oDist);
      sections.add(midBot);
      Section botLeft = new Section(x-ydist,y+xdist);
      sections.add(botLeft);
      Section botRight = new Section(x+ydist,y+xdist);
      sections.add(botRight);
      Section powerCore = new Section(x,y);
      sections.add(powerCore);
    }  
  }
  //draws the inital space station
  void display(){
    // protective ring of power core:
    if(sections.size() > 1){
      fill(255,0,0,135);
      ellipse(x, y, 200, 200);
      fill(0);
      ellipse(x,y,150,150);
      noStroke();
    }
    for(int i=0; i<sections.size();i++){
      Section current = sections.get(i);
      current.display();
    }
  }
  void update(){
    //update hud score if ss is destroyed:
    if(sections.size()==0 && destroyed==false){
      oneUp+=1000;
      if(oneUp>highscore){
        highscore+=1000;
      }
      destroyed = true;
    }
    for(int i=0; i<sections.size();i++){
      Section current = sections.get(i);
      current.update();
    }
  }
  // helper functions
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
}