//This section defines the properties of the variables
//declaring circle speed and assigning this variable the value 7. Int signifying that the value is a number.Final signifing that the speed cannot change.
final int CIRCLE_SPEED = 7;
//declaring of fill color red-ish for circle if you don't click. Final signifying that the colour cannot change.
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
//declaring fill colour blue for circle that you're clicking on. Final signifying that the colour cannot change.
final color CLICK_FILL_COLOR = color(100, 100, 250);
//declaring background color pinkish (mostly red, a bit of green, a bit of blue). Final signifying that the background colour will not change.
final color BACKGROUND_COLOR = color(250, 150, 150);
//declaring stroke coulour pinkish (mostly red, a bit of green, a bit of blue). Final signifying that the stroke will no change colours.
final color STROKE_COLOR = color(250, 150, 150);
//declaring that circle is size 50 (both the width and the height). Final signifying that the circle will not change size. Int signifying that the value is a number.
final int CIRCLE_SIZE = 50;

//declaring the variables processing will need to use. 
//circleX is the location of the circle on the x-axis.
int circleX;
//circleY is the location of the circle on the y-axis.
int circleY;
//circleVX is the speed at which the circle moves on the x-axis.
int circleVX;
//circleVY is the speed at which the circle moves on the y-axis.
int circleVY;

//setup is declaring what we want to happen at the start of the program and signifying what the made up functions mean. The empty parathenses means the function has no parameters. The curly bracket means we are about to tell processing what to do with the setup function. Void is declaring that these funcitons return no value.
void setup() {
  //declaring the dimensions of the window. width is 640 pixels and height is 480 pixels.
  size(640, 480);
  //declaring that the start location of the circle on the x-axis is at the half of the width of the x axis (so at the 320th pixel).
  circleX = width/2;
  //declaring that the start location of the circle on the y-axis is at the half of the width of the y axis (so at 240th pixel).
  circleY = height/2;
  //declaring that the speed at which the circle will move at on the x-axis is 7.
  circleVX = CIRCLE_SPEED;
  //declaring that the speed at which the circle will move at on the y-axis is 7.
  circleVY = CIRCLE_SPEED;
  
  //declaring that the stroke colour is redish. (?)
  stroke(STROKE_COLOR);
  //declaring that the fill of the circle is redish when one doesn't click.
  fill(NO_CLICK_FILL_COLOR);
  //declaring that the background is pinkish. (?)
  background(BACKGROUND_COLOR);
  //declaring that we are done telling processing what to do with the setup function.
}

//declaring the draw function is telling processing what we want to happen every frame of the program. The empty parathenses means the function has no parameters. The curly bracket means we are about to tell processing what to do with the draw function.
void draw() {
  //declaring that if it is true the distance between the mouse and the circle's postition is smaller than 25 pixels (which is half of the size of the circle) then... (the curly brackets tell us what is going to happen if this is true)
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
    //then the fill of the circle when you click it willbe blue (as blue is the colour of the click_fill_coulour variable)
      fill(CLICK_FILL_COLOR);
      //declaring that the program is done telling processing what to draw if this first line of code is true.
  }
  //else signifies that if the first line of code is not true, something else will happen. The curly bracket signifies we are about to tell Processing what will happen if the first line of code is not true.
  else {
    //declaring that if the circle will remain red-ish, as this is the no_click_fill_color.
    fill(NO_CLICK_FILL_COLOR);
    //declaring that we are done telling processing what to draw if the first line of code in the draw function isn't true.
  }
  //declaring that the ellipse will be drawn at 320 on the x axis and 240 on the y axis and will have a width of 50 and a height of 50.
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  //declaring that the ellipse moves at speed of 7 on the x axis.
  circleX += circleVX;
  //declaring that the ellipse moves at speed of 7 on the y axis.
  circleY += circleVY;
  //declaring that if it is true that the location of the circle on the x axis plus 25 pixels is bigger than the width of the screen OR if it is true that the location of the circle on the x axis minus 25 is smaller than the point 0 on either the x or y axis( basically IF the circle has gone off the screen on the horizontal axis) , THEN
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    //velosity is reversed
    circleVX = -circleVX;
    //declaring we are done telling processing what to do if this condition is true
  }
  //like above, declaring that if it is true that the circle has gone off screen on the y axis THEN
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    //the velosity  is reversed
    circleVY = -circleVY;
    //declaring that we are done telling processing wha to do if this condition is true
  }
  //declaring that we are done telling processing what to draw.
}

//declaring the mousePressed function tells processing what happens when we click the mouse in the window. The empty parathenses means the function has no parameters. The curly bracket means we are about to tell processing what to do with the mousePressed function.
void mousePressed() {
  //declaring that where the mouse is pressed, the screen is cleared and the background will be pink.
  background(BACKGROUND_COLOR);
  //declaring that we are done telling processing what to do with the mousePressed function.
}