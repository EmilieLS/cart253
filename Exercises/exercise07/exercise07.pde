//ADDED BALLS TO HAVE MORE INTERACTION WITH MUSIC 
//making an array for the balls to increase number. had to make it an array float list to be able to remove the balls from the array later
FloatList balls = new FloatList();
//array to store the x value of the balls 
FloatList xValueOfBalls= new FloatList();

//ADDED: Import the sound library
import processing.sound.*;

//ADDED: storing sound in a variable
SoundFile songOne;
SoundFile songTwo;


//declaring objects
//CHANGED: background to black
color backgroundColor = color(0);
//declared variable type Bouncer and called it bouncer. The object is bouncer.
Bouncer bouncer;
//declared a variable type Bouncer and called it bouncer2. The object is bouncer2. Both objects have the same type.
Bouncer bouncer2;

//initializing objects
void setup() {

  // ADDED We load a sound by creating a new SoundFile and giving it the path to the file
  songOne = new SoundFile(this, "Moth.mp3");
  //made the song start after 14 seconds
  songOne.cue(14);
  //made song one slower
  songOne.rate(0.9);

  //ADDED another sound file
  songTwo = new SoundFile(this, "tinkling.wav");
  //made the sound file a little slower
  songTwo.rate(0.9);


  //ADDED: putting 15 balls on screen
  for (int i=0; i< 15; i = i+1) {
    //setting the value of this list & and setting a random number for the perlin noise
    balls.set(i, random(10, 450));
  }





  size(640, 480);
  background(backgroundColor);
  //this is where we are creating the object bouncer iself. It's like the setup() function but it's used to create an individual object. A new bouncer is created from the class bouncer.
  //CHANGE: made speed of bouncer slower
  bouncer = new Bouncer(width/2, height/2, 0.6, 0.6, 50, color(150, 0, 0), color(255, 0, 0));
  //CHANGE: made speed of bouncer slower
  bouncer2 = new Bouncer(width/2, height/2, -0.6, 0.6, 50, color(0, 0, 150), color(0, 0, 255));
}



//call methods on the objects
void draw() {
  //ADDED: So the bouncers and balls don't leave a trace
  background(0);

  //ADDED: drawing the noise. the balls will loop according to the size of the list in the current array (changes whether of not balls have been clicked)
  for (int i=0; i<balls.size(); i=i+1) {
    float ballX=width*noise(balls.get(i));
    //ellipse will be placed at intervals of 30 pixels on y axis, and the entire ellipse will be showing on screen.
    ellipse(ballX, (i*30)+10, 20, 20);
    //REMOVED THIS CODE
    //balls[i]+=0.01;
    //made the balls move pretty slowly so you can semi-easily click it. the arraylist requires us to write the code this weird way. 
    balls.set(i, balls.get(i) + 0.004);
    //store the X value of the ball so we can access it during the click
    xValueOfBalls.set(i, ballX);
  }




  /* declared the bouncer's methods */
  //declared the update method for bouncer object. updates the bouncer each freame
  bouncer.update();
  //declared the update method for bouncer2 variable
  bouncer2.update();
  //declared the draw method for boucer variable
  bouncer.draw();
  //declared the draw method for bouncer2 variable
  bouncer2.draw();
}


//ADDED: this function will  determine what to do when the mouse is pressed on one of the balls (the ball will disappear!)
void mousePressed() {
  for (int i=0; i<balls.size(); i=i+1) {
    //it is true that the mouse is within the X position of the ball if its within its 20 pixel diameter
    boolean withinXPositionOfBall= (mouseX> (xValueOfBalls.get(i)-10)) && (mouseX< (xValueOfBalls.get(i)+10));
    //it is true that the mouse is within the y position of the ball if its within its 20 pixel height
    boolean withinYPositionOfBall=(mouseY> (i*30)) && (mouseY< (i*30)+10+10);

    //if the mouse is touching a ball when it is clicked then
    if (withinXPositionOfBall && withinYPositionOfBall) {
      //the ball that was clicked is removed
      balls.remove(i);
      //had to do this because postiion of balls on x axis were defined separately because the noise was generated accoridng to x value
      xValueOfBalls.remove(i);
    }
  }
}


//REMOVED the code that plays the file when the mouse is clicked 