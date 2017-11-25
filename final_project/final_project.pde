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


//making an array for the boxes to increase number. had to make it an array float list to be able to remove the boxes from the array later
FloatList boxes = new FloatList();
//array to store the x value of the boxes 
FloatList xValueOfboxes= new FloatList();

//ADDED: array to make specific word for each feminist cube
String []feministboxesArray = {"FEMME\nFRIENDS", "CONSENT", "BELL HOOKS\nBOOK", "SEXUAL EMPOWEREMENT", "SELF\nLOVE", "COMMUNITY", "ALLIES", "ACTIVE\nLISTENING", "INTERSECTIONALITY", "TRANS\nINCLUSIVITY"};




void setup() {
  //changed size 
  //ADDED 3D feature
  size(1300, 800, P3D);

  //CHANGED by removing 5 boxes from array
  //putting 10 boxes on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    boxes.set(i, random(0, width));
  }


  //setting up perlin noise mountains. 
  for (int i=0; i<1300; i++) {
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
  PFont courierFont = createFont("Courier", 13);
  textAlign(CENTER, CENTER);


  //drawing the boxes. the boxes will loop according to the size of the list in the current array (changes whether of not boxes have been clicked)
  for (int i=0; i<boxes.size(); i=i+1) {
    float boxX=boxes.get(i);
    //moving the boxes to go off the left of the screen
    float newX = boxes.get(i)+2;
    
    

//CHANGED direction of the boxes
    //if the boxes are off the right of the screen, put them back on the left of the screen to create a continuous flow
    if ((newX >1330)) {
      newX = -30;
    }
    boxes.set(i, newX);


    //ADDED: making the boxes
    //boxes will be placed at intervals of 50 pixels on y axis
    pushMatrix();
    //CHANGED the boxes to be more separated on the y axis and made the entire box show on the screen
    translate(boxX, (i*50)+60);
    fill(240);
    //CHANGED boxes to boxes
    box(25);
    //ADDED: made the text red
    fill(255, 0, 0);
    textFont(courierFont);
    //ADDED: put the text above the boxes
    text(feministboxesArray[i], 0, -35);
    popMatrix();



    //made the boxes move pretty slowly so you can semi-easily click it. the arraylist requires us to write the code this weird way. 
    boxes.set(i, boxes.get(i) + 0.0004);
    //store the X value of the box so we can access it during the click
    xValueOfboxes.set(i, boxX);
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
  m[1299] = height/2 + noise(yoff)*height/2;
  yoff += yincrement;
}


//this function will  determine what to do when the mouse is pressed on one of the boxes (the box will disappear!)
void mousePressed() {
  for (int i=0; i<boxes.size(); i=i+1) {
    //it is true that the mouse is within the X position of the box if its within its 20 pixel diameter
    boolean withinXPositionOfbox= (mouseX> (xValueOfboxes.get(i)-10)) && (mouseX< (xValueOfboxes.get(i)+50));
    //it is true that the mouse is within the y position of the box if its within its 20 pixel height
    //CHANGED parameters accordingly with the new interval of the boxes on the y axis
    boolean withinYPositionOfbox=(mouseY> (i*50)) && (mouseY< (i*50)+60);

    //if the mouse is touching a box when it is clicked then
    if (withinXPositionOfbox && withinYPositionOfbox) {
      //the box that was clicked is removed
      boxes.remove(i);
      //had to do this because postiion of boxes on x axis were defined separately because the noise was generated accoridng to x value
      xValueOfboxes.remove(i);
    }
  }
}