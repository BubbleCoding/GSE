int cubeSize = 25;
ArrayList<Cube> cubes = new ArrayList<Cube>();
int i = 0;
int totalCubes = 10;
int lifeCycleSpeed = 1000;
int timer = 0;

void setup() {
  size(1250, 1250, P3D);
  // Make cubes
  for (var i =-totalCubes; i<totalCubes; i++) {
    for (var j =-totalCubes; j<totalCubes; j++) {
      for (var k =-totalCubes; k<totalCubes; k++) {
        cubes.add(new Cube(i, j, k));
      }
    }
  }
  //  which cubes start alive/death
  for (Cube cube : cubes) {
    cube.startState();
  }
}

void draw() {
  background(255);
  translate(width/2, height/2);
  //rotateX(frameCount*0.01);
  rotateY(frameCount*0.01);
  int wait = millis() - timer;
  for (Cube cube : cubes) {
    cube.display();
    if (wait > lifeCycleSpeed) {
      cube.checkForNeighbours();
      timer = millis();
    }
  }
  for (Cube cube : cubes) {
    cube.update();
  }
}

class Cube {
  int[] location={0, 0, 0};
  boolean alive = true;
  ArrayList<Cube> neighbours = new ArrayList<Cube>();

  Cube (int x, int y, int z) {
    location[0] = x;
    location[1] = y;
    location[2] = z;
  }

  void update() {
    int total = neighbours.size();
    if (total >= 4) {
      alive = false;
    }
    if (total <= 1) {
      alive = false;
    }
    if (total == 3) {
      alive = true;
    }
  }

  void startState() {
    float ran = random(100);
    if ( ran < 50) {
      alive = false;
    }
  }

  void display() {
    if (alive == false) {
      return;
    }
    pushMatrix();
    translate(cubeSize*location[0], cubeSize*location[1], cubeSize*location[2]);
    //rotateX(frameCount*0.01);
    //rotateY(frameCount*0.01);
    //rotateZ(frameCount*0.01);
    fill(location[0]*15, location[1]*15, location[2]*15);
    box(cubeSize);
    popMatrix();
  }

  void checkForNeighbours() {
    for (int i = neighbours.size() - 1; i >= 0; i--) {
      Cube cube = neighbours.get(i);
      neighbours.remove(i);
    }

    for (Cube cube : cubes) {
      if (cube.alive) {
        //Back row
        if (location[0]-1 == cube.location[0] && location[1]-1 == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1]-1 == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1]-1 == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]-1 == cube.location[0] && location[1] == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1] == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1] == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]-1 == cube.location[0] && location[1]+1 == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1]+1 == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1]+1 == cube.location[1] && location[2]-1 == cube.location[2]) {
          neighbours.add(cube);
        }

        // Middle row
        else if (location[0]-1 == cube.location[0] && location[1]-1 == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1]-1 == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1]-1 == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]-1 == cube.location[0] && location[1] == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1] == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]-1 == cube.location[0] && location[1]+1 == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1]+1 == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1]+1 == cube.location[1] && location[2] == cube.location[2]) {
          neighbours.add(cube);
        }

        // Front row
        else if (location[0]-1 == cube.location[0] && location[1]-1 == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1]-1 == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1]-1 == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]-1 == cube.location[0] && location[1] == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1] == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1] == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]-1 == cube.location[0] && location[1]+1 == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0] == cube.location[0] && location[1]+1 == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
        else if (location[0]+1 == cube.location[0] && location[1]+1 == cube.location[1] && location[2]+1 == cube.location[2]) {
          neighbours.add(cube);
        }
      }
    }
  }
}
