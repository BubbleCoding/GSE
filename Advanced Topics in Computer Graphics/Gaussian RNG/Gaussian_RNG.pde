// Button code adopted from https://processing.org/examples/button.html

ArrayList<GaussianBullet> gaussianBullets = new ArrayList<GaussianBullet>();
ArrayList<RandomBullet> randomBullets = new ArrayList<RandomBullet>();
ArrayList<RandomBullet2> randomBullets2 = new ArrayList<RandomBullet2>();

Target target;
Button button;
Text text;
Text text2;
Text text3;
int gaussianMultiplier = 150;
int numberOfBullets = 1000;
int randomBulletSpread = 350;
int targetSize = 700;
int bulletSize = 10;

void setup() {
  size(1250, 1250);
  for (int i = 0; i <numberOfBullets; i++) {
    gaussianBullets.add(new GaussianBullet(int(randomGaussian()*gaussianMultiplier), int(randomGaussian()*gaussianMultiplier)));
  }
  for (int i = 0; i <numberOfBullets; i++) {
    randomBullets.add(new RandomBullet(int(random(-randomBulletSpread, randomBulletSpread)), int(random(-randomBulletSpread, randomBulletSpread))));
  }
  for (int i = 0; i <numberOfBullets; i++) {
    randomBullets2.add(new RandomBullet2(int(random(-randomBulletSpread, randomBulletSpread)), random(6.28)));
  }
  target = new Target();
  button = new Button(1000, 50, 100, "Reset bullets");
  text = new Text("GaussianBullet is green", LEFT, 40, 64, 64, color(0, 255, 0));
  text2 = new Text("RandomBullet is red", LEFT, 40, 128, 64, color(255, 0, 0));
  text3 = new Text("RandomBulletCircle is Blue", LEFT, 40, 192, 64, color(0, 0, 255));
}

void draw() {
  background(0, 0, 0);
  button.update(mouseX, mouseY);
  textSize(64);
  textAlign(LEFT);
  text.update();
  text2.update();
  text3.update();
  target.update();
  for (GaussianBullet bullet : gaussianBullets) {
    bullet.update();
  }
  for (RandomBullet bullet : randomBullets) {
    bullet.update();
  }
  for (RandomBullet2 bullet : randomBullets2) {
    bullet.update();
  }
  rect(0, height*0.9, width, height*.1);
  fill(255,255,255);
  text("0", 0, height-20);
  text(height, width*0.9, height-20);
  text("Number of bullets:" + numberOfBullets, width*0.1, height-20);
}

void mousePressed() {
  button.mousePress();
  if(mouseY > 0.9*width){
    numberOfBullets = mouseX;
  }
}

class GaussianBullet {
  IntList position;

  GaussianBullet(int x, int y) {
    position = new IntList();
    position.append(x);
    position.append(y);
  }

  void update() {
    display();
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2);
    fill(0, 255, 0);
    circle(position.get(0), position.get(1), bulletSize);
    popMatrix();
  }
}

class RandomBullet {
  IntList position;

  RandomBullet(int x, int y) {
    position = new IntList();
    position.append(x);
    position.append(y);
  }

  void update() {
    display();
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2);
    fill(255, 0, 0);
    circle(position.get(0), position.get(1), bulletSize);
    popMatrix();
  }
}

class RandomBullet2 {
  float posX;
  float posY;

  RandomBullet2(int x, float y) {
    posX =x;
    posY =y;
  }

  void update() {
    display();
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2);
    fill(0, 0, 255);
    circle(sqrt(posX)*cos(posY)*20, sqrt(posX)*sin(posY)*20, bulletSize);
    popMatrix();
  }
}

class Target {
  void update() {
    display();
  }

  void display() {
    pushMatrix();
    translate(width/2, height/2);
    fill(255, 255, 255);
    circle(0, 0, targetSize);
    fill(0, 0, 0);
    circle(0, 0, targetSize-(targetSize*1/5));
    fill(255, 255, 255);
    circle(0, 0, targetSize-(targetSize*2/5));
    fill(0, 0, 0);
    circle(0, 0, targetSize-(targetSize*3/5));
    fill(255, 255, 255);
    circle(0, 0, targetSize-(targetSize*4/5));
    popMatrix();
  }
}

class Text {
  String text;
  int align;
  int xText;
  int yText;
  int sizeText;
  color Color;

  Text(String t, int a, int x, int y, int s, color c ) {
    text = t;
    align = a;
    xText = x;
    yText = y;
    sizeText = s;
    Color = c;
  }
  void update() {
    display();
  }

  void display() {
    textSize(sizeText);
    textAlign(align);
    fill(Color);
    text(text, xText, yText);
  }
}

class Button {
  boolean rectOver = false;
  int rectX;
  int rectY;
  int rectSize;
  String text;
  Button(int x, int y, int size, String t) {
    rectX = x;
    rectY = y;
    rectSize = size;
    text = t;
  }

  void display() {
    fill(0, 0, 255);
    rect(rectX, rectY, rectSize, rectSize);
    fill(255, 255, 255);
    textSize(rectSize/6);
    textAlign(CENTER);
    text(text, rectX+rectSize/2, rectY+rectSize/2);
  }

  void update(int x, int y) {
    display();
    if ( overRect(rectX, rectY, rectSize, rectSize) ) {
      rectOver = true;
    } else {
      rectOver = false;
    }
  }

  void mousePress() {
    if (rectOver) {
      gaussianBullets.clear();
      randomBullets.clear();
      randomBullets2.clear();
      for (int i = 0; i <numberOfBullets; i++) {
        gaussianBullets.add(new GaussianBullet(int(randomGaussian()*gaussianMultiplier), int(randomGaussian()*gaussianMultiplier)));
      }
      for (int i = 0; i <numberOfBullets; i++) {
        randomBullets.add(new RandomBullet(int(random(-randomBulletSpread, randomBulletSpread)), int(random(-randomBulletSpread, randomBulletSpread))));
      }
      for (int i = 0; i <numberOfBullets; i++) {
        randomBullets2.add(new RandomBullet2(int(random(-randomBulletSpread, randomBulletSpread)), int(random(360))));
      }
    }
  }

  boolean overRect(int x, int y, int width, int height) {
    if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
      return true;
    } else {
      return false;
    }
  }
}
