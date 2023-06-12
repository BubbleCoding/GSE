// Rotating Boxes Rover Vos Introduction to Computer Graphics 06/05/2023


void setup(){
  size(800, 800, P3D);
}

void draw(){
background(0);
pushMatrix();
translate(width/2, height/2,0); 
rotateY(frameCount*0.012);
translate(width/8, height/8,0); 
rotateZ(frameCount*0.012);
rotateX(frameCount*0.012);
rotateY(frameCount*0.012);
translate(0, -width/8, 0); 
stroke(255);
noFill();
box(100);
popMatrix();

pushMatrix();
translate(width/2, height/2,0); 
rotateY(frameCount*0.012);
translate(-width/8, -height/8,0); 
rotateZ(frameCount*0.012);
rotateX(frameCount*0.012);
rotateY(frameCount*0.012);
translate(0, width/8, 0); 
stroke(255);
noFill();
box(100);
popMatrix();
}
