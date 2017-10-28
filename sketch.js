let walks = []
let startPos;
let endPos;

function setup() {
	createCanvas(700,700);
}

function draw() {
	background(151)

	for (let n = walks.length-1; n > 0 ; n--) {
		if(walks[n].wannaDie() == 1)
			walks.splice(n,1)
		
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