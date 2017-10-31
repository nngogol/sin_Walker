class WalkerStation{
  PVector pos;
	boolean isEnable;
	float radius;
	ArrayList<Walker> walkers;
  int adding_walker_Speed;
  float frame = 0;
  
  WalkerStation(int x, int y){
		
		this.pos = new PVector(x, y);
		this.isEnable = true;
		this.walkers = new ArrayList<Walker>();
    this.adding_walker_Speed = 20;
    
		this.radius = walkers.size()*2;
	}
	

	void render(){
    
    // render walkers  
    if(isEnable){
      for(Walker w: walkers) w.render();
    }
  
  
		//render station
    pushMatrix();
		noStroke();
    if(isEnable) fill( floor(sin(frameCount*.05)      *100+100), floor(cos(frameCount*.04)      *20 +100), floor(sin((frameCount+150)*.04)*80 +130) );
    else         noFill();
		
		ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
    popMatrix();
	}

  void update(){
		this.radius = walkers.size()*2;

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
			}
    }
    //////////////// thesame logic as in draw() for walkers
    if(walkers.size() != 0){
			// deleting old walkers
			for (int n = walkers.size()-1; n > 0 ; n--) {
				if(walkers.get(n).wannaDie()) walkers.remove(n);
			}

			// moveing walkers
			for (int n = walkers.size()-1; n > 0 ; n--)	walkers.get(n).move();
		
    }
    
  }

	void switch_ON_OFF(){
		isEnable = !isEnable;
	}

	void keyPresed(){
		if (dist(mouseX, mouseY, this.pos.x, this.pos.y) < this.radius) switch_ON_OFF();
	}

}