let walks = []
let startPos;
let endPos;

function setup() {
	createCanvas(700,700);
}

function draw() {
	background(151)

	for (let n = 0; n < walks.length; n++) {
		walks[n].move();
		walks[n].render();
		
	}

	walks.map(x => x.move())
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
		this.speed = 2*0.1
		this.angle = angle
		this.frame = 0
		
		this.r = 0
		this.theta = 0
	}

	move(){
		// this.r += this.speed
		// this.theta = sin(frameCount)
		this.frame += 1
		this.pos.x += this.speed
		this.pos.y += sin(this.frame*.03)
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
		ellipse(this.pos.x, this.pos.y, 16, 16);
		pop()
	}
}