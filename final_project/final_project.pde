// array for the moutains. m is every pixel position for the mountains //<>//
float m[] = new float[1300];
//offset on the y axis begins at 0 ???
float yoff = 0;
//how much the mountains grow on the y axis
float yincrement = 0.03;
//removed noiseVar


//declare object avatar
Avatar avatar;

//ADDED:default value for r (red) is 255
float r=100;
//ADDED: for better fading and brightning of red on mountains
boolean isBrightning=false;

//ADDED: The background colour during play (black)
color backgroundColor = color(255);


//ADDED:declaring variables to be able to manipulate the y position of the spheres and boxes
float sphereY;

//arrays that store y and x values of spheres. had to make them array float lists to be able to remove the spheres from the array later 
FloatList yValueOfSpheres = new FloatList();
//removed spheres array
FloatList xValueOfSpheres= new FloatList();
//stores array that makes it easier to deal with noise function
FloatList noiseMarkerSpheres= new FloatList();


//stores array that makes it easier to deal with noise function
FloatList noiseMarkerBoxes= new FloatList();
//array to store the x and y value of the boxes. had to make them array float lists to be able to remove the boxes from the array later
FloatList xValueOfBoxes= new FloatList();
FloatList yValueOfBoxes= new FloatList();

//ADDED: array to make specific words for each feminist cube
String []feministSpheresArray = {"FEMME\nFRIENDS", "CONSENT", "BELL HOOKS", "EMPOWEREMENT", "SELF\nCARE", "COMMUNITY", "ALLIES", "ACTIVE\nLISTENING", "INTERSECTIONALITY", "INCLUSIVITY"};
//ADDED: array to make specific words for each box of offensive crap
String [] boxesArray= {"SLUT\nSHAMING", "MIKE\nPENCE", "FAT\nSHAMING", "UNPAID\nLABOR", "THAT'S\nSO\nGAY", "FRAT\nBOYZ", "TRANSPHOBIA", "IGNORENCE", "TOXIC\nMASCULINITY"};

//ADDITION: declaring variable imgage
//PImage img = loadImage("lost image.jpg");


//ADDITION: declaring and initializing of score and making the score start at 0 
int score=0;

//ADDED: Text for the mountains
String feministHell= "Feminist Hell";

//ADDITION: The beginning of the text of when the game is over
String endText="GIRL";
//ADDITION: declaring and initializing new variable which will tells the game that the player won making the message below appear
String gameOutcome=" ";
//ADDITION: declaring long variable (type for long integers) that tells processing the time the timer starts (when a player scores)
long startTime;
//ADDITION: declaring variable that tells processing how much time has passed since the timer was started (since the player has scored)
long timePassed;
//ADDITION: declaring and initializing variable which stops the timer after 2.5 seconds
int expireTime =2500;
//ADDITION: declaring and initializing variable which stores the value false. This variable will make the score appear.
boolean isAppearing =false;
//ADDITION: declaring and initializing variable which tells processing
//which screen to show. This variable will tell processing whether game is being played or not.
//String homeGame="home";
//String playGame="play";
//String endGame="end";

//ADDED a global boolean to see if the player is dragging
boolean draggingBox =false;
int draggingIndex =-1;


void setup() {
  //CHANGED size 
  //ADDED 3D feature
  size(1300, 800, P3D);

  //CHANGE: moved all code for mountains before everything else to make text appear in front of the mountains
  //setting up perlin noise mountains. 
  for (int i=0; i<1300; i++) {
    //CHANGE: made the mountains go up less high
    m[i] = height/1.80 + noise(yoff)*height/1.80;
    //WHAT IS THIS ?
    yoff += yincrement;
  }

  //CHANGED by removing 5 spheres from array.
  //putting 10 spheres on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    yValueOfSpheres.set(i, random(0, height));
    //setting x values of spheres here. will have 110 pixels in between each sphere
    xValueOfSpheres.set(i, (i*120));
    //setting random value of this list which is useful for the noise
    noiseMarkerSpheres.set(i, random(0, 1000));
  }

  //putting 9 boxes on screen
  for (int i=0; i< 9; i = i+1) {
    //setting the random value of this list 
    yValueOfBoxes.set(i, random(0, width));
    //setting x values of boxes. 110 pixels in between each box
    xValueOfBoxes.set(i, (i*120));
    //setting random value of this list which is useful for the noise
    noiseMarkerBoxes.set(i, random(0, 1000));
  }

  // Create the avatar at the top centre of the screen
  //the keys used to control "up" and "down" are "w" for up and "s" for down, "a" for left, and "d" for right.
  avatar = new Avatar (width/2, 60, 'w', 's', 'a', 'd');
}


void draw() {

  //ADDITION: if it is true that the game is being played, then do everything until line x (don't know when game ends yet).
  //if (homeGame=="ongoing game") {
  background(backgroundColor);

  //ADDED: text for score
  textSize(40);
  textAlign(CENTER, CENTER);
  //make the score appear in middle top of the screen in the middle of the y-axis in random colours
  fill(random(0, 255), random(0, 255), random(0, 255));
  text(score, width/2, 40);

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


  //ADDED Pfont to change the font.
  //CHANGED font ot be smaller
  PFont courierFont = createFont("Courier", 60);
  textAlign(CENTER, CENTER);
  //ADDED a new font for the "feminist hell" text at bottom of the screen.
  PFont appleChancery=createFont("Apple-Chancery", 60);


  //drawing the spheres. the spheres will loop according to the size of the list in the current array (changes whether of not spheres have been collided with)
  for (int i=0; i<yValueOfSpheres.size(); i=i+1) {
    //position of spheres on x axis is every 120 pixels and moves to the right, 
    //and position of spheres on y axis is controlled by the noise function to give cool movement.
    //spheres move to the right at the speed of 5
    float sphereX=xValueOfSpheres.get(i)+5;
    float sphereY=height*noise(noiseMarkerSpheres.get(i));


    //ADDED: making the spheres
    pushMatrix();
    //ADDED lights to spheres
    lights();
    translate(sphereX, sphereY);
    //ADDITION: Made the spheres rotate on X axis so the the text could be seen more clearly
    rotateX(6);
    fill(255);
    // stroke(50);
    //CHANGED spheres to spheres
    sphere(20);
    //push and pop style because I didn't want colour of text to affect avatar
    pushStyle();
    //ADDED: made the text red
    fill(255, 0, 0);
    textFont(courierFont);
    textSize(13);
    //ADDED: put the text above the spheres
    text(feministSpheresArray[i], 0, -40);
    popStyle();
    popMatrix();

    //storing the X value of the ball so we can access it for the collision
    xValueOfSpheres.set(i, sphereX);
    //constraining the spheres not to go below the mountains.DOESNT WORK.
    yValueOfSpheres.set(i, constrain(sphereY, 0, 500));
    //made the spheres move pretty slowly so player can semi-easily collide with them
    noiseMarkerSpheres.set(i, noiseMarkerSpheres.get(i)+0.005); 


    //if the spheres are off the right of the screen, put them back on the left of the screen to create a continuous flow
    float newX = xValueOfSpheres.get(i);
    if ((newX >1330)) {
      newX = -30;
    }
    xValueOfSpheres.set(i, newX);
  }


  //drawing the boxes. the boxes will loop according to the size of the list in the current array 
  for (int i=0; i<yValueOfBoxes.size(); i=i+1) {

    //ADDED:if the boxes are being dragged, they follow the mouse. otherwise,
    //position of boxes on x axis is every 110 pixels, 
    //and position of boxes on the y axis is controlled by the noise function to give cool movement.
    //boxes move to the right at speed of 5
    float boxX =0;
    float boxY =0;
    if (draggingIndex!=i)
    {
      boxX=xValueOfBoxes.get(i)+5;
      boxY=height*noise(noiseMarkerBoxes.get(i));
    } else
    {
      boxX = mouseX;
      boxY = mouseY;
    }

    //ADDED: making the boxes
    //ADDED lights to boxes
    //lights();
    pushMatrix();
    translate(boxX, boxY);
    rotateX(6);
    fill(240);
    box(30);
    //ADDED: made the text red
    pushStyle();
    fill(255, 0, 0);
    textFont(courierFont);
    textSize(13);
    //ADDED: put the text above the boxes
    text(boxesArray[i], 0, -50);
    popStyle();
    popMatrix();

    //storing the X value of the ball so we can access it for the collision
    xValueOfBoxes.set(i, boxX);
    //constraining the spheres not to go below the mountains
    yValueOfBoxes.set(i, constrain(boxY, 0, 500));
    //float yValueOfBoxes=constrain(boxY,0,300);
    //made the spheres move pretty slowly so player can semi-easily collide with them
    noiseMarkerBoxes.set(i, noiseMarkerBoxes.get(i)+0.005); 

    //if boxes are not dragged and
    if (draggingIndex!=i)
    {
      //if the boxes are off the right of the screen, put them back on the left of the screen to create a continuous flow
      float newX = xValueOfBoxes.get(i);
      if ((newX >1330)) {
        newX = -30;
      }
      xValueOfBoxes.set(i, newX);
    }
  }


  //ADDED: text feminist hell at bottom of  screen in new font
  pushStyle();
  pushMatrix();
  translate(650, 750, 10);
  textFont(appleChancery);
  //ADDED: put the text above the spheres
  textSize(40);
  fill(0);
  text(feministHell, 0, 0);
  popMatrix();
  popStyle();


  //updates the avatar
  avatar.update();
  //displays the avatar
  avatar.display();
  //checks if avatar collides with spheres
  avatar.collide();
  //} 

  //  else {

  //    //the words  appear in random colours every frame "Girl, you did it.\nYOUR JOURNEY OF SELF-CARE AND LOVE, READING FEMINIST LITERATURE AND NURTURING YOUR COMMUNITY HELPED YOU STAY CLEAR OF\nFEMINIST HELL";
  //    fill(random(0, 255), random(0, 255), random(0, 255));
  //    textSize(29);
  //    text (endText+gameOutcome, 500, height/2);

  //    //THIS IS PART OF SETUP. WILL IT WORK HERE?
  //      //setting up perlin noise mountains. 
  //  for (int i=0; i<1300; i++) {
  //    //CHANGE: made the mountains go up less high
  //    m[i] = height/1.80 + noise(yoff)*height/1.80;
  //    //WHAT IS THIS ?
  //    yoff += yincrement;
  //  }


  ////DRAW
  ////image(img,300,0);
  ////Added mountains to end screen. this was in the draw function above, 
  //wondering if i have to copy the entire code for the mountain again
  //    for (int i=0; i<1300; i++) {
  //      pushStyle();
  //      stroke(r, 0, 0);
  //      if (isBrightning==true) {
  //        r+=0.009;
  //      } else {
  //        r-=0.009;
  //      }
  //      if (r<2) {
  //        isBrightning=true;
  //      }
  //      if (r>255) {
  //        isBrightning=false;
  //      }
  //      line(i, m[i], i, height);
  //      popStyle();
  //    }

  //    //making the mountains move to the left
  //    for (int i=0; i<1299; i++) {
  //      m[i] = m[i+1];
  //    }

  //    m[1299] = height/1.80+ noise(yoff)*height/1.80;
  //    yoff += yincrement;
  //  }
  
  
}

//ADDED: mouse dragged function to be able to drag the boxes into feminist hell 
void mouseDragged() {

  if (draggingBox ==false) {
    draggingIndex =-1;

    for (int i=0; i<yValueOfBoxes.size(); i=i+1) {
      //it is true that the mouse is within the X position of the ball if its within its 20 pixel diameter
      boolean withinXPositionOfBox= (mouseX>xValueOfBoxes.get(i)-30 && mouseX< (xValueOfBoxes.get(i)+30));
      //it is true that the mouse is within the y position of the ball if its within its 20 pixel height
      boolean withinYPositionOfBox=(mouseY>yValueOfBoxes.get(i)-30 && mouseY< (yValueOfBoxes.get(i)+30));

      //if the mouse is touching a box when it is clicked then
      if (withinXPositionOfBox && withinYPositionOfBox) {
        //the box is dragged
        draggingBox = true;
        draggingIndex =i;
        break;
      }
    }
  }
}

//when mouse is released, the dragging stops
void mouseReleased()
{
  draggingBox = false;
  draggingIndex =-1;
  //if (mouseY>800) {
  //  xValueOfBoxes.remove(i);
  //  yValueOfBoxes.remove(i);
  //  score=score+1;
  //}
}



void keyPressed() {
  //call the avatar's key pressed method
  avatar.keyPressed();
}


// As for keyPressed, except for released!
void keyReleased() {
  //call the avatar's key released method
  avatar.keyReleased();
}