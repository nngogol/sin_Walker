class Walker{
  
  PVector initPos;
  PVector pos;
  float speed;
  int angle;
  int frame;
  color stroke_Walker;
  int radius;
  int strokeWidth;
  color fill_walker;

  int trailLenght;
  int scaleSize;
  ArrayList<PVector> history;

  int trailSpace;
  int trailCount;
  
  float r;
  float theta;
  
  Walker(
  int x,
  int y,
  int trailLenght,
  int scaleSize,
  int trailSpace,
  int angle,
  int radius,
  color stroke_,
  int strokeWidth,
  color fill_walker_){

    this.initPos = new PVector(x, y);
		this.pos = new PVector(0, 0);
		this.speed = 2*0.5;
		this.angle = angle;
		this.frame = 0;
		this.stroke_Walker = stroke_;
		this.radius = radius;
		this.strokeWidth = strokeWidth;
		this.fill_walker = fill_walker_;

		this.trailLenght = trailLenght;
		this.scaleSize = scaleSize;
		this.history = new ArrayList<PVector>();

		this.trailSpace = trailSpace;
		this.trailCount = 0;
		
		this.r = 0;
		this.theta = 0;

	}
	
	boolean wannaDie(){
		return this.frame > 200.0 ? true : false;
	}

	void move(){
		// this.r += this.speed
		// this.theta = sin(frameCount)
		this.trailCount += 1;

		if (this.trailCount == this.trailSpace){
			this.trailAdd();
			this.trailCount = 0;
		}

		this.frame += 1;
		this.pos.x += this.speed;
		this.pos.y += sin(this.frame*.3);
	}

	void render(){
		pushMatrix();

		translate(this.initPos.x, this.initPos.y);
		rotate(radians(this.angle));

		// let xx = this.r * cos(this.theta)
		// let yy = this.r * sin(this.theta)
		// ellipse(xx, yy, 16, 16);
		this.renderTrail();
		this.renderWalker();

		popMatrix();
	}

	void renderWalker(){
		stroke(this.stroke_Walker);
		strokeWeight(this.strokeWidth);
		fill(this.fill_walker);
		// text(this.frame,40,40)
		pushMatrix();
		scale(this.scaleSize);
		ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
		popMatrix();
	}

	void renderTrail() {
		stroke(0,255,0);
		fill(0,60,60);

		pushMatrix();
		scale(this.scaleSize);

		for(int i = this.history.size()-1; i >= 0; i--){

				float radius_for_trail = map(i, this.trailLenght, 0, this.radius, 1);
				ellipse(
					history.get(i).x,
				  history.get(i).y,
					radius_for_trail,
					radius_for_trail
				);
				
		}
		popMatrix();
		
	}

	void trailAdd(){
		
		// done
		// добавить
		this.history.add(this.pos.copy());
		
		// done
		// удалить лишнее
		if(this.history.size() > this.trailLenght)
			this.history.remove(0);
	}
}