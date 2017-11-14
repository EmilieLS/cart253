


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


  size(640, 480);
  background(backgroundColor);
  //this is where we are creating the object bouncer iself. It's like the setup() function but it's used to create an individual object. A new bouncer is created from the class bouncer.
  //CHANGE: made speed of bouncer slower
  bouncer = new Bouncer(width/2, height/2, 0.6, 0.6, 50, color(150, 0, 0, 50), color(255, 0, 0, 50));
  //CHANGE: made speed of bouncer slower
  bouncer2 = new Bouncer(width/2, height/2, -0.6, 0.6, 50, color(0, 0, 150, 50), color(0, 0, 255, 50));
}
//call methods on the objects
void draw() {
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

//REMOVED the code that plays the file when the mouse is clicked 