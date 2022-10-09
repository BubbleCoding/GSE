int cubeSize = 15;
ArrayList<Cube> cubes = new ArrayList<Cube>();
int i = 0;
int totalCubes = 50;
int n;
int ns;
int nss;
int lifeCycleSpeed = 100;
int timer = 0;
int exterminationTimer = 0;
int exterminationCycle;
int cycle;
int reanimate = 3;
float startPercentage = 1;

void setup() {
  size(1250, 1250, P3D);
  // Make cubes
  int index = 0;
  exterminationCycle = 30 * lifeCycleSpeed;
  n = totalCubes;
  ns = n*n;
  nss = n*n*n;
  for (var i = 0; i<totalCubes; i++) {
    for (var j =0; j<totalCubes; j++) {
      for (var k =0; k<totalCubes; k++) {
        cubes.add(new Cube(i, j, k, index));
        index++;
      }
    }
  }
  //  which cubes start alive/death
  for (Cube cube : cubes) {
    //println(cube.getLocation());
    cube.startState(startPercentage);
    cube.makeNeighbourList();
  }
}

void draw() {
  background(100, 200, 0);
  translate(width/2, height/2);
  //rotateX(frameCount*0.011);
  rotateY(frameCount*0.012);
  //rotateZ(frameCount*0.013);
  int wait = millis() - timer;
  if (wait >= lifeCycleSpeed) {
    //println(" gameOfLife " + cycle );
    cycle++;
    for (Cube cube : cubes) {
      cube.checkNeighbours();
    }
    for (Cube cube : cubes) {
      cube.gameOfLife();
    }
    timer = millis();
  }
  int exterminationWait = millis() - exterminationTimer;
  if (exterminationWait >= exterminationCycle) {
    print("hi");
    for (Cube cube : cubes) {
      cube.startState(5);
    }
    exterminationTimer = millis();
  }
  for (Cube cube : cubes) {
    cube.update();
  }
}

class Cube {
  IntList location;
  IntList NeighbourList;
  int index = 0;
  int aliveNeighbours;
  boolean alive = true;
  ArrayList<Cube> neighbours = new ArrayList<Cube>();


  Cube (int x, int y, int z, int indexGet) {
    location = new IntList();
    location.append(x);
    location.append(y);
    location.append(z);
    index = indexGet;
  }

  void update() {
    display();
  }

  void gameOfLife() {
    //println(aliveNeighbours);
    if (aliveNeighbours >= reanimate+1) {
      alive = false;
    } else if (aliveNeighbours <= reanimate-2) {
      alive = false;
    } else if (aliveNeighbours == reanimate) {
      alive = true;
    }
  }

  void startState(float percentage) {
    float ran = random(100);
    if ( ran < 100-percentage) {
      alive = false;
    }
  }

  boolean isAlive() {
    return alive;
  }

  IntList getLocation() {
    return location;
  }
  int getLocationX() {
    return location.get(0);
  }
  int getLocationY() {
    return location.get(1);
  }
  int getLocationZ() {
    return location.get(2);
  }


  void display() {
    if (alive == false) {
      return;
    }
    pushMatrix();
    translate(cubeSize*location.get(0), cubeSize*location.get(1), cubeSize*location.get(2));
    translate(-((n*cubeSize)/2), -(n*cubeSize)/2, -(n*cubeSize)/2);
    fill(location.get(0)*(255/n), location.get(1)*(255/n), location.get(2)*(255/n));
    box(cubeSize);
    popMatrix();
  }

  void makeNeighbourList() {
    NeighbourList = new IntList();
    NeighbourList.append(new int[]{index-n-1, index-n, index-n+1, index-1, index+1, index+n-1, index+n, index+n+1, index-n-1-ns, index-n-ns, index-n+1-ns, index-1-ns, index+1-ns, index+n-1-ns, index+n-ns, index+n+1-ns, index-ns, index-n-1+ns, index-n+ns, index-n+1+ns, index-1+ns, index+1+ns, index+n-1+ns, index+n+ns, index+n+1+ns, index+ns});
    for (int i = NeighbourList.size() - 1; i >= 0; i--) {
      if (NeighbourList.get(i) < 0 || NeighbourList.get(i) >= nss) {
        NeighbourList.remove(i);
      }
    }
    for (int i = NeighbourList.size() - 1; i >= 0; i--) {
      if (cubes.get(NeighbourList.get(i)).getLocationX() - getLocationX() > 1 || cubes.get(NeighbourList.get(i)).getLocationX() - getLocationX() < -1) {
        NeighbourList.remove(i);
      } else if (cubes.get(NeighbourList.get(i)).getLocationY() - getLocationY() > 1 || cubes.get(NeighbourList.get(i)).getLocationY() - getLocationY() < -1) {
        NeighbourList.remove(i);
      } else if (cubes.get(NeighbourList.get(i)).getLocationZ() - getLocationZ() > 1 || cubes.get(NeighbourList.get(i)).getLocationZ() - getLocationZ() < -1) {
        NeighbourList.remove(i);
      }
    }
  }

  void checkNeighbours() {
    aliveNeighbours=0;
    for (int i = NeighbourList.size() - 1; i >= 0; i--) {
      if (cubes.get(NeighbourList.get(i)).isAlive()) {
        //println(cubes.get(NeighbourList.get(i)));
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
