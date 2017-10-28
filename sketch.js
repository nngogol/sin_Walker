let walks = []
let startPos;
let endPos;

function setup() {
	createCanvas(700,700);
}

function draw() {
	background(151)

	for (let n = walks.length-1; n < 0 ; n--) {
		if(walks[n].wannaDie())
			walks[n].slice(n,1)
		else
			walks[n].move();
	}

	walks.map(x => x.render())
}

function mousePressed(){
	startPos = createVector(mouseX, mouseY)
}

function mouseClicked(){
	walks.push(new Walker(mouseX, mouseY))
}

class Walker{
	constructor(x = 200, y = 200, angle = random(0,360)){
		this.initPos = createVector(x, y);
		this.pos = createVector(0, 0)
		this.speed = 2*0.5
		this.angle = angle
		this.frame = 0

		this.trailLenght = 15;
		this.history = [];
		
		
		this.r = 0
		this.theta = 0
	}

	wannaDie(){
		return this.frame > 2000 ? true : false
	}

	renderTrail() {
		
		stroke(0,255,0)
		fill(0,60,60)
		let sizeEllipse = 14;
		for(let i = this.history.length-1; i >= 0; i--){
			
				ellipse(this.history[i].x,
					this.history[i].y,
					sizeEllipse,
					sizeEllipse);

				sizeEllipse -= 0.3;
		}
	}

	trailAdd(){
		
		// done
		// добавить
		this.history.push(this.pos.copy());
		
		// done
		// удалить лишнее
		if(this.history.length > this.trailLenght){
			this.history.splice(0,1);
		}
		
	}

	move(){
		// this.r += this.speed
		// this.theta = sin(frameCount)
		this.trailAdd()

		this.frame += 1
		this.pos.x += this.speed
		this.pos.y += sin(this.frame*.3)
	}

	renderWalker(){
		stroke(255)
		fill(255,40,20)

		ellipse(this.pos.x, this.pos.y, 16, 16);
		
	}

	render(){
		push()
		translate(this.initPos.x, this.initPos.y)
		rotate(radians(this.angle))
		stroke(255)
		noFill()

		// let xx = this.r * cos(this.theta)
		// let yy = this.r * sin(this.theta)
		// ellipse(xx, yy, 16, 16);
		this.renderTrail()
		this.renderWalker()



		pop()
	}
}