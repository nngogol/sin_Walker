// my variables
let walks = []
let startPos;
let endPos;

// must use 'var' !!!
// gui params
	var strokeWidth = 4;
	var strokeWidthMin = 1;
	var strokeWidthMax = 10;
	var strokeWidthStep = 0.2;

	var strokeColor = '#00ddff';

	var fillColor = [180, 255, 255];

	var ang = 5;
	var angMin = 1;
	var angMax = 360;
	var angStep = 1;

	var radius = 20;
	var radiusMin = 5;
	var radiusMax = 50;
	var radiusStep = 1;
// END gui params

// gui guy
var gui;

function setup() {
	createCanvas(windowWidth, windowHeight);
	gui = createGui()
	gui.addGlobals('ang', 'strokeWidth', 'strokeColor', 'fillColor', 'radius')
}

function draw() {
	background(151)
	
	addingWalkers()

	// deleting old walkers
	for (let n = walks.length-1; n > 0 ; n--) {
		if(walks[n].wannaDie() == 1)
			walks.splice(n,1)
		
	}
	
	// moveit moveit
	walks.map(x => x.move())
	walks.map(x => x.render())
		
}


////////////////////////////////

function mousePressed(){
	// startPos = createVector(mouseX, mouseY)
}

function mouseClicked(){
	// endPos = createVector(mouseX, mouseY)
	// let vect = p5.Vector.sub(endPos, startPos)
	// let n = p5.Vector.angleBetween(createVector(0,1),vect)
	// console.log(degrees(n))
	walks.push(new Walker(mouseX, mouseY, ang, radius, strokeColor))
}

function addingWalkers() {
	
		// adding angle
		ang+=1
		if(ang == 360){
			ang = 1
		}
	
		// adding walker
		if(frameCount% 40 == 1){
			walks.push(new Walker(width/2, height/2, ang, radius, strokeColor))
		}
	
		//drawing center point
		let cc = [
			floor(sin(frameCount*.05)      *100+100),
			floor(cos(frameCount*.04)      *20 +100),
			floor(sin((frameCount+150)*.04)*80 +130)]
		fill(cc[0], cc[1], cc[2])
		ellipse(width/2, height/2, width/16, width/16)
	}