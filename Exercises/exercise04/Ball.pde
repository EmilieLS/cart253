class Ball {
  // Limits for energy level and gains/losses
  int maxEnergy = 255;
  int moveEnergy = -1;
  int collideEnergy = 10;
  int collideGriddieAndBall= 10;
  //balls will disappear as they collide with griddies
  int collideEnergyOfBallAndGriddie=-1000;

  // Position, size, energy, and fill color
  int x;
  int y;
  int size;
  int energy;
  color fill = color(0, 0, 255);

  // Ball(tempX, tempY, tempSize)
  //
  // Set up the Ball with the specified location and size
  // Initialise energy to the maximum
  Ball(int tempX, int tempY, int tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    energy = maxEnergy;
  }

  // update()
  //
  // Move the ball and update its energy levels
  void update() {

    // If it true that the energy of a griddie is equal to zero then...
    if (energy == 0) {
      //stop doing this function
      return;
    }

    //the ball movement updating for both the y and x axis happens through a random integer being picked between -1 and 1. the new location of the ball
    //is equal to the size of the balls multipled by -1, 0, 1. this means that the new balls appear pretty much directly beside the old balls, and also 
    //some of them disappear (when multiplied by 0). 
    int xMoveType = floor(random(-1, 2));
    int yMoveType = floor(random(-1, 2));
    x += size * xMoveType;
    y += size * yMoveType;

    // if statement makes the balls reappaer on the opposite side of the screen they went off of. 
    if (x < 0) {
      x += width;
    } else if (x >= width) {
      x -= width;
    }
    if (y < 0) {
      y += height;
    } else if (y >= height) {
      y -= height;
    }

    // Update the ball's energy
    energy += moveEnergy;

    // Constrain the balls' energy level to be within the defined bounds
    energy = constrain(energy, 0, maxEnergy);
  }

  // collide(other)
  //
  // Checks for collision with the other balls
  // and updates energy level
  
  void collide(Ball other) {
    //if one ball is dead OR the ball we are checking is dead, they don't collide with each other, so
    if (energy == 0 || other.energy == 0) {
      //stop doing this function
      return;
    }

    if (x == other.x && y == other.y) {
      // Increase this ball's energy
      energy += collideEnergy;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }

  //Checks for collision between Griddies and Balls
  // and updates energy level
  void collideGriddieAndBall(Griddie g) {
    if (energy ==0 || g.energy == 0) {
      return;
    }

    if (x == g.x && y == g.y) {
      // Increase this ball's energy
      energy += collideEnergyOfBallAndGriddie;
      // Constrain the energy level to be within bounds
      energy = constrain(energy, 0, maxEnergy);
    }
  }


  // display()
  //
  // Draw the ball on the screen as an ellipse
  void display() {

    fill(fill, energy); 
    noStroke();
    ellipse(x, y, size, size);
  }
}