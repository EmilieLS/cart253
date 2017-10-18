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

//CHANGED: decalring variable "image"
PImage img;

//CHANGED: declaring and INITIALIZING(?) new variables for score and making the score start at 0 for both players 
int rightPlayerScore=0;
int leftPlayerScore=0;

//CHANGED
String onePlayerWon="You just won, ";

long startTime;
long timePassed;
int expireTime =3000;
boolean isFlashing =false;
boolean playGame=true;
String whoWon="";

// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size
  size(640, 480);

//CHANGED:initializing background image of space
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
  
  if (playGame==true){
    
  
    
    
  // Fill the background each frame so we have animation
  //
  if(isFlashing ==true){
   //found out how much time has passed since timer started
    timePassed = millis() -startTime;
    //if the time that has passed is biggger than 2 seconds then...
    if(timePassed>expireTime)
    {
      //stop the flashing
      isFlashing =false;
    }
  }
  background(backgroundColor);
  
  image(img, 0, 0);
  //tint(255,255);

//CHANGED: made score appear in right part of the top of screen
textSize(52);
if(isFlashing ==true)
{
 fill(random(0, 255), random(0, 255), random(0, 255));
 text(rightPlayerScore,210,240); 
}



//CHANGED:made score appear in left part of the top of screen
textSize(52);
if(isFlashing ==true)
{
 fill(random(0, 255), random(0, 255), random(0, 255));
text(leftPlayerScore,380,240); 
}


   

  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  ball.update();
  

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);

  // Check if the ball has gone off the screen
  //CHANGED: specified what should happen if ball goes off the left of the screen. if ball goes off left of the screen, then..
  if (ball.isOffScreen()=="OFF LEFT") {
    //the right player's score increases by 1
    rightPlayerScore=rightPlayerScore+1;
    startTime = millis();
    timePassed=0;
    isFlashing =true;
    // and the ball gets reset to the middle of the screen
    ball.reset();
  }
  
  //CHANGED: specified what should happen if ball goes off the right of the screen. if ball goes off left of the screen, then..
   if (ball.isOffScreen()=="OFF RIGHT") {
    //the left player's score increases by 1
    leftPlayerScore=leftPlayerScore+1;
    startTime = millis();
    timePassed=0;
    isFlashing =true;
    // and the ball gets reset to the middle of the screen
    ball.reset();
  }

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
  
  //changed
  if (leftPlayerScore>=10) {
    playGame=false;
    whoWon=" Mr. left alien!!";
  }
 
  if (rightPlayerScore>=10) {
    playGame=false;
    whoWon=" Mr. right alien!!";
  }
 
}
//if plaGame is false
else {
background (0);
fill(random(0, 255), random(0, 255), random(0, 255));
textSize(22);
text (onePlayerWon+whoWon,50, height/2);


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