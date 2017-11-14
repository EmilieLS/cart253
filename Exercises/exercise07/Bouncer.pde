/* */

//defining the class called Bouncer
class Bouncer {

  //CHANGED: changed from int to float because the constrain below assumes that x is an int, and it made the image non-symtrical.
  float x;
  //CHANGED: changed from int to float because the constrain below assumes that x is an int, and it made the image non-symtrical.
  float y;
  float vx;
  float vy;
  int size;
  color fillColor;
  color defaultColor;
  color hoverColor;

  //The constructor (basically the setup() for the Bouncer)
  //CHANGE: changed tempVX and tempVY from int to float in order to be able to make speed of bouncers slower
  Bouncer(int tempX, int tempY, float tempVX, float tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
    x = tempX;
    y = tempY;
    vx = tempVX;
    vy = tempVY;
    size = tempSize;
    defaultColor = tempDefaultColor;
    hoverColor = tempHoverColor;
    fillColor = defaultColor;
  }

  void update() {
    x += vx;
    y += vy;

    handleBounce();
  
  }

  void handleBounce() {
    if (x - size/2 < 0 || x + size/2 > width) {
      vx = -vx; 

    //ADDED: sound file plays when bouncer hits the edge of screen on the left or right
      songTwo.play();

      //ADDED: when the boncer hits the edge of screen on top or bottom, it playsless
      //loud than when it hit the left or right
      songTwo.amp(0.1);
    } 

    if (y - size/2 < 0 || y + size/2 > height) {
      vy = -vy;

      //ADDED: sound file plays when bouncer hits the edge of screen on the top or bottom
      songOne.play();
    }

    x = constrain(x, size/2, width-size/2);
    y = constrain(y, size/2, height-size/2);
  }


  void draw() {
    noStroke();
    fill(fillColor);
    ellipse(x, y, size, size);
  }
}