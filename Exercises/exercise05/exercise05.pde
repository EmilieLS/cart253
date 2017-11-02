//float t1 = random(0,100);
//float t2 = random(0,100);

//making an array for the balls to increase number
float[] balls = new float [15];


void setup() {
  size(500,500);
  for (int i=0; i< 15; i = i+1) {
  balls[i]=random(10,450);
}
}

void draw() {
  background(0);
 // float petOneX = width*noise(balls[0]);
 // ellipse(petOneX,100,20,20);
 // float petTwoX = width*noise(balls[1]);
  //ellipse(petTwoX,400,20,20);
  //balls[0]+= 0.01;
  //balls[1]+= 0.01;
  
  for (int i=0; i<15; i=i+1) {
    float ball=width*noise(balls[i]);
    ellipse(ball,(i*30)+10,20,20);
    balls[i]+=0.02;
    
  }
}