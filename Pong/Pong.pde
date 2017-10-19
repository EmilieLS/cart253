// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
//CHANGED: got rid of paddle inset in order to manually set the paddles on the x-axis myself.
//int PADDLE_INSET = 55;

// The background colour during play (black)
color backgroundColor = color(0);

//ADDITION: declaring variable "image"
PImage img;

//ADDITION: declaring and initializing of new variables for score and making the score start at 0 for both players 
int rightPlayerScore=0;
int leftPlayerScore=0;

//ADDITION: declaring and initializing new variable which will tell game that one player has one, making the message "You just won," appear
String onePlayerWon="You just won, ";
//ADDITION: declaring long variable (type for long integers) that tells processing when a player scores
long startTime;
//ADDITION: declaring variable that tells processing how much time has passed since the point was made
long timePassed;
//ADDITION: declaring and initializing variable which stops the internal clock after 2.5 seconds
int expireTime =2500;
//ADDITION: declaring and initializing variable which stores the value false. This variable will make the score appear.
boolean isAppearing =false;
//ADDITION: declaring and initializing variable which stores the value true. This variable will tell processing whether game is still being played or not.
boolean playGame=true;
//ADDITION: declaring and iniializing variable which will tell processing which player won.
String whoWon="";

// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 480);

  //ADDITION:initializing background image of space
  img = loadImage("space.jpg");
  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  //CHANGED: changed position of paddles on x-axis so that my alien image could be seen in its entirety (as the original paddles were less wide, the alien image was partially hidden).
  //CHANGED the keys used to control "up" and "down" respecively in order to make it more challenging (and annoying) to access the keys
  leftPaddle = new Paddle(-10, height/2, '6', 'r');
  rightPaddle = new Paddle(width - 60, height/2, '5', 'u');

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {

  //ADDITION: if it is true that the game is being played, then do everything until line SOMETHING 
  if (playGame==true) {

    //if the variable is flashing is true, then...
    if (isAppearing ==true) {
      //we find out how much time has passed since timer started. millis returns how many milliseconds have gone by since the program started. so millis-the time the timer started= how much time has passed timer started
      timePassed = millis() -startTime;
      //if the time that has passed since the time started is biggger than 2.5 seconds then...
      if (timePassed>expireTime)
      {
        //it is not true that isAppearing is true. 
        isAppearing =false;
      }
    }

    //draw background so we can have animation (just re-writing your comment here)
    background(backgroundColor);
    //ADDITION:initialized image of space
    image(img, 0, 0);

    //CHANGED: make score appear in right part of the screen for 2.5 seconds 
    textSize(52);
    //if it is true that the variable isAppearing is true (meaning that less than 2.5 seconds has passed since a player last scored), then...
    if (isAppearing ==true)
    {
      //make the right player's score appear in right part of the screen in the middle of the y-axis in random colours
      fill(random(0, 255), random(0, 255), random(0, 255));
      text(rightPlayerScore, 380, 240);
    }

    //CHANGED: make score appear in left part of the top of screen for 2.5 seconds 
    textSize(52);
    //if it is true that the variable isAppearing is true (meaning that less than 2.5 seconds has passed since a player last scored), then...
    if (isAppearing ==true)
    {
      //make the left player's score appear in left part of the screen in the middle of the y-axis in random colours
      fill(random(0, 255), random(0, 255), random(0, 255));
      text(leftPlayerScore, 210, 240);
    }


    // Update the paddles and ball by calling their update methods
    leftPaddle.update();
    rightPaddle.update();
    ball.update();


    // Check if the ball has collided with either paddle
    ball.collide(leftPaddle);
    ball.collide(rightPaddle);

    // Check if the ball has gone off the screen
    //
    //ADDITION/CHANGE: specified what should happen if ball goes off the left of the screen. if ball goes off left of the screen, then..
    if (ball.isOffScreen()=="OFF LEFT") {
      //the right player's score increases by 1
      rightPlayerScore=rightPlayerScore+1;
      //the timer starts 
      startTime = millis();
      //the time that has passed since a player scored is set at 0
      timePassed=0;
      //the score appears on the screen
      isAppearing =true;
      // and the ball gets reset to the middle of the screen
      ball.reset();
    }

    //ADDITION: specified what should happen if ball goes off the right of the screen. if ball goes off left of the screen, then..
    if (ball.isOffScreen()=="OFF RIGHT") {
      //the left player's score increases by 1
      leftPlayerScore=leftPlayerScore+1;
      //The timer starts
      startTime = millis();
      //the time that has passed since a player scored is set at 0
      timePassed=0;
      //the score appears on the screen
      isAppearing =true;
      // and the ball gets reset to the middle of the screen
      ball.reset();
    }

    // Display the paddles and the ball
    leftPaddle.display();
    rightPaddle.display();
    ball.display();

    //ADDITION:if it is true that the left player's score is bigger than 10, then...
    if (leftPlayerScore>=10) {
      //the game stops
      playGame=false;
      //and the text "Mr. left alien!!" is drawn
      whoWon=" Mr. left alien!!";
    }

    //ADDITION: if it is true that the right player's score is bigger than 10 then...
    if (rightPlayerScore>=10) {
      //the game stops
      playGame=false;
      //and the text "Mr. right alien!! is drawn
      whoWon=" Mr. right alien!!";
    }
  }

  //ADDITION: if playGame is false then...
  else {
    //the background becomes black
    background (0);
    //the words "You just won," and either "Mr. left alien!!" or "Mr. right alien!!" appear 
    fill(random(0, 255), random(0, 255), random(0, 255));
    textSize(29);
    text (onePlayerWon+whoWon, 50, height/2);
  }
}


// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}