// Lighting a Scene Rover Vos Introduction to Computer Graphics 06/05/2023

void setup(){
  size(650,650,P3D);
background(30,30,50);
noStroke();
sphereDetail(170);
}

void draw(){
ambientLight(30, 30, 30);
spotLight(117, 102, 126,  mouseX-width/2,mouseY-width/2, 500, width/2,height/2, 0, PI, 1);
translate(width/2,height/2,0);
sphere(160);
}
