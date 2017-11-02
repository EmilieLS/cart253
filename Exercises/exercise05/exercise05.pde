//Took code from slides "Math Tricks (07)" from slide "Independent Pets"
//Removed these balls
//float t1 = random(0,100);
//float t2 = random(0,100);

//making an array for the balls to increase number. had to make it an array list to be able to remove the balls from the array later
FloatList balls = new FloatList();
//array to store the x valu of the balls 
FloatList xValueOfBalls= new FloatList();



void setup() {
  size(500, 500);
  //putting 15 balls on screen
  for (int i=0; i< 15; i = i+1) {
    //setting the value of this list & and setting a random number for the perlin noise
    balls.set(i, random(10, 450));
  }
}

void draw() {
  background(0);
  //REMOVED this code from original code
  // float petOneX = width*noise(balls[0]);
  // ellipse(petOneX,100,20,20);
  // float petTwoX = width*noise(balls[1]);
  //ellipse(petTwoX,400,20,20);
  //balls[0]+= 0.01;
  //balls[1]+= 0.01;

  //drawing the noise. the balls will loop according to the size of the list in the current array (changes whether of not balls have been clicked)
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
}

//this function will  determine what to do when the mouse is pressed on one of the balls (the ball will disappear!)
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