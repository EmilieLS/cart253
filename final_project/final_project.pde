//declare object avatar //<>//
Avatar avatar;

//ADDED:default value for r (red) is 255
float r=100;
//ADDED: for better fading and brightning of red on mountains
boolean isBrightning=false;

//ADDED: The background colour during play (black)
color backgroundColor = color(255);

// array for the moutains. m is every pixel position for the mountains
float m[] = new float[1300];
//offset on the y axis begins at 0 ???
float yoff = 0;
//how much the mountains grow on the y axis
float yincrement = 0.03;
//removed noiseVar

//ADDED:declaring variables to be able to manipulate the y position of the spheres and boxes
float sphereY;
float boxY;


//making an array for the spheres to increase number. had to make it an array float list to be able to remove the spheres from the array later
FloatList spheres = new FloatList();
//array to store the x value of the spheres 
//FloatList xValueOfspheres= new FloatList();
FloatList yValueOfSpheres= new FloatList();
FloatList xValueOfSpheres= new FloatList();


//making an array for boxes to increase number. had to make it an array float list to be able to remove the box from the array later
FloatList boxes= new FloatList();
//array to store the x value of the boxes 
FloatList xValueOfBoxes= new FloatList();
FloatList yValueOfBoxes= new FloatList();

//ADDED: array to make specific words for each feminist cube
String []feministSpheresArray = {"FEMME\nFRIENDS", "CONSENT", "BELL HOOKS\nBOOK", "SEXUAL EMPOWEREMENT", "SELF\nCARE", "COMMUNITY", "ALLIES", "ACTIVE\nLISTENING", "INTERSECTIONALITY", "TRANS\nINCLUSIVITY"};
//ADDED: array to make specific words for each box of offensive crap
String [] boxesArray= {"SLUT\nSHAMING", "MIKE\nPENCE", "FAT\nSHAMING", "I'M\nNOT\nRACIST!\nBUT", "THAT'S\nSO\nGAY", "FRAT\nBOYZ", "TRANSPHOBIA", "STRAIGHT\nCIS\nWHITE\nGUYS", "TOXIC\nMASCULINITY"};

//ADDITION: declaring variable imgage
PImage img;

//ADDITION: declaring and initializing of score and making the score start at 0 
int score=0;

//ADDED: Text for the mountains
String feministHell= "Feminist Hell";

//ADDITION: declaring and initializing new variable which will tells the game that the player won making the message below appear
String playerWon="Girl, you did it.\nYOUR JOURNEY OF SELF-CARE AND LOVE, READING FEMINIST LITERATURE AND NURTURING YOUR COMMUNITY HELPED YOU STAY CLEAR OF\nFEMINIST HELL";
//ADDITION: declaring long variable (type for long integers) that tells processing the time the timer starts (when a player scores)
long startTime;
//ADDITION: declaring variable that tells processing how much time has passed since the timer was started (since the player has scored)
long timePassed;
//ADDITION: declaring and initializing variable which stops the timer after 2.5 seconds
int expireTime =2500;
//ADDITION: declaring and initializing variable which stores the value false. This variable will make the score appear.
boolean isAppearing =false;
//ADDITION: declaring and initializing variable which stores the value true. This variable will tell processing whether game is still being played or not.
boolean playGame=true;


void setup() {
  //CHANGED size 
  //ADDED 3D feature
  size(1300, 800, P3D);
  //ADDED frame rate
  frameRate(30);

  //CHANGED by removing 5 spheres from array.
  //putting 10 spheres on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    spheres.set(i, random(0, width));
    //setting x values of spheres here. will have 110 pixels in between each sphere
    xValueOfSpheres.set(i, (i*110));
  }

  //setting up perlin noise mountains. 
  for (int i=0; i<1300; i++) {
    //CHANGE: made the mountains go up less high
    m[i] = height/1.80 + noise(yoff)*height/1.80;
    //WHAT IS THIS ?
    yoff += yincrement;
  }

  //putting 9 boxes on screen
  for (int i=0; i< 9; i = i+1) {
    //setting the random value of this list 
    boxes.set(i, random(0, width));
    //setting x values of boxes. 110 pixels in between each box
    xValueOfBoxes.set(i, (i*110));
  }
  // Create the avatar at the centre of the screen
  //the keys used to control "up" and "down" are "w" for up and "s" for down, "a" for left, and "d" for right.
  avatar = new Avatar (width/2, height/2, 'w', 's', 'a', 'd');
}


void draw() {

  //ADDITION: if it is true that the game is being played, then do everything until line x (don't know when game ends yet).
  if (playGame==true) {

    background(backgroundColor);

    //ADDED Pfint to change the font.
    //CHANGED font ot be smaller
    PFont courierFont = createFont("Courier", 13);
    textAlign(CENTER, CENTER);


    //drawing the spheres. the spheres will loop according to the size of the list in the current array (changes whether of not spheres have been clicked)
    for (int i=0; i<spheres.size(); i=i+1) {
      //position of spheres on x axis is every 110 pixels, and position of spheres on y axis is controlled by the noise function to give cool movement.
      float sphereX=xValueOfSpheres.get(i);
      float sphereY=height*noise(spheres.get(i));
      //constraining the spheres not to go below the mountains
      sphereY = constrain(sphereY, 0, 500);


      //ADDED lights to spheres
      //lights();
      //ADDED: making the spheres
      pushMatrix();
      translate(sphereX, sphereY);
      //ADDITION: Made the spheres rotate on X axis so the the text could be seen more clearly
      rotateX(6);
      fill(240);
      //CHANGED spheres to spheres
      sphere(30);
      //ADDED: made the text red
      fill(255, 0, 0);
      textSize(13);
      textFont(courierFont);
      //ADDED: put the text above the spheres
      text(feministSpheresArray[i], 0, -50);
      popMatrix();

      //made the spheres move pretty slowly so you can semi-easily click them. 
      spheres.set(i, spheres.get(i)+0.008); 
      //making spheres move to the right of the screen
      xValueOfSpheres.set(i, sphereX+=5);
      yValueOfSpheres.set(i, sphereY);

      //if the spheres are off the right of the screen, put them back on the left of the screen to create a continuous flow
      float newX = xValueOfSpheres.get(i);
      if ((newX >1330)) {
        newX = -30;
      }
      xValueOfSpheres.set(i, newX);
    }


    //drawing the boxes. the boxes will loop according to the size of the list in the current array 
    for (int i=0; i<boxes.size(); i=i+1) {
      // position of boxes on x axis is every 110 pixels, and position of boxes on the y axis is controlled by the noise function to give cool movement.
      float boxX=xValueOfBoxes.get(i);
      float boxY=height*noise(boxes.get(i));
      //boxes dont go below the mountains
      boxY=constrain(boxY, 0, 500);


      //ADDED: making the boxes
      //ADDED lights to boxes
      //lights();
      pushMatrix();
      translate(boxX, boxY);
      rotateX(6);
      fill(240);
      box(30);
      //ADDED: made the text red
      fill(255, 0, 0);
      textFont(courierFont);
      textSize(13);
      //ADDED: put the text above the boxes
      text(boxesArray[i], 0, -50);
      popMatrix();


      //made the boxes move pretty slowly so you can semi-easily click them.  
      boxes.set(i, boxes.get(i) + 0.008);
      //making boxes move to the right of the screen
      yValueOfBoxes.set(i, boxY);
      xValueOfBoxes.set(i, boxX+=5);

      //if the boxes are off the right of the screen, put them back on the left of the screen to create a continuous flow
      float newX = xValueOfBoxes.get(i);
      if ((newX >1330)) {
        newX = -30;
      }
      xValueOfBoxes.set(i, newX);
    }

    //removed mouse pressed function

    //changed the limit
    for (int i=0; i<1300; i++) {
      //ADDED: made stroke apply only to the mountains
      pushStyle();
      //CHANGED stroke to be able to change colour of mountains over time to make them look more hellish
      //mountains become less and less red and more and more black
      stroke(r, 0, 0);
      //ADDED: made brightning and fading of red of mountains more progressive
      if (isBrightning==true) {
        r+=0.009;
      } else {
        r-=0.009;
      }
      //the mountains start to get red again once they are black
      if (r<2) {
        isBrightning=true;
      }
      //the mountains starts to fade to black when maximum redness is reached
      if (r>255) {
        isBrightning=false;
      }
      line(i, m[i], i, height);
      popStyle();
    }


    //making the mountains move to the left
    //changed the limit
    for (int i=0; i<1299; i++) {
      m[i] = m[i+1];
    }

    //CHANGED: last element of the array
    //CHANGE: made the mountains go up less high
    m[1299] = height/1.80+ noise(yoff)*height/1.80;
    yoff += yincrement;

    //updates the avatar
    avatar.update();
    //displays the avatar
    avatar.display();


    textFont(courierFont);
    //ADDED: put the text above the spheres
    textSize(60);
    text(feministHell, 500, 700);
  }
}

////for now, not dealing with this function
////this function will  determine what to do when the mouse is pressed on one of the spheres (the sphere will disappear!)
//void mousePressed() {
//  for (int i=0; i<spheres.size(); i=i+1) {
//    //it is true that the mouse is within the X position of the sphere if its within its 20 pixel diameter
//    boolean withinXPositionOfsphere= (mouseX> (xValueOfspheres.get(i)-50)) && (mouseX< (xValueOfspheres.get(i)+50));
//    //it is true that the mouse is within the y position of the sphere if its within its 20 pixel height
//    //CHANGED parameters accordingly with the new interval of the spheres on the y axis
//    boolean withinYPositionOfsphere=(mouseY> (i*50)) && (mouseY< (i*50)+60);

//    //if the mouse is touching a sphere when it is clicked then
//    if (withinXPositionOfsphere && withinYPositionOfsphere) {
//      // newX=mouseX;

//      //the sphere that was clicked is removed
//      spheres.remove(i);
//      //had to do this because postiion of spheres on x axis were defined separately because the noise was generated accoridng to x value
//      xValueOfspheres.remove(i);
//    }
//  }
//}



void keyPressed() {
  //call the avatar's key pressed method
  avatar.keyPressed();
}


// As for keyPressed, except for released!
void keyReleased() {
  //call the avatar's key released method
  avatar.keyReleased();
}