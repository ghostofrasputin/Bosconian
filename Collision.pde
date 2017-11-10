//----------------------------------------------------------
// Collision system
//----------------------------------------------------------

// checks bullet collision with sections, forcefields,
// mines, 
boolean playerBulletCollision(Bullet bullet){
  // bullet circle stuff
  float bulX = bullet.x;
  float bulY = bullet.y;
  int bulR = 10;
  
  // run through all the space stations in the level
  for(int i=0; i<ss.size(); i++){
    SpaceStation temp = ss.get(i);
    ArrayList<Section> sections = temp.sections;
    // run through all the sections of that space station
    for(int j=0; j<sections.size();j++){
      Section sTemp = sections.get(j);
      // section circle stuff
      float secX = sTemp.x;
      float secY = sTemp.y;
      float secR = sTemp.size/2;
      // forcefield stuff
      float ffDX = temp.ffData[0];
      float ffDY = temp.ffData[1];
      float ffDR = temp.ffData[2];
      
      // collision check bullet and sections:
      if(((bulX-secX)*(bulX-secX) + (bulY-secY)*(bulY-secY)) <= ((bulR+secR)*(bulR+secR))){
        // last section
        if(temp.count==1){
          sTemp.destroy();
          temp.count--;
          numDestroyed++;
        } 
        // if there are more than one section
        if(temp.count>1){
          sTemp.destroy();
          temp.count--;
        }
        return true;
      }
      // collision check bullet and force field:
      if(((bulX-ffDX)*(bulX-ffDX) + (bulY-ffDY)*(bulY-ffDY)) <= ((bulR+ffDR)*(bulR+ffDR))){
        if(temp.count>1){
          return true;
        }
      }  
    }
  }
  
  // collision check bullet and mines:
  for(int i=0; i<mines.size(); i++){
     Mine m = mines.get(i);
     float mX = m.x;
     float mY = m.y;
     int mRad = 35; // bounding circle is 70 diameter
     if(((bulX-mX)*(bulX-mX) + (bulY-mY)*(bulY-mY)) <= ((bulR+mRad)*(bulR+mRad))){
       m.explode(); 
       return true;
      }
  }
  
  return false;
}

// checks ship collision with sections, forcefields, enemy bullets,
// mines, 
void shipCollision(){
    float plyX = player.x-29;
    float plyY = player.y-21;
    int plyW = 65;
    int plyH = 47;
   
    // DEBUG: bounding box:
    //rect(plyX,plyY,plyW,plyH);
    
    for(int i=0; i<ss.size(); i++){
      SpaceStation temp = ss.get(i);
      ArrayList<Section> sections = temp.sections;
      // run through all the sections of that space station
      for(int j=0; j<sections.size();j++){
        Section sTemp = sections.get(j);
        // player rect stuff
        
        // section circle stuff
        float secX = sTemp.x;
        float secY = sTemp.y;
        float secR = sTemp.size/2;
        // forcefield stuff
        float ffDX = temp.ffData[0];
        float ffDY = temp.ffData[1];
        float ffDR = temp.ffData[2];
        // collison check sections and player
        float distX = abs(secX - plyX-plyW/2);
        float distY = abs(secY - plyY-plyH/2);
        float dx=distX-plyW/2;
        float dy=distY-plyH/2;
        if (dx*dx+dy*dy<=(secR*secR)){
          //numLives--;
        }
        //collision check forcefield and player
        //only check when forcefield is up
        if(temp.count>1){
          float distX2 = abs(ffDX - plyX-plyW/2);
          float distY2 = abs(ffDY - plyY-plyH/2);
          float dx2=distX2-plyW/2;
          float dy2=distY2-plyH/2;
          if (dx2*dx2+dy2*dy2<=(ffDR*ffDR)){  
            //numLives--;
          }
        }
        // collison check bullets and player
        for(int k=0; k<sTemp.sBullets.size();k++){
          Bullet tempBullet = sTemp.sBullets.get(k);
          // enemy bullet circle stuff
          float bulX = tempBullet.x;
          float bulY = tempBullet.y;
          int bulR = 10;
          float distX3 = abs(bulX - plyX-plyW/2);
          float distY3 = abs(bulY - plyY-plyH/2);
          float dx3=distX3-plyW/2;
          float dy3=distY3-plyH/2;
          if (dx3*dx3+dy3*dy3<=(bulR*bulR)){
            //numLives--;
          }
        }  
     }
   }
   // collision check mines and player
   for(int i=0; i<mines.size(); i++){
     Mine m = mines.get(i);
     float mX = m.x;
     float mY = m.y;
     int mRad = 35; // bounding circle is 70 diameter
     float distX = abs(mX - plyX-plyW/2);
     float distY = abs(mY - plyY-plyH/2);
     float dx = distX-plyW/2;
     float dy = distY-plyH/2;
     if (dx*dx+dy*dy<=(mRad*mRad)){
       m.explode();
       player.die();
       break;
     }
   }
   
}

// makes sure mines dont spawn on
// player or space stations
boolean mineCollision(Mine m){
  // player bounding area so no
  // mines kill player on start
  float pX = player.x-300;
  float pY = player.y-300;
  int pW = 600;
  int pH = 600;
  // mine stuff
  float mX = m.x;
  float mY = m.y;
  int mRad = 40; // bounding circle is 70 diameter
  float distX = abs(mX - pX-(pW/2));
  float distY = abs(mY - pY-(pH/2));
  float dx = distX-(pW/2);
  float dy = distY-(pH/2);
  
  if (distX <= (pW/2)) { 
    return true; 
  } 
  if (distY <= (pH/2)) { 
    return true; 
  }
  // player mine collision:
  if (dx*dx+dy*dy<=(mRad*mRad)){
    return true;
  }
  
  // space station mine collision:
  for(int i=0; i<ss.size(); i++){
    SpaceStation s = ss.get(i);
    float sX = s.x;
    float sY = s.y;
    float sRad = 300;
    if(((sX-mX)*(sX-mX) + (sY-mY)*(sY-mY)) <= ((sRad+mRad)*(sRad+mRad))){
      return true;
    }
  }
  
  // existing mines collision:
  for(int i=0; i<mines.size(); i++){
    Mine m2 = mines.get(i);
    float mX2 = m2.x;
    float mY2 = m2.y;
    if(((mX2-mX)*(mX2-mX) + (mY2-mY)*(mY2-mY)) <= ((mRad+mRad)*(mRad+mRad))){
      return true;
    }
  }
  
  return false;
}