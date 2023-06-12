// Vector Reflect Rover Vos Introduction to Computer Graphics 06/05/2023
float boxX = 0, boxZ = 0;
float camRot = PI/(60*10), currRot = 0;
float b = 200;
boolean left = false, right = false, forward = false, back = false;
boolean outOfBounce = false;    // New
float camX;    // New
float camZ;    // New

void setup() {
  size(640, 480, P3D);
}

void draw() {
  background(128);
  cameraLook();    // New
  outOfBounce();    // New
  // avatar movement
  if (back)boxZ -= 1.0;
  if (forward) boxZ += 1.0;
  if (left) boxX -= 1.0;
  if (right) boxX += 1.0;
  // bounds
  stroke(#FFE71B);
  line(b, 0, -b, b, 0, b);
  line(-b, 0, b, b, 0, b);
  line(b, 0, -b, -b, 0, -b);
  line(-b, 0, b, -b, 0, -b);
  // orbit camera around (boxX, 0, boxZ)
  camera(camX, -200, camZ + 200, // eye     // New
    camX, 0, camZ,     // lookAt    // New
    0, 1, 0);    // camera up vector
  currRot += camRot;
  // avatar
  stroke(0);
  fill(#E87E0C);
  translate(boxX, 0, boxZ);
  box(10);
}

void keyPressed() {
  if (keyCode == UP) {
      back = true;
    }
    if (keyCode == DOWN) {
      forward = true;
    }
    if (keyCode == LEFT) {
      left = true;
    }
    if (keyCode == RIGHT) {
      right = true;
    }
}

void keyReleased() {
  if (keyCode == UP) {
      back = false;
    }
    if (keyCode == DOWN) {
      forward = false;
    }
    if (keyCode == LEFT) {
      left = false;
    }
    if (keyCode == RIGHT) {
      right = false;
    }
}

void outOfBounce(){    // New
  if(boxX>b){
    outOfBounce = true;
    return;
  }
  if(boxX<-b){
    outOfBounce = true;
    return;
  }
  if(boxZ>b){
    outOfBounce = true;
    return;
  }
  if(boxZ<-b){
    outOfBounce = true;
    return;
  }
  outOfBounce = false;
}

void cameraLook(){    // New
  if(!outOfBounce){
  camX = boxX;
  camZ = boxZ;
  }

}
