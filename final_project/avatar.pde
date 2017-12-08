// ADDED: object Avatar
//code from paddle class from pong game
// A class that defines an avatar that can be moved up and down, left and right on the screen
// using keys passed through to the constructor.

class Avatar {

  /////////////// Properties ///////////////


  //initializing avatar (image of a girl)
  PImage img = loadImage("girl.jpg");

  // Default values for speed and size
  //CHANGE: made speed faster
  int SPEED = 7;
  int HEIGHT = 70;
  int WIDTH = 70;

  // The position and velocity of the avatar
  int x;
  int y;
  int vx;
  int vy;

  // The characters used to make the avatar move up and down, defined in constructor
  char upKey;
  char downKey;
  //ADDED: left and right key to control avatar
  char leftKey;
  char rightKey;


  /////////////// Constructor ///////////////

  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  Avatar(int _x, int _y, char _upKey, char _downKey, char _leftKey, char _rightKey) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    upKey = _upKey;
    downKey = _downKey;
    leftKey=_leftKey;
    rightKey=_rightKey;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constraints the avatar to the window

  void update() {
    // Update position with velocity (to move the avatar)
    x += vx;
    // updating position of the paddle with velosity y axis
    y += vy;

    // Constrain the paddle's y position to be in the window
    y = constrain(y, 0, height - HEIGHT);
  }

  // display()
  //
  // Display the paddle at its location

  void display() {
    //limiting these properties to the avatar
    pushStyle();
    // Set display properties
    noStroke();
    rectMode(CENTER);
    // draw avatar as girl image
    image(img, x, y, WIDTH, HEIGHT);
    popStyle();
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  void keyPressed() {
    // Check if the key is our up key
    if (key == upKey) {
      //if the above condition is true have the velosity change according to the speed when we press the upkey
      vy=-SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == downKey) {
      //if the above condition is true have the velosity change according to the speed when we press the downkey
      vy=+SPEED;
    }
    if (key == leftKey) {
      //if the above condition is true have the velosity change according to the speed when we press the left key
      vx=-SPEED;
    } // Otherwise check if the key is our down key 
    else if (key == rightKey) {
      //if the above condition is true have the velosity change according to the speed when we press the rightkey
      vx=+SPEED;
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    //Check if the key is our up key and the avatar is moving up
    if (key == upKey && vy < 0) {
      //If so it should stop
      vy = 0;
    } 
    // Otherwise check if the key is our down key and avatar is moving down 
    else if (key == downKey && vy > 0) {
      // If so it should stop
      vy = 0;
    }
    //Check if the key is our left key and the avatar is moving left
    if (key == leftKey && vx < 0) {
      //If so it should stop
      vx = 0;
    } 
    // Otherwise check if the key is our right key and avatar is moving right
    else if (key == rightKey && vy > 0) {
      // If so it should stop
      vx = 0;
    }
  }
}