import ddf.minim.*;

Minim minim;
AudioPlayer player;

ArrayList<Walker> walks;
ArrayList<WalkerStation> stations;
PVector startPos;
PVector endPos;

int ang = 5;

void settings() {
  size(1000, 800);
}


void setup(){
  walks = new ArrayList<Walker>();
  minim = new Minim(this);
  player = minim.loadFile("let them be infect.mp3");
  
  stations = new ArrayList<WalkerStation>();
  stations.add(new WalkerStation(width/2, height/2));
}

void draw(){
  background(85, 0, 40);

  ////////////////////// logic for walkers
  if(walks.size() != 0){

    // deleting logic
    for (int n = walks.size()-1; n > 0 ; n--) {
      // kill him, if he wants to
      if(walks.get(n).wannaDie()) walks.remove(n);
    }

    
    // move and render
    for (int n = walks.size()-1; n > 0 ; n--) {
      walks.get(n).move();
      walks.get(n).render();
    }

  }

  
  ////////////////////// logic for stations
  if(stations.size() != 0){
    for(WalkerStation s : stations){
      s.update();
      s.render();
    }  
  }
  
   pushMatrix();  
  fill(255,255,30); //<>// //<>// //<>//
  stroke(0);
  strokeWeight(2);
  if(mousePressed){
    line(startPos.x, startPos.y, mouseX, mouseY);
    ellipse(mouseX, mouseY,10,10);
  }
   popMatrix();  

}

////////////////////////////////

void keyPressed(){

  if       (key == 's'){
    
    stations.add(new WalkerStation(mouseX, mouseY));
    
  }else if (key == 'e'){
    
    for(WalkerStation s : stations) s.keyPresed();
    
  }else if (key == 'v'){
    
    if(player.getVolume() == 0.0)  player.setVolume(0.0);
    else                         player.setVolume(1.0);
    
  }
   //<>// //<>// //<>//
  
}

 //<>// //<>// //<>//
void mousePressed(){ //<>// //<>// //<>//
	// GET start!
	startPos = new PVector(mouseX, mouseY);
}


void mouseReleased(){
	// GET end!
	endPos = new PVector(mouseX, mouseY);

	// get proper angle
	int ang = (int)atan2(endPos.y - startPos.y, endPos.x - startPos.x);

	// and create Walker with this angle
  walks.add(new Walker(
      mouseX,              // x
      mouseY,              // y
      18,                  // trailLenght
      2,                   // scaleSize
      2,                   // trailSpace
      ang,                 // angle
      10,                  // radius
      color(38,174,70),    // stroke_
      4,                   // strokeWidth
      color(49,184,65)   // fill_walker_
    )
  );
  
  playsSound();
	
}

void playsSound(){
  player.rewind();
  player.play();
}