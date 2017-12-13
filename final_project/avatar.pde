//ADDED: class Avatar
//code from paddle class from pong game
// A class that defines an avatar that can be moved up and down, left and right on the screen
// using arrows keys passed through to the constructor.

class Avatar {

  /////////////// Properties ///////////////

  //initializing avatar (image of a girl)
  PImage img = loadImage("girl.png");

  // Default values for speed and size of avatar
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

  /////////////// Constructor ///////////////

  // Sets the position and controls based on arguments,
  // starts the velocity at 0.
  Avatar(int _x, int _y) {
    x = _x;
    y = _y;
    vx = 0;
    vy = 0;

    //removed code for up key, down key, etc as I'm using keyCode variable
  }


  /////////////// Methods ///////////////

  // update()
  //
  // Updates position based on velocity and constrains the avatar to the window

  void update() {
    // Update position of avatar on x axis with velocity (to move the avatar)
    x += vx;
    // updating position of the avatar with velosity on y axis
    y += vy;

    // Constrain the avatar's y position to be in the window, and (CHANGED) to not be able to go to the bottom of the hellish mountains
    //changed constraints a bit to fit with new rectMode center.
    y = constrain(y, 40, 600);
    //ADDED: constrains the avatar's x position to be in the window
    x = constrain(x, 30, 1265);
  }

  ////ADDED: function to determine if the avatar collides with a sphere. if it does, the sphere disappears
  void collide() {

    //removed old collision code because it wasn't working very well
    //ADDED new collision code between spheres and avatar
    for (int i=yValueOfSpheres.size()-1; i>=0; i=i-1) {
      //variable distance is the distance between the position of the avatar and the position of the sphere
      float distance = dist(x, y, xValueOfSpheres.get(i), yValueOfSpheres.get(i));
      //the radius of sphere = 1/2 of its size ==20/2 =10
      float sumRadius = SIZE/2 + 10;

      //if the distance between the position of the avatar and the position of the sphere is smaller than 20,
      if (distance < sumRadius) {
        //the sphere disappears
        xValueOfSpheres.remove(i);
        yValueOfSpheres.remove(i);
        //ADDED: twinkle song plays with every collision
        songSpheres.play();
        //ADDED: scores goes up every time avatar collides with a sphere
        score=score+1;
        //ends the execution of this structure
        break;
      }
    }

    //removed old collision code because it wasn't working very well
    //ADDED new collision code between self depecration cubes and avatar
    for (int i=yValueOfDeprecation.size()-1; i>=0; i=i-1) {
      //variable distance is the distance between the position of the avatar and the position of the self-deprecation cube
      float distance = dist(x, y, xValueOfDeprecation.get(i), yValueOfDeprecation.get(i));
      //the radius of sphere = 1/2 of its size ==20/2 =10
      float sumRadius = SIZE/2 + 10;

      //if the distance between the position of the avatar and the position of the self-deprecation cube is smaller than 20,
      if (distance < sumRadius) {
        //the self-deprecating cube disappears
        xValueOfDeprecation.remove(i);
        yValueOfDeprecation.remove(i);
        //ADDED: minus one song plays with every collision
        songMinusOne.play();
        //ADDED: scores goes up every time avatar collides with a sphere
        score=score-1;
        //ends the execution of this structure
        break;
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
    //ADDED rect mode center
    rectMode(CENTER);
    imageMode(CENTER);
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