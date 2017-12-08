// Paddle
//
// A class that defines a paddle that can be moved up and down on the screen
// using keys passed through to the constructor.

class Paddle {

  /////////////// Properties ///////////////

  //ADDITION: defining and initializing new variable image for left paddle
  PImage img = loadImage("alien.jpg");

  // Default values for speed and size
  int SPEED = 5;
  int HEIGHT = 70;
  //CHANGED: made width of paddle bigger
  int WIDTH = 70;

  // The position and velocity of the paddle (note that vx isn't really used right now)
  int x;
  int y;
  int vx;
  int vy;

  // The fill color of the paddle
  color paddleColor = color(255);

  // The characters used to make the paddle move up and down, defined in constructor
  char upKey;
  char downKey;


  /////////////// Constructor ///////////////

  // Paddle(int _x, int _y, char _upKey, char _downKey)
  //
  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  Paddle(int _x, int _y, char _upKey, char _downKey) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    upKey = _upKey;
    downKey = _downKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the paddle to the window

  void update() {
    // Update position with velocity (to move the paddle)
    x += vx;
    //SUBSTRACTION: took away updating position of the paddle with velosity y axis
    //y += vy;

    // Constrain the paddle's y position to be in the window
    //CHANGED: changed the constrain of the paddles' y position since my paddle is of a different size
    y = constrain(y, 0, height - HEIGHT);
  }

  // display()
  //
  // Display the paddle at its location

  void display() {
    // Set display properties
    noStroke();
    fill(paddleColor);
    rectMode(CENTER);
    //SUBSTRACTION: took away rect function to put in an image 
    //ADDITION: draw paddle as alien image
    image(img, x, y, WIDTH, HEIGHT);
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      //CHANGED: if the above condition is true, instead of having the velosity change according to the speed, we want 
      //the paddle to have a negative y velocity and move 15 pixels upwards each time we press the upkey
      y -= 15;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      //CHANGED: if the above condition is true, we want a positive y velocity, but moving 15 pixels down each time we press the key
      y += 15;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    //Check if the key is our up key and the paddle is moving up
    if (key == upKey && vy < 0) {
      //If so it should stop
      vy = 0;
    } 
    // Otherwise check if the key is our down key and paddle is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    }
  }
}