int cubeSize = 25;

void setup() {
size(1250, 1250, P3D);

}

void draw() {
  background(255);
  translate(width/2, height/2);
  rotateY(frameCount*0.01);
  for(var i =-5; i<5; i++){
      for(var j =-5; j<5; j++){
              for(var k =-5; k<5; k++){
          cube(i,j,k);
        };
      };
    };
}

void cube(int x, int y, int z){
  pushMatrix();
  translate(2*cubeSize*x, 2*cubeSize*y, 2*cubeSize*z); 
  rotateX(frameCount*0.01);
  rotateY(frameCount*0.01);
  rotateZ(frameCount*0.01);
  fill(x*50,y*50,z*50);
  box(cubeSize);
  popMatrix();
}

class cube{

}
