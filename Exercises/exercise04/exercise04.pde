// Griddies
// by Pippin Barr
// MODIFIED BY: 
//
// A simple artificial life system on a grid. The "griddies" are squares that move
// around randomly, using energy to do so. They gain energy by overlapping with
// other griddies. If a griddie loses all its energy it dies.

// The size of a single grid element
int gridSize = 20;

//The size of a single ball
int ballSize= 20;

// An array storing all the griddies
Griddie[] griddies = new Griddie[100];
//An array storing all the balls
Ball[] balls= new Ball[100];

// setup()
//
// Set up the window and the griddies

void setup() {
  // Set up the window size and framerate (lower so we can watch easier)
  size(640, 480);
  frameRate(10);

  // QUESTION: What does this for loop do?
  //ANSWER: this loop initializes  the location of the 100 griddies in the loop and creates them. Puts the new gritties into the array. 
  //i=0 tells processing that at the start of the program, the variable i has the value of zero, meaning that there are no griddies.
  //i < griddies.length tells processing that if the number of griddies has an integer value smaller than the length/size of the array (100 in this case),
  //then the loop keeps going. If not, it ends.
  //i++ tells processing to add one griddie at the end of each loop.
  for (int i = 0; i < griddies.length; i++) {
    //the location of the griddies on the x axis is equal to a random integer number between 0 and 32 (640 divided by 20), meaning that the griddies will appear at
    // a location that is a multiple of 20. 
    int x = floor(random(0, width/gridSize));
    //the y location of the griddie will be equal to a random integer number between 0 and 24 (480 divided by 20), meaning that the griddies will appear at a location that is a multiple of 20.
    int y = floor(random(0, height/gridSize));
    //the x location of the new grittie will be the x location of the griddie times 20,
    //the y location of the new griddie will be the x location of the griddie times 20, 
    //and it will have a size of 20.
    griddies[i] = new Griddie(x * gridSize, y * gridSize, gridSize);
  }

  //initializes the locaiton of the 100 balls in the loop and creates them. puts the new balls into the array.
  for (int t=0; t < balls.length; t++) {
    int x= floor(random(0, width/ballSize));
    int y=floor(random(0, height/ballSize));
    balls[t]= new Ball (x * ballSize, y * ballSize, ballSize);
  }
}

// draw()
//
// Update all the griddies, check for collisions between them, display them.

void draw() {
  background(50);

  // We need to loop through all the griddies one by one: this is here because its an array. 
  for (int i = 0; i < griddies.length; i++) {

    // Update the griddies
    griddies[i].update();

    // Now go through all the griddies a second time...
    for (int j = 0; j < griddies.length; j++) {
      // QUESTION: What is this if-statement for?
      //ANSWER: To check that the griddies do not overlap with themselves.
      if (j != i) {
        // QUESTION: What does this line check?
        // ANSWER: then we check whether a griddie collides with another grittie. 
        griddies[i].collide(griddies[j]);
      }
    }

    // Display the griddies
    griddies[i].display();
  }


  // We need to loop through all the balls one by one
  for (int t = 0; t < balls.length; t++) {

    // Update the balls
    balls[t].update();

    // Now go through all the balls a second time...
    for (int u = 0; u < balls.length; u++) {
      // check that balls don't overlap with themselves
      if (u != t) {
        // check if a ball overlaps with another ball
        balls[t].collide(balls[u]);
      }
    }

    //check if balls collide with griddies
    for (int j = 0; j < griddies.length; j++) {
      balls[t].collideGriddieAndBall(griddies[j]);
    }


    // Display the griddies
    balls[t].display();
  }
}