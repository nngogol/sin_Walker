class Walker{

	constructor(x = 200, y = 200, trailLenght = 5, scaleSize = 5, trailSpace = 2,
		angle = 1,
		radius = 5,
		stroke_ = color(255,255,255),
		strokeWidth = 1,
		fill_walker_ = (255,40,20)
	
	){


		this.initPos = createVector(x, y);
		this.pos = createVector(0, 0)
		this.speed = 2*0.5
		this.angle = angle
		this.frame = 0
		this.stroke_Walker = stroke_
		this.radius = radius
		this.strokeWidth = strokeWidth
		this.fill_walker = fill_walker_

		this.trailLenght = trailLenght;
		this.scaleSize = scaleSize;
		this.history = [];

		this.trailSpace = trailSpace;
		this.trailCount = 0
		
		
		this.r = 0
		this.theta = 0
	}

	wannaDie(){
		return this.frame > 200 ? 1 : 0
	}

	move(){
		// this.r += this.speed
		// this.theta = sin(frameCount)
		this.trailCount += 1

		if (this.trailCount == this.trailSpace){
			this.trailAdd()
			this.trailCount = 0
		}

		this.frame += 1
		this.pos.x += this.speed
		this.pos.y += sin(this.frame*.3)
	}

	render(){
		push()

		translate(this.initPos.x, this.initPos.y)
		rotate(this.angle)

		// let xx = this.r * cos(this.theta)
		// let yy = this.r * sin(this.theta)
		// ellipse(xx, yy, 16, 16);
		this.renderTrail()
		this.renderWalker()

		pop()
	}

	renderWalker(){
		stroke(this.stroke_Walker)
		strokeWeight(this.strokeWidth)
		fill(this.fill_walker)
		// text(this.frame,40,40)
		push()
		scale(this.scaleSize)
		ellipse(this.pos.x, this.pos.y, this.radius, this.radius);
		pop()
	}

	renderTrail() {
		stroke(0,255,0)
		fill(0,60,60)

		push()
		scale(this.scaleSize)

		for(let i = this.history.length-1; i >= 0; i--){

				let radius_for_trail = map(i, this.trailLenght, 0, this.radius, 1)
				ellipse(
					this.history[i].x,
					this.history[i].y,
					radius_for_trail,
					radius_for_trail
				);
				
		}
		pop()
		
	}

	trailAdd(){
		
		// done
		// добавить
		this.history.push(this.pos.copy());
		
		// done
		// удалить лишнее
		if(this.history.length > this.trailLenght)
			this.history.splice(0,1);
	}
}