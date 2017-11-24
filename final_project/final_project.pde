//the code for the mountain mostly comes from here: //<>//
/*
 By Joan Soler-Adillon
 www.joan.cat
 processing.joan.cat
 @jsoleradillon
 */


// array for the moutains
float m[] = new float[800];
//offset on the y axis begins at 0 ???
float yoff = 0;
//how much the mountains grow on the y axis
float yincrement = 0.005;
//removed noiseVar


//making an array for the spheres to increase number. had to make it an array float list to be able to remove the spheres from the array later
FloatList spheres = new FloatList();
//array to store the x value of the spheres 
FloatList xValueOfspheres= new FloatList();

//ADDED: array to make specific word for each feminist cube
String []feministSpheresArray = {"FEMME\nFRIENDS", "CONSENT", "BELL HOOKS\nBOOK", "SEXUAL EMPOWEREMENT", "SELF\nLOVE", "COMMUNITY", "ALLIES", "ACTIVE\nLISTENING", "INTERSECTIONALITY", "TRANS\nINCLUSIVITY"};


void setup() {
  //changed size 
  //ADDED 3D feature
  size(800, 800, P3D);

  //CHANGED by removing 5 spheres from array
  //putting 10 spheres on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    spheres.set(i, random(0, width));
  }


  //setting up perlin noise mountains. 
  for (int i=0; i<800; i++) {
    //CHANGE: made the mountains go up less high
    m[i] = height/2 + noise(yoff)*height/2;
    //
    yoff += yincrement;
  }
}


void draw() {
  background(255);

  //ADDED to change the font.
  //CHANGED font ot be smaller
  PFont courierFont = createFont("Courier", 12);
  textAlign(CENTER,CENTER);


  //drawing the spheres. the spheres will loop according to the size of the list in the current array (changes whether of not spheres have been clicked)
  for (int i=0; i<spheres.size(); i=i+1) {
    float sphereX=spheres.get(i);
    //moving the spheres to go off the left of the screen
    float newX = spheres.get(i)-2;


    //if the spheres are off the left of the screen, put them back on the right of the screen to create a continuous flow
    if ((newX < -30)) {
      newX += width+30;
    }
    spheres.set(i, newX);


    //ADDED: making the spheres
    //spheres will be placed at intervals of 30 pixels on y axis, and the entire sphere will be showing on screen.
    pushMatrix();
    translate(sphereX, (i*50)+20);
    fill(240);
    //CHANGED spheres to boxes
    box(25);
    //ADDED: made the text red
    fill(255, 0, 0);
    textFont(courierFont);
    //ADDED: put the text above the spheres
    text(feministSpheresArray[i], 0, -35);
    popMatrix();



    //made the spheres move pretty slowly so you can semi-easily click it. the arraylist requires us to write the code this weird way. 
    spheres.set(i, spheres.get(i) + 0.0004);
    //store the X value of the sphere so we can access it during the click
    xValueOfspheres.set(i, sphereX);
  }


  //removed mouse pressed function

  //changed the limit
  for (int i=0; i<800; i++) {
    line(i, m[i], i, height);
  }

  //making the mountains move to the left
  //changed the limit
  for (int i=0; i<799; i++) {
    m[i] = m[i+1];
  }

  //CHANGED: last element of the array
  //CHANGE: made the mountains go up less high
  m[799] = height/2 + noise(yoff)*height/2;
  yoff += yincrement;
}


//this function will  determine what to do when the mouse is pressed on one of the spheres (the sphere will disappear!)
void mousePressed() {
  for (int i=0; i<spheres.size(); i=i+1) {
    //it is true that the mouse is within the X position of the sphere if its within its 20 pixel diameter
    boolean withinXPositionOfsphere= (mouseX> (xValueOfspheres.get(i)-10)) && (mouseX< (xValueOfspheres.get(i)+10));
    //it is true that the mouse is within the y position of the sphere if its within its 20 pixel height
    boolean withinYPositionOfsphere=(mouseY> (i*30)) && (mouseY< (i*30)+10+10);

    //if the mouse is touching a sphere when it is clicked then
    if (withinXPositionOfsphere && withinYPositionOfsphere) {
      //the sphere that was clicked is removed
      spheres.remove(i);
      //had to do this because postiion of spheres on x axis were defined separately because the noise was generated accoridng to x value
      xValueOfspheres.remove(i);
    }
  }
}