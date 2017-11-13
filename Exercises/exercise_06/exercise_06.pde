
// Exercise 06
//
// Using the webcam as input to play with Bouncers.

// Import the video library
import processing.video.*;

// The capture object for reading from the webcam
Capture video;

// A PVector allows us to store an x and y location in a single object
// When we create it we give it the starting x and y 
////CHANGE: took away negative 1 because starting with negative value gave a negative pixel coordinate
PVector reddestPixel = new PVector(1, 1);

// An array of bouncers to play with
Bouncer[] bouncers = new Bouncer[10];



// setup()
//
// Creates the bouncers and starts the webcam

void setup() {
  size(640, 480);

  // Our old friend the for-loop used to go through the length of an
  // array adding new objects to it (Bouncers in this case)
  for (int i = 0; i < bouncers.length; i++) {
    // Each Bouncer just starts with random values 
    bouncers[i] = new Bouncer(random(0, width), random(0, height), random(-10, 10), random(-10, 10), random(20, 50), color(random(255)));
  }

  // Start up the webcam
  video = new Capture(this, 640, 480, 30);
  video.start();
}

// draw()
//
// Processes the frame of video, draws the video to the screen, updates the Bouncers
// and then just draws an ellipse at the brightest pixel location. You code should
// do something much more interesting in order to actually interact with the Bouncers.

void draw() {
  // A function that processes the current frame of video
  handleVideoInput();

  // Draw the video frame to the screen
  image(video, 0, 0);

  // Our old friend the for-loop running through the length of an array to
  // update and display objects, in this case Bouncers.
  // If the brightness (or other video property) is going to interact with all the
  // Bouncers, it will need to happen in here.


  for (int i = 0; i < bouncers.length; i++) {
    bouncers[i].update();
    bouncers[i].display();
    //calculating the location of the reddest pixel
    int loc= int(reddestPixel.x)+ int(reddestPixel.y) * width; 
    //making the colours of the bouncers become the same colour as the reddest pixel
    bouncers[i].fillColor=video.pixels[loc];
  }



  // For now we just draw a crappy ellipse at the brightest pixel
  fill(#ff0000);
  stroke(#ffff00);
  strokeWeight(10);
  ellipse(reddestPixel.x, reddestPixel.y, 20, 20);
}

// handleVideoInput
//
// Checks for available video, reads the frame, and then finds the brightest pixel
// in that frame and stores its location in brightestPixel.

void handleVideoInput() {
  // Check if there's a frame to look at
  if (!video.available()) {
    // If not, then just return, nothing to do
    return;
  }

  // If we're here, there IS a frame to look at so read it in
  video.read();

  // Start with a very low "record" for the brightest pixel
  // so that we'll definitely find something better
  //made the record about redness. 
  //CHANGE: had to make the redness record higher because the webcam wasn't finding anything red with the record set to 0
  float rednessRecord = 1000;

  // Go through every pixel in the grid of pixels made by this
  // frame of video
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      // Calculate the location in the 1D pixels array
      int loc = x + y * width;
      // Get the color of the pixel we're looking at
      color pixelColor = video.pixels[loc];
      // CHANGE: finding the reddest pixel
      float amount = dist(255, 0, 0, red(pixelColor), green(pixelColor), blue(pixelColor));
      // CHANGE: Check if this pixel is the reddest
      if (amount < rednessRecord) {
        // If it is, change the record value. CHange: made it about redness
        rednessRecord = amount;
        //CHANGE: remember where the reddest pixel is in the grid of pixels
        //by setting the Pvector reddestPixel's x and y properties
        reddestPixel.x = x;
        reddestPixel.y = y;
      }
    }
  }
}