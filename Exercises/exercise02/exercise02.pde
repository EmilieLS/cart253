/*Generally, this program has a ball starting from midde of the screen, and one can use the arrow keys to move a paddle at the bottom of the screen. If the ball touches the paddle, it bounces off it, and then bounces off one of the edges of the screen to come back down to the bottom of the screen. If the ball does not touch the paddle, it starts to move from its inital place, which is in the middle of the screen. */ 

/*this section defines the properties of the variables that will be used*/
//declaring variable backgroundcolour and declaring it will be black.
color backgroundColor = color(0);

/*declaring properties of the static spots that appear and disappear.*/
//declaring that there are 1000 static spots.
int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
//declaring that the colour of the static spots will be light gray.
color staticColor = color(200);


/* declaring the variables processing will need to use to create the paddle (white rectangle) at the bottom of the screen.*/
int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);


/*declaration of the variables processing will need to create the "ball" (the white square) that moves around the screen.*/
int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);

/*calling setup function, which tells processing what we want to happen at the start of the program. Void is declaring that the fucntion included in the setup function return no value.*/
void setup() {
  //size of screen
  size(640, 480);
  
/*calling these functions in the setup function will be used to tell processing where the paddle and the ball at the start of the program.*/
  setupPaddle();
  setupBall();
}

/*declaring the start location of the paddle and the speed of the paddle at the start of the program  */
void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

/*declaring the start location of the ball and the speed of the ball at the start of the program  */
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

/*calling the draw function, thus telling processing what we want to happen every frame of the program.  */ 
void draw() {
  //background in under the draw function because we don't want the gray dots, ball, and paddle to leave their trace on the screen.
  background(backgroundColor);

/*calling these functions in the draw functions tells processing that these functions will have to happen every frame.*/
  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

/*declaring the drawStatic function tells processing what to do every frame with the little gray static specks */
void drawStatic() {
  //calling "for" function is telling processing to do a sequence of repetitions until certain actions are done a set number of times.
  // i=0 is declaring that at the start of the loop, the variable i has a value of 0. i< numStatic is declaring the condition for this loop: if the variable i has a integer value under 1000 (so maximum is 999), then the loop keeps going. If the variable i has the value above 999, the loop ends. i++ tells processing to add 1 to the variable i at the end of each loop. The opening curly bracket announces we are about to tell processing what action we want to do over and over in the loop.
  for (int i = 0; i < numStatic; i++) {
   //the random function will give x a random floating point between the point 0 on the x-axis and the width of the screen.
    float x = random(0,width);
   //the random function will give y a random floating point between the point 0 on the y-axis and the height of the screen.
   float y = random(0,height);
   //the size of the static gray spots with be a random floating number between 1 and 3. 
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}

//the updatePaddle function tells processing what actions to do with the paddle.
void updatePaddle() {
  //the location of the paddle on the x-axis is equal to the location of the paddle on the x-axis plus the speed at which the paddle travels on the x-axis. 
  paddleX += paddleVX;  
  //the location of the paddle on the x-axis will be between the 64th pixel on the x-axis and the width of the window minus 64 pixels.
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

//the updateBall function tells processing what actions to do with the ball every frame.
void updateBall() {
  // the location of the ball on the x-axis is equal to the location of the paddle on the x-axis plus the speed at which the ball travels on the x-axis..          
  ballX += ballVX;
  //the location of the ball on the x-axis is equal to the location of the paddle on the x-axis plus the speed at which the ball travels on the y-axis.
  ballY += ballVY;
  
  /* calling functions that tell processing what to do what to do when the ball hits the paddle, hits the wall of the screen, and hits the bottom of the screen.*/
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

// defining the function to draw the paddle which will be drawn every frame.
void drawPaddle() {
  //calling this function tells processing the the x and y coordinates of the paddle are at the center of the paddle, and not the top left corner.
  rectMode(CENTER);
  //the paddle will have no stroke. 
  noStroke();
  //the paddle will be white.
  fill(paddleColor);
  //draw paddle at paddleX and paddleY, and the paddle will have a width of 128 and a height of 16, will be at 464 on the y-axis.
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

//telling processing what actions to do with the ball every frame.
void drawBall() {
  //calling this function tells processing the the x and y coordinates of the ball are at the center of the ball, and not the top left corner.
  rectMode(CENTER);
  //the ball will have no stroke. 
  noStroke();
  //the colour of the ball will be white.
  fill(ballColor);
  //drawing the ball at the location of ballX and ballY at that moment, and with have a width of 16 and a height of 16.
  rect(ballX, ballY, ballSize, ballSize);
}

//defining the function that tells processing what to do when the ball hits the paddle.
void handleBallHitPaddle() {
  /* if this function returns true, THEN */ 
  if (ballOverlapsPaddle()) {
    // the location of the ball on the y-axis is equal to 464 minus 8 minus 8 (so 448), THEN 
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    //velosity is reversed  
    ballVY = -ballVY;
  }
}

//defining what the function ballOverlarpsPaddle does
boolean ballOverlapsPaddle() {
  //if it is true that the location of the ball on the x-axis minus 8 is bigger than the location of the paddle on the x-axis minus 64 AND that the location of the ball on the x-axis plus 8 is smaller than the location of the paddle on the x-axis plus 64,  
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    //if it is true that the location of the ball on the y-axis is bidder and the location of the paddle on the y-axis minus 8
    if (ballY > paddleY - paddleHeight/2) {
      /*if it is true, the function will return true, otherwise will return false*/
      return true;
    }
}
  return false;
}

//function to tell processing what to do if the ball hits the bottom of the screen.
void handleBallOffBottom() {
  //if it is true that the ball hits the bottom of the screen, then
  if (ballOffBottom()) {
    //the location of the ball on the a-xis will be at 320.
    ballX = width/2;
   //the location of the ball on the y-axis will be at 240.
    ballY = height/2;
  }
}

//defining what the function ballOffBottom does
boolean ballOffBottom() {
  //if it is true that the location of the ball on y-axis minus 8 is bigger than 640, then the function return true, otherwise the function will return false.
  return (ballY - ballSize/2 > height);
}

//defining function telling processing what to do if the ball hit one of the walls.
void handleBallHitWall() {
  //if it is true that the the location of the ball on the x-axis minus 8 is smaller than 0, THEN,
  if (ballX - ballSize/2 < 0) {
    //the location of the ball on the X-axis will be 8.
    ballX = 0 + ballSize/2;
    //and the velosity will be reversed
    ballVX = -ballVX;
    //if all the conditions turn out to be false, THEN IF this next expression is true...
  } else if (ballX + ballSize/2 > width) {
    //then the location of the ball on the x-axis will be equal to 640 minus 8.
    ballX = width - ballSize/2;
    //the velosity of the ball will be reversed.
    ballVX = -ballVX;
  }
  
  //if it is true the that the location of the ball on the y-axis minus 8 is smaller than 0, THEN
  if (ballY - ballSize/2 < 0) {
    //the location of the ball on the y-axis will be equal to 8.
    ballY = 0 + ballSize/2;
    //the velosity of the ball will be reversed.
    ballVY = -ballVY;
  }
}

//this function tells processing what to do if a key is pressed
void keyPressed() {
  //if it is true that the left key is pressed
  if (keyCode == LEFT) {
   //then the velosity of the paddle will be reversed. 
    paddleVX = -paddleSpeed;
  // if the condition turns out to be false and the right key is pressed, THEN we look at if the right is pressed
} else if (keyCode == RIGHT) {
  //the speed of the paddle is 10.
    paddleVX = paddleSpeed;
  }
}

//this function tells processing what to do if a key is released.
void keyReleased() {
  //if it is true that the left key is release AND that the speed of the paddle is smaller than 0, THEN
  if (keyCode == LEFT && paddleVX < 0) {
    //the speed of the paddle is 0
    paddleVX = 0;
    //if it is false that left key is released AND that the speed of the paddle is smaller than 0, then if it is true that the right key is released  AND that the speed of the paddle is greater than 0, THEN
  } else if (keyCode == RIGHT && paddleVX > 0) {
    //the speed of the paddle is 0.
    paddleVX = 0;
  }
}