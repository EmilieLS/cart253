/*
 By Joan Soler-Adillon
 www.joan.cat
 processing.joan.cat
 @jsoleradillon
*/

float m[] = new float[600];
float yoff = 0;
float yincrement = 0.005;
float noiseVar = 1;


void setup() {
  //changed size 
  size(600, 600);

  for (int i=0;i<600;i++) {
    m[i] = noise(yoff)*height; //<>//
    yoff += yincrement;
  }
}

void draw() {
  background(255);

//removed mouse pressed function

//changed the limit
  for (int i=0;i<600;i++) {
    line(i, m[i], i, height);
  }

//changed the limit
  for (int i=0;i<599;i++) {
    m[i] = m[i+1];
  }

//changed last element of the array
  m[599] = noise(yoff)*height;
  yoff += yincrement;
}