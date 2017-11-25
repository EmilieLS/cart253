
//class Avatar {

//  PImage img = loadImage("girl.jpg");
//  int SPEED = 2;
//  int SIZE = 40;
  
//    // The position and velocity of the paddle (note that vx isn't really used right now)
//  int x;
//  int y;
//  int vx;
//  int vy;

//  // The characters used to make the paddle move up and down, defined in constructor
//  char upKey;
//  char downKey;


// Paddle(int _x, int _y, char _upKey, char _downKey) {
//    x = _x;
//    y = _y;
//    vx = 0;
//    vy = 0;

//    upKey = _upKey;
//    downKey = _downKey;
//  }


//  void update() {
//    // First update the location based on the velocity (so the ball moves)
//    x += vx;
//    y += vy;

//    y = constrain(y, 0, height - 40);
//    x = constrain(x, 0, height - 40);
//  }
//}


// void keyPressed() {
//    // Check if the key is our up key
//    if (key == upKey) {
//      //CHANGED: if the above condition is true, instead of having the velosity change according to the speed, we want 
//      //the paddle to have a negative y velocity and move 15 pixels upwards each time we press the upkey
//      y -= 15;
//    } // Otherwise check if the key is our down key 
//    else if (key == downKey) {
//      //CHANGED: if the above condition is true, we want a positive y velocity, but moving 15 pixels down each time we press the key
//      y += 15;
//    }
//  }

//  // keyReleased()
//  //
//  // Called when keyReleased is called in the main program

//  void keyReleased() {
//    //Check if the key is our up key and the paddle is moving up
//    if (key == upKey && vy < 0) {
//      //If so it should stop
//      vy = 0;
//    } 
//    // Otherwise check if the key is our down key and paddle is moving down 
//    else if (key == downKey && vy > 0) {
//      // If so it should stop
//      vy = 0;
//    }
//  }