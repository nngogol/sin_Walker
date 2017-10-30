import ddf.minim.*;

Minim minim;
AudioPlayer player;

ArrayList<Walker> walks;
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
  minim = new Minim(this);
  player = minim.loadFile("ILLUMINATI_2.mp3");
}

void draw(){
  background(72);

  addingWalkers();

  // deleting old walkers
  for (int n = walks.size()-1; n > 0 ; n--) {
    if(walks.get(n).wannaDie())
      walks.remove(n);
  }
  
  // moveit moveit
  for(int i = 0; i < walks.size()-1; i++){
    walks.get(i).move();
    walks.get(i).render();
  }
    
}


////////////////////////////////

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

void addingWalkers(){
  if(!enableRandomWalkerSpawn){
    return;
  }

    // adding angle
    ang+=1;
    if(ang == 360){
      ang = 1;
    }
  
    // adding walker
    if(frameCount % adding_walker_Speed == 1){
      //walks.push(new Walker(width/2, height/2, trailLenght, scaleSize, trailSpace, ang, radius, strokeColor))
      
      
      walks.add(new Walker(
          width/2,             // x
          height/2,            // y
          15,                  // trailLenght
          5,                   // scaleSize
          14,                   // trailSpace
          ang,                 // angle
          8,                  // radius
          color(250,1,30),    // stroke_
          1,                   // strokeWidth
          color(19,221,219)   // fill_walker_
        )
      );

      playSound__();
      
    }

    
    
  
    //drawing center point
    stroke(252);
    fill(
      floor(sin(frameCount*.05)      *100+100),
      floor(cos(frameCount*.04)      *20 +100),
      floor(sin((frameCount+150)*.04)*80 +130)
    );
    
    ellipse(width/2, height/2, width/32, width/32);
}