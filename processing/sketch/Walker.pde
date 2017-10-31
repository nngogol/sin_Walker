class Walker{
  
  PVector initPos;
  PVector pos;
  float speed;
  float angle;
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
	
	Walker(float x,	float y, float ang){
		this(
			x,			             // x
			y,      			       // y
			18,                  // trailLenght
			2,                   // scaleSize
			2,                   // trailSpace
			ang,                 // angle
			10,                  // radius
			color(175,191,35),    // stroke_
      4,                   // strokeWidth
      color(213,28,54)   // fill_walker_
		);
	}
	
  Walker(
  float x,
  float y,
  int trailLenght,
  int scaleSize,
  int trailSpace,
  float angle,
  int radius,
  color stroke_,
  int strokeWidth,
  color fill_walker_){

    this.initPos = new PVector(x, y);
		this.pos = new PVector(0, 0);
		this.speed = random(2,4)*0.5;
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
    rotate(this.angle);
    stroke(this.stroke_Walker);
    fill(this.fill_walker);
    scale(this.scaleSize);

		this.renderTrail();
		this.renderWalker();

		popMatrix();
	}

	void renderWalker(){
		ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
	}

	void renderTrail() {
		for(int i = this.history.size()-1; i >= 0; i--){
				float radius_for_trail = map(i, this.trailLenght, 0, this.radius, 1);
				ellipse(
					history.get(i).x,
				  history.get(i).y,
					radius_for_trail,
					radius_for_trail
				);
		}
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