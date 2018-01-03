class WalkerStation{
	AudioPlayer soundOfSwawn;
  PVector pos;
	boolean isEnable;
	float radius;
	ArrayList<Walker> walkers;
  int adding_walker_Speed = 60;
  float frame = 0;
  
  WalkerStation(int x, int y, AudioPlayer soundOfSwawn){
		
		this.pos = new PVector(x, y);
		this.isEnable = true;
		this.walkers = new ArrayList<Walker>();
		this.soundOfSwawn = soundOfSwawn;

		this.radius = 16;
	}
	
	void playSSound(){
		if(!soundOfSwawn.isPlaying())
		{
			soundOfSwawn.play();
		}else{
			soundOfSwawn.pause();
			soundOfSwawn.rewind();
			soundOfSwawn.play();
		}
	}
 
	void render(){
    
    // render walkers  
    if(isEnable){
      for(Walker w: walkers){
				w.render();    
      }
    }
  
		//render station
		noStroke();
		stroke(252);

    if(isEnable){
      fill(
        floor(sin(frameCount*.05)      *100+100),
        floor(cos(frameCount*.04)      *20 +100),
        floor(sin((frameCount+150)*.04)*80 +130)
      );
    }else{
      noFill();
    }
		
		ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
	}

  void update(){
    //////////////// add walker
    if(isEnable){
    
    
            frame+=0.1;
            frame = frame >= TWO_PI ? 0 : frame;
          
            // adding walker
            if(frameCount % adding_walker_Speed == 1){
              this.walkers.add(new Walker(
                this.pos.x,
                this.pos.y,
                frame
							));
							playSSound();
            }
    }
    //////////////// thesame logic as in draw() for walkers
    if(walkers.size() != 0){
          for (int n = walkers.size()-1; n > 0 ; n--) {
            
            // kill him, if he wants to
            if(walkers.get(n).wannaDie())
              walkers.remove(n);
          }
          
          
          for (int n = walkers.size()-1; n > 0 ; n--) {
            
            // move it move it
            walkers.get(n).move();
          }
    }
    
  }

	void switch_ON_OFF(){
		isEnable = !isEnable;
	}

	void keyPresed(){
		if (dist(mouseX, mouseY, this.pos.x, this.pos.y) < this.radius) {
			switch_ON_OFF();
		}
	}

}