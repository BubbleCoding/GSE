// Button code adopted from https://processing.org/examples/button.html

ArrayList<GaussianBullet> gaussianBullets = new ArrayList<GaussianBullet>();
ArrayList<RandomBullet> randomBullets = new ArrayList<RandomBullet>();
Target target;
Button button;
Text text;
Text text2;
int gaussianMultiplier = 150;
int numberOfBullets = 200;
int randomBulletSpread = 350;
int targetSize = 700;

void setup() {
  size(1250, 1250);
  for (int i = 0; i <numberOfBullets; i++) {
    gaussianBullets.add(new GaussianBullet(int(randomGaussian()*gaussianMultiplier), int(randomGaussian()*gaussianMultiplier)));
  }
  for (int i = 0; i <numberOfBullets; i++) {
    randomBullets.add(new RandomBullet(int(random(-randomBulletSpread, randomBulletSpread)), int(random(-randomBulletSpread, randomBulletSpread))));
  }
  target = new Target();
  button = new Button(1000, 50, 100, "Reset bullets");
  text = new Text("GaussianBullet is green", LEFT, 40, 64, 64, color(0, 255, 0));
  text2 = new Text("RandomBullet is red", LEFT, 40, 128, 64, color(255, 0, 0));
}

void draw() {
  background(0, 0, 0);
  button.update(mouseX, mouseY);
  textSize(64);
  textAlign(LEFT);
  text.update();
  text2.update();
  target.update();
  for (GaussianBullet bullet : gaussianBullets) {
    bullet.update();
  }
  for (RandomBullet bullet : randomBullets) {
    bullet.update();
  }
}

void mousePressed() {
  button.mousePress();
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
    circle(position.get(0), position.get(1), 20);
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
    circle(position.get(0), position.get(1), 20);
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
      for (int i = 0; i <numberOfBullets; i++) {
        gaussianBullets.add(new GaussianBullet(int(randomGaussian()*gaussianMultiplier), int(randomGaussian()*gaussianMultiplier)));
      }
      for (int i = 0; i <numberOfBullets; i++) {
        randomBullets.add(new RandomBullet(int(random(-randomBulletSpread, randomBulletSpread)), int(random(-randomBulletSpread, randomBulletSpread))));
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
