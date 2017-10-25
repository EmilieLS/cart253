// Griddie
//
// A class defining the behaviour of a single Griddie
// which can move randomly in the window (within the grid),
// loses energy per move, and gains energy from overlapping
// with another Griddie.

class Griddie {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(255, 0, 0);

  // Griddie(tempX, tempY, tempSize)
  //
  // Set up the Griddie with the specified location and size
  // Initialise energy to the maximum
  Griddie(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the Griddie and update its energy levels
  void update() {

    // QUESTION: What is this if-statement for?
    //ANSWER: If it true that the energy of a griddie is equal to zero then...
    if (energy == 0) {
      //then we stop doing this function.
      return;
    }

    // QUESTION: How does the Griddie movement updating work?
    //ANSWER: the griddie movement updating for both the y and x axis happens through a random integer being picked between -1 and 1. the new location of the griddies 
    //is equal to the size of the the griddies multipled by -1, 0, 1. this means that the new griddies appear pretty much directly beside the old gritties, and also 
    //some of them disappear (when multiplied by 0). 
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // QUESTION: What are these if statements doing?
    //ANSWER: it makes the grddies reappaer on the opposite side of the screen they went off of. 
    //if it is true that the x location of a griddie is smaller than 0, then...
    if (x < 0) {
      //the location of the griddie on the x axis will be equal to the location of the griddie on the x axis plus the width of the screen, so it will reappear on screen.
      x += width;
      //if the above condition is not true, then we look at 
      //if it is true that the location of the griddies on the x axis is greater than or equal to the width, then... 
    } else if (x >= width) {
      //the location of a griddie on the x axis will be equal to the location of the griddie on the x axis minus the width of the screen, so it will reappear on screen.
      x -= width;
    }
    //if it is true that the location of the griddie on the y axis is smaller than zero, then...
    if (y < 0) {
      //the y location of the griddie will be equal to the location of the griddie on the y axis plus the height of the screen, so it will reappear on the screen. 
      y += height;
      //if the above condition is not true, we check if it is true that the y location of the griddie is greater than or equal to the height of the screen, then...
    } else if (y >= height) {
      //the location of the griddie on the y axis will be the y location of the griddie minus the height of the screen.
      y -= height;
    }

    // Update the Griddie's energy
    // Note that moveEnergy is negative, so this _loses_ energy
    energy += moveEnergy;

    // Constrain the Griddies energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other Griddie
  // and updates energy level

  void collide(Griddie other) {
    // QUESTION: What is this if-statement for?
    //ANSWER: if one griddie is dead OR the griddie we are checking is dead, they don't collide with each other, so
    if (energy == 0 || other.energy == 0) {
      //stop doing this function
      return;
    }

    // QUESTION: What does this if-statement check?
    //ANSWER: checks if a griddie collides with another one. if it does, its energy increases (within bounds).
    //if it is true that a griddie's location on the x axis is equal to another griddie's location on the x axis AND
    //if it is true that a griddie's location on the y axis is equal to another griddie's location on the y axis
    if (x == other.x && y == other.y) {
      // Increase this Griddie's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  // display()
  //
  // Draw the Griddie on the screen as a rectangle
  void display() {
    // QUESTION: What does this fill line do?
    //ANSWER: the fill is red, but the opacity decreases as the energy does
    fill(fill, energy); 
    noStroke();
    rect(x, y, size, size);
  }
}