let balls = [];


function setup() {
  createCanvas(400, 400);
  for (i=0; i< 10; i++) {
    balls.push(new Ball());
  }
}


function draw() {
  background(100);
  for (i=0; i< balls.length; i++) {
    balls[i].update();
  }
  for (i=0; i< balls.length; i++) {
    for (j=0; j< balls.length; j++) {
      let distance = p5.Vector.dist(balls[i].getPos(), balls[j].getPos());
      if (distance < 20 && distance != 0) {
        balls[i].updateSpeed(j);
      }
    }
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
    this.bounceBall();
  }
  getPos() {
    return this.pos;
  }
  getPosX() {
    return this.pos.x;
  }

  getPosY() {
    return this.pos.y;
  }

  updateSpeed(other) {
    this.speed.x = -1 * this.speed.x;
    this.speed.y = -1 * this.speed.y;

    let minDist = 20;
    let spring = 0.05;
    let dx = balls[other].pos.x - this.pos.x;
    let dy = balls[other].pos.y - this.pos.y;


    let angle = atan2(dy, dx);
    let targetX = this.pos.x + cos(angle) * minDist;
    let targetY = this.pos.y + sin(angle) * minDist;
    let ax = (targetX - balls[other].getPosX()) * spring;
    let ay = (targetY - balls[other].getPosY()) * spring;
    this.speed.x -= ax;
    this.speed.y -= ay;
    balls[other].changeSpeed(ax, ay);
  }

  changeSpeed(ax, ay) {
    this.speed.x += ax;
    this.speed.y += ay;
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
