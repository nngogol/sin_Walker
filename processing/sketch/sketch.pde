import ddf.minim.*;

Minim minim;
AudioPlayer player;

ArrayList<Walker> walks;
ArrayList<WalkerStation> stations;
PVector startPos;
PVector endPos;

int ang = 5;
int adding_walker_Speed = 160;

boolean enableRandomWalkerSpawn = true;

void settings() {
  size(1000, 800);
}

void setup(){
  walks = new ArrayList<Walker>();
  stations = new ArrayList<WalkerStation>();
  stations.add(new WalkerStation(width/2, height/2, player));
  minim = new Minim(this);
  player = minim.loadFile("let them be infect.mp3");
}

void draw(){
  background(72);

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
  
  
}


////////////////////////////////

void keyPressed(){

  switch (key) { //<>//
    // s for station
    case 's':
      stations.add(new WalkerStation(mouseX, mouseY, player));
    break;
    
    // e for enable\disable
    case 'e':
      for(WalkerStation s : stations){
        s.keyPresed();
      }
    break;
  
    default: break;
  }
  
}


void mousePressed(){
	// GET start!
	startPos = new PVector(mouseX, mouseY);
}

void playSound__(){
  if ( !player.isPlaying() )
      {
        player.play();
      }else{
        player.pause();
        player.rewind();
        player.play();
      }
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
      color(0,160,255),    // stroke_
      4,                   // strokeWidth
      color(180,255,255)   // fill_walker_
    )
  );
  
  playSound__();
	
}