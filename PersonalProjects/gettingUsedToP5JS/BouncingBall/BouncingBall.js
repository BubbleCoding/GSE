let balls = [];


function setup() {
  createCanvas(400, 400);
  for (i=0; i< 50; i++) {
    balls.push(new Ball());
  }
}


function draw() {
  background(100);
  for (i=0; i< balls.length; i++) {
    balls[i].update();
  }
}

class Ball {
  constructor() {
    this.diameter = 20;
    this.pos = createVector(random(this.diameter, width-2*this.diameter), random(this.diameter, height-this.diameter));
    this.speed = createVector(random(-3, 3), random(-3, 3));
  }

  update() {
    this.move();
    this.display();
    this.bounceWall();
  }

  getPos() {
    return this.pos;
  }

  move() {
    this.pos.y += this.speed.x;
    this.pos.x += this.speed.y;
  }

  bounceWall() {
    if (this.pos.x + this.diameter/2 >= width || this.pos.x - this.diameter/2 <= 0) {
      this.speed.y = -1*this.speed.y;
    }
    if (this.pos.y + this.diameter/2 >= height || this.pos.y - this.diameter/2 <= 0) {
      this.speed.x = -1*this.speed.x;
    }
  }

  bounceBall() {
  }

  display() {
    fill(255, 0, 0);
    circle(this.pos.x, this.pos.y, this.diameter);
  }
}
