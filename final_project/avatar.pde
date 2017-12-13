// ADDED: object Avatar
//code from paddle class from pong game
// A class that defines an avatar that can be moved up and down, left and right on the screen
// using keys passed through to the constructor.

class Avatar {

  /////////////// Properties ///////////////

  //initializing avatar (image of a girl)
  PImage img = loadImage("girl.png");

  // Default values for speed and size
  //CHANGE: made speed faster
  int SPEED = 7;
  int SIZE=70;

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
  //  char spaceKey;



  /////////////// Constructor ///////////////

  // Sets the position and controls based on arguments,
  // starts the velocity at 0

  //removed code for old keys here, as changed keys to up,down, left, right arrows.
  Avatar(int _x, int _y) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    //removed code for up key, down key, etc as I'm using keyCode variable
    //upKey = _upKey;
    //downKey = _downKey;
    //leftKey=_leftKey;
    //rightKey=_rightKey;
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

    // Constrain the avatar's y position to be in the window, and (CHANGED) not be able to go to the bottom of the hellish mountains
    //y = constrain(y, 0, height - HEIGHT);
    y = constrain(y, 0, 600);
    //ADDED: constrains the avatar's x position to be in the window
    x = constrain(x, 0, 1230);
  }

  ////ADDED: function to determine if the avatar collides with a sphere. if it does, the sphere disappears
  void collide() {
    for (int i=yValueOfSpheres.size()-1; i>=0; i=i-1) {

      // Calculate if avatar overlaps with the spheres side by side
      boolean insideLeft = (xValueOfSpheres.get(i) >x+SIZE/2);
      boolean insideRight =(xValueOfSpheres.get(i)<x+SIZE/2+SIZE);
      boolean insideTop =   (yValueOfSpheres.get(i) >y+SIZE/2);
      boolean insideBottom = (yValueOfSpheres.get(i)<y+SIZE/2+SIZE);

      // Check if the avatar overlaps with a spheres
      if (insideLeft && insideRight && insideTop && insideBottom) {
        xValueOfSpheres.remove(i);
        yValueOfSpheres.remove(i);
        //ADDED: twinkle song plays with every collision
        songSpheres.play();
        //ADDED: scores goes up every time avatar collides with a sphere
        score=score+1;
      }
    }
    
     for (int i=yValueOfDeprication.size()-1; i>=0; i=i-1) {

      // Calculate if avatar overlaps with the deprication cubes side by side
      boolean insideLeft = (xValueOfDeprication.get(i) >x+SIZE/2);
      boolean insideRight =(xValueOfDeprication.get(i)<x+SIZE/2+SIZE);
      boolean insideTop =   (yValueOfDeprication.get(i) >y+SIZE/2);
      boolean insideBottom = (yValueOfDeprication.get(i)<y+SIZE/2+SIZE);

      // Check if the avatar overlaps with a deprication cube
      if (insideLeft && insideRight && insideTop && insideBottom) {
        xValueOfDeprication.remove(i);
        yValueOfDeprication.remove(i);
        //ADDED: minusOne song plays with every collision
        songMinusOne.play();
        //ADDED: scores down by 1 every time avatar collides with a deprication
        score=score-1;
      }
    }
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
    image(img, x, y, SIZE, SIZE);
    popStyle();
  }

  // keyPressed()
  //
  // Called when keyPressed is called in the main program

  //CHANGED keys to up, down, left, right arrows.
  void keyPressed() {
    // Check if the key is our up key
    if (key==CODED) {
      if (keyCode == UP) {
        //if the above condition is true have the velosity change according to the speed when we press the upkey
        vy=-SPEED;
      } // Otherwise check if the key is our down key 
      else if (keyCode == DOWN) {
        //if the above condition is true have the velosity change according to the speed when we press the downkey
        vy=+SPEED;
      }
      if (keyCode == LEFT) {
        //if the above condition is true have the velosity change according to the speed when we press the left key
        vx=-SPEED;
      } // Otherwise check if the key is our down key 
      else if (keyCode == RIGHT) {
        //if the above condition is true have the velosity change according to the speed when we press the rightkey
        vx=+SPEED;
      }
    }
  }

  // keyReleased()
  //
  // Called when keyReleased is called in the main program

  void keyReleased() {
    //Check if the key is our up key and the avatar is moving up
    if (key==CODED) {
      if (keyCode == UP && vy < 0) {
        //If so it should stop
        vy = 0;
      } 
      // Otherwise check if the key is our down key and avatar is moving down 
      else if (keyCode == DOWN && vy > 0) {
        // If so it should stop
        vy = 0;
      }
      //Check if the key is our left key and the avatar is moving left
      if (keyCode == LEFT && vx < 0) {
        //If so it should stop
        vx = 0;
      } 
      // Otherwise check if the key is our right key and avatar is moving right
      else if (keyCode == RIGHT && vx > 0) {
        // If so it should stop
        vx = 0;
      }
    }
  }
}