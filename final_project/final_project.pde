//the code for the mountain mostly comes from here: //<>//
/*
 By Joan Soler-Adillon
 www.joan.cat
 processing.joan.cat
 @jsoleradillon
 */

//declare object avatar
Avatar avatar;

//ADDED:default value for r (red) is 255
float r=255;

//ADDED: The background colour during play (black)
color backgroundColor = color(255);

// array for the moutains
float m[] = new float[1300];
//offset on the y axis begins at 0 ???
float yoff = 0;
//how much the mountains grow on the y axis
float yincrement = 0.005;
//removed noiseVar


//making an array for the spheres to increase number. had to make it an array float list to be able to remove the spheres from the array later
FloatList spheres = new FloatList();
//array to store the x value of the spheres 
FloatList xValueOfspheres= new FloatList();

//making an array for boxes to increase number. had to make it an array float list to be able to remove the box from the array later
FloatList boxes= new FloatList();
//array to store the x value of the boxes 
FloatList xValueOfBoxes= new FloatList();


//ADDED: array to make specific words for each feminist cube
String []feministSpheresArray = {"FEMME\nFRIENDS", "CONSENT", "BELL HOOKS\nBOOK", "SEXUAL EMPOWEREMENT", "SELF\nLOVE", "COMMUNITY", "ALLIES", "ACTIVE\nLISTENING", "INTERSECTIONALITY", "TRANS\nINCLUSIVITY"};
//ADDED: array to make specific words for each box of offensive crap
String [] boxesArray= {"SLUT\nSHAMING", "MIKE\nPENCE", "FAT\nSHAMING", "I'M\nNOT\nRACIST!\nBUT", "THAT'S\nSO\nGAY", "FRAT\nBOYZ", "TRANSPHOBIA", "STRAIGHT\nCIS\nWHITE\nGUYS", "TOXIC\nMASCULINITY"};

//ADDITION: declaring variable imgage
PImage img;

void setup() {
  //CHANGED size 
  //ADDED 3D feature
  size(1300, 800, P3D);
  //ADDED frame rate
  frameRate(30);

  //CHANGED by removing 5 spheres from array
  //putting 10 spheres on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    spheres.set(i, random(0, width));
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
  }
  // Create the avatar at the centre of the screen
  //the keys used to control "up" and "down" are "w" for up and "s" for down, "a" for left, and "d" for right.
  avatar = new Avatar (width/2, height/2, 'w', 's', 'a', 'd');
}


void draw() {

  background(backgroundColor);

  ////REMOVED avatar controlled by noise function 

  //ADDED Pfint to change the font.
  //CHANGED font ot be smaller
  PFont courierFont = createFont("Courier", 13);
  textAlign(CENTER, CENTER);


  //drawing the spheres. the spheres will loop according to the size of the list in the current array (changes whether of not spheres have been clicked)
  for (int i=0; i<spheres.size(); i=i+1) {
    float sphereX=spheres.get(i);
    //moving the spheres to go off the right of the screen
    float newX = spheres.get(i)+2;


    //CHANGED direction of the spheres
    //if the spheres are off the right of the screen, put them back on the left of the screen to create a continuous flow
    if ((newX >1330)) {
      newX = -30;
    }
    spheres.set(i, newX);

    //ADDED lights to spheres
    //lights();
    //ADDED: making the spheres
    //spheres will be placed at intervals of 50 pixels on y axis
    pushMatrix();
    //CHANGED the spheres to be more separated on the y axis and made the entire sphere show on the screen
    translate(sphereX, (i*50)+75);
    //ADDITION: Made the spheres rotate on X axis so the the text could be seen more clearly
    rotateX(6);
    fill(240);
    //CHANGED spheres to spheres
    sphere(30);
    //ADDED: made the text red
    fill(255, 0, 0);
    textFont(courierFont);
    //ADDED: put the text above the spheres
    text(feministSpheresArray[i], 0, -50);
    popMatrix();

    //made the spheres move pretty slowly so you can semi-easily click them. the arraylist requires us to write the code this weird way. 
    spheres.set(i, spheres.get(i) + 0.0004);
    //store the X value of the sphere so we can access it during the click
    xValueOfspheres.set(i, sphereX);
  }


  //drawing the boxes. the boxes will loop according to the size of the list in the current array 
  for (int i=0; i<boxes.size(); i=i+1) {
    float boxX=boxes.get(i);
    //moving the boxess to go off the right of the screen
    float newX = boxes.get(i)+2;



    //if the boxes are off the right of the screen, put them back on the left of the screen to create a continuous flow
    if ((newX >1330)) {
      newX = -30;
    }
    boxes.set(i, newX);


    //ADDED: making the boxes
    //ADDED lights to boxes
    //lights();
    pushMatrix();
    //boxes will be placed at intervals of 50 pixels on y axis
    translate(boxX, (i*50)+75);
    rotateX(6);
    fill(240);
    box(30);
    //ADDED: made the text red
    fill(255, 0, 0);
    textFont(courierFont);
    //ADDED: put the text above the boxes
    text(boxesArray[i], 0, -50);
    popMatrix();

    //made the boxes move pretty slowly so you can semi-easily click them. the arraylist requires us to write the code this weird way. 
    boxes.set(i, boxes.get(i) + 0.0004);
    //store the X value of the boxes so we can access it during the click
    xValueOfspheres.set(i, boxX);
  }


  //removed mouse pressed function

  //changed the limit
  for (int i=0; i<1300; i++) {
    //ADDED: made stroke apply only to the mountains
    pushStyle();
    //CHANGED stroke to be able to change colour of mountains over time to make them look more hellish
    //mountains become less and less red and more and more black
    stroke(r, 0, 0);
    r-=0.002;
    //if variable r (red) is smaller than two, the mountains get completely red again
    if (r<2) {
      r=255;
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
}

//for now, not dealing with this function
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