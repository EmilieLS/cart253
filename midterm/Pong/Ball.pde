// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  //ADDITION: initializing image of the ball (an apple).
  PImage img = loadImage("apple.jpg");
  /////////////// Properties ///////////////

  // Default values for speed and size
  //CHANGED: ball speed to make it slower as it's going to be changing directions (didn't want to make the game impossible).
  int SPEED = 4;

  //CHANGED ball size to make image of apple clearer
  int SIZE = 40;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The colour of the ball
  color ballColor = color(255);


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    //ADDITION: made the ball change directions 
    //declared randomNumber variable, initialized it, and every frame, this variable will chose a random number between 0 and 100
    float randomNumber=random(0, 100);
    //if it is true that the random number is smaller than 1, then...
    if (randomNumber<1) {
      //then velosity is reversed on both the x and the y axis.
      vx=-vx;
      vy=-vy;
    }

    // Check if the ball is going off the top or bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
  }

  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity

  void reset() {
    x = width/2;
    y = height/2;
  }

  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")

  //SUBSTRACTION of boolean as it didn't specify which side of the screen the ball went off on.
  //boolean isOffScreen() {
  //return (x + SIZE/2 < 0 || x - SIZE/2 > width);
  //}

  //CHANGED: defining the isOffScreen function in order to specify which side of the screen ball goes off.
  String isOffScreen() {
    //if it is true that the ball goes off the left side of screen, then...
    if (x + SIZE/2 < 0) {
      //the program returns OFF LEFT, which means the ball gets reset in the middle and a point goes to the right player
      return "OFF LEFT";
    }
    //if the above condition is not true, then procesing checks if it is true that the ball goes off the left side of the screen. if so...
    else if (x - SIZE/2 > width) {
      //the program returns OFF RIGHT, which means the ball gets reset in the middle and a point goes to the left player
      return "OFF RIGHT";
    }
    //if both above conditions are not true (then the ball has bounced off the top or bottom of the screen)  
    else {
      //and the ball is returned to the screen without the score changing
      return "ON SCREEN";
    }
  }
  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);

    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;
    }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    noStroke();
    fill(ballColor);
    rectMode(CENTER);

    //SUBTRACTION of rect function in order to draw ball as image
    //ADDITION: draw the ball as an image of an apple
    // Draw the ball
    tint (255, 255);
    image(img, x, y, SIZE, SIZE);
  }
}