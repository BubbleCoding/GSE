int cubeSize = 5;
ArrayList<Cube> cubes = new ArrayList<Cube>();
int i = 0;
int totalCubes = 10;
int n = 20;
int ns = 400;
int lifeCycleSpeed = 1000;
int timer = 0;

void setup() {
  size(1250, 1250, P3D);
  // Make cubes
  int index = 0;
  n = 2*totalCubes;
  ns = n*n;
  for (var i =-totalCubes; i<totalCubes; i++) {
    for (var j =-totalCubes; j<totalCubes; j++) {
      for (var k =-totalCubes; k<totalCubes; k++) {
        cubes.add(new Cube(i, j, k, index));
        index++;
      }
    }
  }
  //  which cubes start alive/death
  for (Cube cube : cubes) {
    cube.startState();
    cube.makeNeighbourList();
  }
}

void draw() {
  background(100, 200, 0);
  translate(width/2, height/2);
  rotateX(frameCount*0.01);
  rotateY(frameCount*0.01);
  int wait = millis() - timer;
  for (Cube cube : cubes) {
    cube.update();
  }
  if (wait >= lifeCycleSpeed) {
    for (Cube cube : cubes) {
      cube.gameOfLife();
    }
    timer = millis();
  }
}

class Cube {
  int[] location={0, 0, 0};
  IntList NeighbourList;
  int index = 0;
  int aliveNeighbours = 0;
  boolean alive = true;
  ArrayList<Cube> neighbours = new ArrayList<Cube>();


  Cube (int x, int y, int z, int index) {
    location[0] = x;
    location[1] = y;
    location[2] = z;
    index = index;
  }

  void update() {
    display();
  }

  void gameOfLife() {
    checkNeighbours();
    if (aliveNeighbours >= 3) {
      alive = false;
    } else if (aliveNeighbours <= 1) {
      alive = false;
    } else if (aliveNeighbours == 2) {
      alive = true;
    }
  }

  void startState() {
    float ran = random(100);
    if ( ran < 50) {
      alive = false;
    }
  }

  boolean isAlive() {
    return alive;
  }

  void display() {
    if (alive == false) {
      return;
    }
    pushMatrix();
    translate(2*cubeSize*location[0], 2*cubeSize*location[1], 2*cubeSize*location[2]);
    rotateX(frameCount*0.01);
    rotateY(frameCount*0.01);
    rotateZ(frameCount*0.01);
    fill(location[0]*15, location[1]*15, location[2]*15);
    box(cubeSize);
    popMatrix();
  }

  void makeNeighbourList() {
    NeighbourList = new IntList();
    NeighbourList.append(new int[]{index-n-1, index-n, index-n+1, index-1, index+1, index+n-1, index+n, index+n+1, index-n-1-ns, index-n-ns, index-n+1-ns, index-1-ns, index+1-ns, index+n-1-ns, index+n-ns, index+n+1-ns, index-ns, index-n-1+ns, index-n+ns, index-n+1+ns, index-1+ns, index+1+ns, index+n-1+ns, index+n+ns, index+n+1+ns, index+ns});
    for (int i = NeighbourList.size() - 1; i >= 0; i--) {
      if (NeighbourList.get(i) < 0) {
        NeighbourList.remove(i);
      }
    }
  }

  void checkNeighbours() {
    aliveNeighbours=0;
    for (int i = NeighbourList.size() - 1; i >= 0; i--) {
      if (cubes.get(i).isAlive()) {
        aliveNeighbours++;
      }
    }
  }
}

/*
x = index
 n = width
 check
 middle layer
 index-n-1
 index-n
 index-n+1
 index-1
 index+1
 index+n-1
 index+n
 index+n+1
 
 bottom layer
 index-n-1-ns
 index-n-ns
 index-n+1-ns
 index-1-ns
 index+1-ns
 index+n-1-ns
 index+n-ns
 index+n+1-ns
 index-ns
 
 top layer
 index-n-1+ns
 index-n+ns
 index-n+1+ns
 index-1+ns
 index+1+ns
 index+n-1+ns
 index+n+ns
 index+n+1+ns
 index+ns
 
 */
