float t1 = random(0,100);
float t2 = random(0,100);
void setup() {
  size(500,500);
}
void draw() {
  background(0);
  float petOneX = width*noise(t1);
  ellipse(petOneX,100,20,20);
  float petTwoX = width*noise(t2);
  ellipse(petTwoX,400,20,20);
  t1+= 0.01;
  t2+= 0.01;
}