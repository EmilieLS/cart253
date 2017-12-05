//the code for the mountain mostly comes from here: //<>//
/*
 By Joan Soler-Adillon
 www.joan.cat
 processing.joan.cat
 @jsoleradillon
 */


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

////ADDED an array storing the bullshit Cubes
//BullshitCube[] bullshitCubes=new BullshitCube [9];


//ADDED: array to make specific words for each feminist cube
String []feministSpheresArray = {"FEMME\nFRIENDS", "CONSENT", "BELL HOOKS\nBOOK", "SEXUAL EMPOWEREMENT", "SELF\nLOVE", "COMMUNITY", "ALLIES", "ACTIVE\nLISTENING", "INTERSECTIONALITY", "TRANS\nINCLUSIVITY"};
//ADDED: array to make specific words for each cube of bullshit
String [] bullshitCubesArray= {"SLUT\nSHAMING", "MIKE\nPENCE", "FAT\nSHAMING", "I'M\nNOT\nRACIST!\nBUT", "THAT'S\nSO\nGAY", "FRAT\nBOYZ", "TRANSPHOBIA", "STRAIGHT\nCIS\nWHITE\nGUYS", "TOXIC\nMASCULINITY"};

//ADDITION: for avatar 
//generating a random number to be used in the noise function in draw (?)
float tx = random(0, 100);
float ty = random(0, 100);
//declaing image variable
PImage img;

void setup() {
  //changed size 
  //ADDED 3D feature
  size(1300, 800, P3D);


  //ADDITION: initializing avatar (image of a girl)
  img = loadImage("girl.jpg");

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
    //
    yoff += yincrement;
  }
  

  
}


void draw() {
  background(255);
  
 


  //ADDITION of avatar with the noise function
  //used the noise function to make the avatr move in a more life-like manner.
  float x = width * noise(tx);
  float y = height * noise(ty);
  //ADDITION in order to not make the avatar go below the mountains
  y = constrain(y, 0, 400);
  //ADDITION in order to not make the avatar go out the sides of the screen
  x = constrain(x, 0, 1200);
  image(img, x, y, 110, 120);
  //how fast the avatar moves
  tx += 0.006;
  ty += 0.006;



  //ADDED to change the font.
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



    //made the spheres move pretty slowly so you can semi-easily click it. the arraylist requires us to write the code this weird way. 
    spheres.set(i, spheres.get(i) + 0.0004);
    //store the X value of the sphere so we can access it during the click
    xValueOfspheres.set(i, sphereX);
  }


  //removed mouse pressed function

  //changed the limit
  for (int i=0; i<1300; i++) {
    line(i, m[i], i, height);
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
  
  
 
  
}


//this function will  determine what to do when the mouse is pressed on one of the spheres (the sphere will disappear!)
void mousePressed() {
  for (int i=0; i<spheres.size(); i=i+1) {
    //it is true that the mouse is within the X position of the sphere if its within its 20 pixel diameter
    boolean withinXPositionOfsphere= (mouseX> (xValueOfspheres.get(i)-50)) && (mouseX< (xValueOfspheres.get(i)+50));
    //it is true that the mouse is within the y position of the sphere if its within its 20 pixel height
    //CHANGED parameters accordingly with the new interval of the spheres on the y axis
    boolean withinYPositionOfsphere=(mouseY> (i*50)) && (mouseY< (i*50)+60);

    //if the mouse is touching a sphere when it is clicked then
    if (withinXPositionOfsphere && withinYPositionOfsphere) {
      // newX=mouseX;

      //the sphere that was clicked is removed
      spheres.remove(i);
      //had to do this because postiion of spheres on x axis were defined separately because the noise was generated accoridng to x value
      xValueOfspheres.remove(i);
    }
  }
}