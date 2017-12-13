//Game: Becoming a better feminist! //<>//

//the point is to make 19 points in less then 1 minute
//the player can make points by 1)dragging the boxes (which are negative for someone's feminist growth)
//into feminist hell and 2) by moving the avatr and making it collide with the spheres.
//One point is made for each box dragged into feminist hell, and one point is made each time the avatar collides with a sphere

//ADDED: Import the video library for webcam
import processing.video.*;

//ADDED: Import the sound library
import processing.sound.*;

//The capture object for reading from the webcam
Capture video;

// array for the moutains. m is every pixel position for the mountains
float m[] = new float[1300];
//offset on the y axis begins at 0 ???
float yoff = 0;
//how much the mountains grow on the y axis
float yincrement = 0.03;
//removed noiseVar


//declare object avatar
Avatar avatar;


//ADDED:default value for r (red) is 255
float r=255;
//ADDED: for better fading and brightning of red on mountains
boolean isBrightning=false;

//removed background colour

//ADDED:declaring variables to be able to manipulate the y position of the spheres and boxes
float sphereY;

//arrays that store y and x values of spheres. had to make them array float lists to be able to remove the spheres from the array later 
FloatList yValueOfSpheres = new FloatList();
//removed spheres array
FloatList xValueOfSpheres= new FloatList();
//stores array that makes it easier to deal with noise function
FloatList noiseMarkerSpheres= new FloatList();

//stores array that makes it easier to deal with noise function
FloatList noiseMarkerBoxes= new FloatList();
//array to store the x and y value of the boxes. had to make them array float lists to be able to remove the boxes from the array later
FloatList xValueOfBoxes= new FloatList();
FloatList yValueOfBoxes= new FloatList();

//ADDED: new array to store x and y values of deprication cubes which will deduct a point from the score if avatar collides with them.
// had to makearray float lists to be able to remove the cubes from the array later
FloatList xValueOfDeprication= new FloatList();
FloatList yValueOfDeprication= new FloatList();
//ADDED: stores array that makes it easier to deal with noise function
FloatList noiseMarkerDeprication= new FloatList();


//ADDED: array to make specific words for each feminist cube
String []feministSpheresArray = {"FEMME FRIENDS", "CONSENT", "BELL HOOKS", "EMPOWEREMENT", "SELF CARE", "COMMUNITY", "ALLIES", "ACTIVE LISTENING", "INTERSECTIONALITY", "INCLUSIVITY"};
//ADDED: array to make specific words for each box of offensive crap
String [] boxesArray= {"SLUT SHAMING", "MANSPLAINERS", "FAT SHAMING", "UNPAID LABOR", "REPUBLICANS", "NOT ALL MEN", "FRAT BOYZ", "TRANSPHOBIA", "CAT CALLING", "TOXIC\nMASCULINITY"};
//ADDED: array for the word "deprication" to appear above new point-deducting cubes.
String [] DepricationArray={"SELF-DEPRICATION", "SELF-DEPRICATION", "SELF-DEPRICATION", "SELF-DEPRICATION", "SELF-DEPRICATION"};

//ADDITION: declaring variables imgage and heart
PImage girl;
PImage heart;

//ADDITION: declaring and initializing of score and making the score start at 0 
int score=0;

//ADDED: Text for the mountains
String feministHell= "Feminist Hell";


//ADDITION: The text that shows up on home screen
String intro= "\nWANT  TO PRACTICE  FEMINISM?\n\nAVOID FEMINIST HELL BY MAKING AT \nLEAST 16 POINTS UNDER  1  MINUTE.\n\n";
String rules="\n\n- DRAGGING AN OPPRESSIVE CUBE INTO FEMINIST HELL = +1\n\n-USING  ARROWS  TO  CATCH FEMINIST SPHERES = +1\n\n-COLLIDING WITH A SELF-DEPRICATING CUBE = -1";
//ADDITION: text saying to press shift to start
String pressShift="\nPRESS 'SHIFT' TO BEGIN :)";
//ADDED text to make sure player knows its easier to play this game with a partner :)
String friend="\nPLAY IN A TEAM WITH A FRIEND!";

//ADDITION: declaring and initializing new variable which will tells the game that the player won making the message below appear
String gameOutcome=" ";

//REMOVED code for text appearing and disappearing

//ADDED a global boolean to see if the player is dragging
boolean draggingBox =false;
int draggingIndex =-1;

//ADDITION: declaring and initializing variable which stores the value true. 
//This variable will tell processing whether game is still being played or not.
boolean playGame =true;

//ADDED: a boolean to see whether or not the player has pressed shift (which starts the game)
boolean isShiftPressed=false;
//ADDED: a boolean to see whether or not the player has pressed control (which starts the webcam)
boolean isControlPressed=false;


//ADDED: storing sound in a variable
SoundFile songBoxes;
SoundFile songSpheres;
SoundFile songLost;
SoundFile songWon;
//ADDED: storing sound in a variable for when a point is lost
SoundFile songMinusOne;

//Added variables for font
PFont snellRoundHandBold;
PFont courierFont;

//millis calculates how much time has passed since starting the program
long time=millis();
//ADDITION: declaring variable that tells processing how much time has passed since the timer was started (since the game was started)
long timePassed;


void setup() {
  //CHANGED size 
  //ADDED 3D feature
  size(1300, 800, P3D);

  //initialized font variables
  snellRoundHandBold = createFont("SnellRoundhand-Bold", 60);
  courierFont = createFont("Courier", 60);

  //setting up how big webcam screen will be, and the framerate.
  video= new Capture (this, 640, 480, 30);

  //ADDED: image of girl here for the home screen
  girl= loadImage("girl.png");
  //added hearts to end screens
  heart=loadImage("heart.jpg");

  //ADDED We load a sound by creating a new SoundFile and giving it the path to the file
  songBoxes = new SoundFile(this, "hell.mp3");
  songSpheres = new SoundFile(this, "twinkle.mp3");
  songLost = new SoundFile(this, "lost.mp3");
  songWon = new SoundFile(this, "won.mp3");
  //start this song after 50 seconds
  songWon.cue(50);
  //ADDED: song loaded for when a point is lost
  songMinusOne= new SoundFile(this, "minusOne.mp3");

  //CHANGE: moved all code for mountains before everything else to make text appear in front of the mountains
  //setting up perlin noise mountains. making them grow on the y axis.
  for (int i=0; i<1300; i++) {
    //CHANGE: made the mountains go up less high
    m[i] = height/1.80 + noise(yoff)*height/1.80;
    yoff += yincrement;
  }

  //CHANGED by removing 5 spheres from array.
  //putting 10 spheres on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    yValueOfSpheres.set(i, random(0, height));
    //setting x values of spheres here. will have 137 pixels in between each sphere
    xValueOfSpheres.set(i, (i*137));
    //setting random value of this list which is useful for the noise
    noiseMarkerSpheres.set(i, random(0, 1000));
  }


  //added one box
  //putting 10 boxes on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list 
    yValueOfBoxes.set(i, random(0, width));
    //setting x values of boxes. 137 pixels in between each box
    xValueOfBoxes.set(i, (i*137));
    //setting random value of this list which is useful for the noise
    noiseMarkerBoxes.set(i, random(0, 1000));
  }

  //ADDED: putting 4 cubes on the screen which deduct one point from the score if avatar hits them
  for (int i=0; i<5; i=i+1) {
    //y position of cubes is random
    yValueOfDeprication.set(i, random(0, height));
    //cubes are separated by 320 pixels on x axis
    xValueOfDeprication.set(i, i*320);
    //setting random value of this list which is useful for the noise
    noiseMarkerDeprication.set(i, random(0, 1000));
  }


  // Create the avatar at the top centre of the screen
  //removed code for old keys, as new keys are simply the arrows.
  avatar = new Avatar (550, 20);
}


void draw() {

  //CHANGE to put Pfont here to use it on home screen
  textAlign(CENTER, CENTER);

  //ADDED: if shift has not yet been pressed, then show the code below which is the homescreen
  if (isShiftPressed==false) {

    //background is black
    background (0);

    //draws image of girl  avatar
    image(girl, width/2-50, 30, 100, 100);

    //TEXT TO BE SHOWN ON HOME SCREEN
    textFont(courierFont);
    //text is purple and then turns into blue as code below show
    fill(r, 0, 200);
    textSize(22); 
    text (intro, width/2, 210);
    //ADDED: made brightning and fading of red of the text more progressive, making it change between purple and blue.
    if (isBrightning==true) {
      r+=0.009;
    } else {
      r-=0.009;
    }
    //the text start to get blue again once they are purple
    if (r<2) {
      isBrightning=true;
    }
    //the text starts to go blue again when maximum redness (so purple, as red+blue is purple) is reached.
    if (r>255) {
      isBrightning=false;
    }
    //removed separate fill for text
    textSize(19); 
    text (rules, width/2, 340);
    textSize(19);
    text(friend, width/2, 460);
    textSize(18); 
    text (pressShift, width/2, 500);

    //ADDED mountains for homescreen as well
    for (int i=0; i<1300; i++) {
      pushStyle();
      //CHANGED stroke to be able to change colour of mountains over time to make them look more hellish
      //mountains become less and less red and more and more black
      stroke(r, 0, 0);
      //ADDED: made brightning and fading of red of mountains more progressive
      if (isBrightning==true) {
        r+=0.001;
      } else {
        r-=0.001;
      }
      //the mountains start to get red again once they are black
      if (r<2) {
        isBrightning=true;
      }
      //the mountains starts to fade to black when maximum redness is reached
      if (r>255) {
        isBrightning=false;
      }
      line(i, m[i], i, height);
      popStyle();
    }


    //making the mountains move to the left
    //changed the limit
    for (int i=0; i<1299; i++) {
      m[i] = m[i+1];
    }

    //CHANGED: last element of the array
    //CHANGE: made the mountains go up less high
    m[1299] = height/1.80+ noise(yoff)*height/1.80;
    yoff += yincrement;
  } 
  //if shift has been pressed, start the game.
  else {

    //ADDITION: if it is true that the game is being played, then do everything until line x (don't know when the program ends).
    if (playGame ==true) {

      //ADDED: for getting how much time has passed
      timePassed = millis() -time;

      //printing how much time has passed since the program started
      println(timePassed);

      background(15);

      //ADDED: text for score
      textSize(40);
      textAlign(CENTER, CENTER);
      //make the score appear in middle top of the screen in the middle of the y-axis in random colours
      fill(random(0, 255), 0, random(0, 255));
      text(score, width/2, 40);

      //changed the limit
      for (int i=0; i<1300; i++) {
        //ADDED: made stroke apply only to the mountains
        pushStyle();
        //CHANGED stroke to be able to change colour of mountains over time to make them look more hellish
        //mountains become less and less red and more and more black
        stroke(r, 0, 0);
        //ADDED: made brightning and fading of red of mountains more progressive
        if (isBrightning==true) {
          r+=0.004;
        } else {
          r-=0.004;
        }
        //the mountains start to get red again once they are black
        if (r<2) {
          isBrightning=true;
        }
        //the mountains starts to fade to black when maximum redness is reached
        if (r>255) {
          isBrightning=false;
        }
        line(i, m[i], i, height);
        popStyle();
      }


      //making the mountains move to the left
      //changed the limit
      for (int i=0; i<1299; i++) {
        m[i] = m[i+1];
      }

      //CHANGED: last element of the array
      //CHANGE: made the mountains go up less high
      m[1299] = height/1.80+ noise(yoff)*height/1.80;
      yoff += yincrement;


      //removed second pfont 


      //drawing the spheres. the spheres will loop according to the size of the list in the current array (changes whether of not spheres have been collided with)
      for (int i=0; i<yValueOfSpheres.size(); i=i+1) {
        //position of spheres on x axis is every 120 pixels and moves to the right, 
        //and position of spheres on y axis is controlled by the noise function to give cool movement.
        //spheres move to the right at the speed of 2.5
        float sphereX=xValueOfSpheres.get(i)+2.5;
        float sphereY=height*noise(noiseMarkerSpheres.get(i));


        //ADDED: making the spheres
        pushMatrix();
        //push and pop style because I didn't want colour of text to affect avatar
        pushStyle();
        //ADDED lights to spheres
        //lights();
        translate(sphereX, sphereY);
        //ADDITION: Made the spheres rotate on X axis so the the text could be seen more clearly
        rotateX(6);
        stroke(200, 0, 255);
        fill(0);
        // stroke(50);
        //CHANGED spheres to spheres
        sphere(20);
        //ADDED: made the text red
        fill(200, 0, 255);
        textFont(courierFont);
        textSize(14.5);
        //ADDED: put the text above the spheres
        text(feministSpheresArray[i], 0, -40);
        popStyle();
        popMatrix();

        //storing the X value of the ball so we can access it for the collision
        xValueOfSpheres.set(i, sphereX);
        //constraining the spheres not to go below the mountains.DOESNT WORK.
        yValueOfSpheres.set(i, constrain(sphereY, 0, 500));
        //made the spheres move pretty slowly so player can semi-easily collide with them
        noiseMarkerSpheres.set(i, noiseMarkerSpheres.get(i)+0.0005); 


        //if the spheres are off the right of the screen, put them back on the left of the screen to create a continuous flow
        float newX = xValueOfSpheres.get(i);
        if ((newX >1330)) {
          newX = -30;
        }
        xValueOfSpheres.set(i, newX);
      }




      //drawing the boxes. the boxes will loop according to the size of the list in the current array 
      for (int i=0; i<yValueOfBoxes.size(); i=i+1) {

        //ADDED:if the boxes are being dragged, they follow the mouse. otherwise,
        //position of boxes on x axis is every 110 pixels, 
        //and position of boxes on the y axis is controlled by the noise function to give cool movement.
        //boxes move to the right at speed of 1.5
        float boxX =0;
        float boxY =0;
        if (draggingIndex!=i)
        {
          boxX=xValueOfBoxes.get(i)+1.5;
          boxY=height*noise(noiseMarkerBoxes.get(i));
        } else
        {
          boxX = mouseX;
          boxY = mouseY;
        }

        //ADDED: making the boxes
        //ADDED lights to boxes
        //lights();
        pushMatrix();
        pushStyle();
        translate(boxX, boxY);
        //removed rotate
        fill(10);
        stroke(255, 0, 0);
        box(25);
        //ADDED: made the text red
        fill(255, 0, 0);
        textFont(courierFont);
        textSize(15);
        //ADDED: put the text above the boxes
        text(boxesArray[i], 0, -39);
        popStyle();
        popMatrix();

        //storing the X value of the ball so we can access it for the collision
        xValueOfBoxes.set(i, boxX);
        //constraining the spheres not to go below the mountains
        yValueOfBoxes.set(i, constrain(boxY, 0, 500));
        //float yValueOfBoxes=constrain(boxY,0,300);
        //made the spheres move pretty slowly so player can semi-easily collide with them
        noiseMarkerBoxes.set(i, noiseMarkerBoxes.get(i)+0.005); 

        //if boxes are not dragged and
        if (draggingIndex!=i)
        {
          //if the boxes are off the right of the screen, put them back on the left of the screen to create a continuous flow
          float newX = xValueOfBoxes.get(i);
          if ((newX >1330)) {
            newX = -30;
          }
          xValueOfBoxes.set(i, newX);
        }
      }

      //ADDED: drawing the deprication cubes. 
      //the cubes will loop according to the size of the list in the current array 
      //(changes whether of not cubes have been collided with)
      for (int i=0; i<yValueOfDeprication.size(); i=i+1) {
        //position of cube on x axis is every 400 pixels and moves to the right, 
        //and position of cubes on y axis is controlled by the noise function to give cool movement.
        //cubes move to the left at the speed of 1
        float depricationX=xValueOfDeprication.get(i)+2;
        float depricationY=height*noise(noiseMarkerDeprication.get(i));


        //ADDED: making the mainsplainer cubes
        pushMatrix();
        translate(depricationX, depricationY);
        pushStyle();
        fill(4);
        //they will be blue
        stroke(0, 0, 255);
        //CHANGED spheres to spheres
        box(20);
        //text is blue
        fill(0, 0, 255);
        textFont(courierFont);
        textSize(15);
        //put text above spheres
        text(DepricationArray[i], 0, -30);
        popStyle();
        popMatrix();

        //storing the X and y value of the cubes so we can access it for the collision
        xValueOfDeprication.set(i, depricationX);
        //constraining the spheres not to go below the mountains.
        yValueOfDeprication.set(i, constrain(depricationY, 0, 500));
        //made the cubes move pretty slowly so player can semi-easily collide with them
        noiseMarkerDeprication.set(i, noiseMarkerDeprication.get(i)+0.0005); 


        //if the cubes are off the right of the screen, put them back on the left of the screen to create a continuous flow
        float newX = xValueOfDeprication.get(i);
        if ((newX >1310)) {
          newX = -25;
        }
        xValueOfDeprication.set(i, newX);
      }


      //ADDED: text feminist hell at bottom of  screen in new font
      pushStyle();
      pushMatrix();
      textAlign(CENTER, CENTER);
      translate(width/2, 780, 10);
      textSize(26);
      fill(255, 0, 0);
      text(feministHell, 0, 0);
      popMatrix();
      popStyle();


      //updates the avatar
      avatar.update();
      //displays the avatar
      avatar.display();
      //checks if avatar collides with spheres
      avatar.collide();

      //ADDITION: if it is true that the player's score is bigger than 20 and fewer then 60 seconds has passed...
      if (score>=16 && timePassed<60000) {
        //the game stops
        playGame =false;
        //and the text below is drawn
        gameOutcome= "Girl(s), you did it.\nYour journey of self-care and love,\n and nurturing your community helped you\n grow as a feminist.\n\nPress 'control' to see\nhow wonderful you are! :)";
        //Added song when player wins
        songWon.play();
      }

      //ADDITION: if it is true that the player's score is smaller than 20 and more then 60 seconds has passed...
      if (score<=16 && timePassed>60000) {
        //the game stops
        playGame =false;
        //and the text below is drawn
        gameOutcome="Girl(s), you lost, but it's okay!\nKeep fighting the power by investing\nin yourself and other femmes.\n\nPress 'control' to see\nhow wonderful you are! :)";
        //ADDED song when player loses
        songLost.play();
      }
    }


    //if it isn't true that the game is being played...
    if (playGame==false) {
      //if "control" hasn't been pressed, then do all the stuff below.
      if (isControlPressed==false) {
        textAlign(CENTER, CENTER);
        //the background becomes black
        background (0);
        //the words of gameOutcome appear in random colours, and they depend on if player won or not)
        fill(255, 0, 0);
        textFont(snellRoundHandBold);
        textSize(35);
        text (gameOutcome, 680, 300);
        //ADDED display of score to end screens
        textFont(courierFont);
        fill(random(0, 255), 0, random(0, 255));
        text(score, width/2, 40);

        //ADDED moutains to end screen
        for (int i=0; i<1300; i++) {
          pushStyle();
          //CHANGED stroke to be able to change colour of mountains over time to make them look more hellish
          //mountains become less and less red and more and more black
          stroke(r, 0, 0);
          //ADDED: made brightning and fading of red of mountains more progressive
          if (isBrightning==true) {
            r+=0.001;
          } else {
            r-=0.001;
          }
          //the mountains start to get red again once they are black
          if (r<2) {
            isBrightning=true;
          }
          //the mountains starts to fade to black when maximum redness is reached
          if (r>255) {
            isBrightning=false;
          }
          line(i, m[i], i, height);
          popStyle();
        }

        //making the mountains move to the left
        //changed the limit
        for (int i=0; i<1299; i++) {
          m[i] = m[i+1];
        }

        //CHANGED: last element of the array
        //CHANGE: made the mountains go up less high
        m[1299] = height/1.80+ noise(yoff)*height/1.80;
        yoff += yincrement;
      }
      //if control has been pressed, then...
      if (isControlPressed==true) {
        //background is black
        background (0);
        //start the webcam
        video.start();
        // Draw the video frame to the screen
        image(video, width/2-305, height/2-240);
        //draw the images of hearts around the webcam.
        image(heart, 1000, 200, 100, 100);
        image(heart, 1100, 300, 80, 80);
        image(heart, 120, 400, 100, 100);
      }
    }
  }
}

//function reads the current video frame
void captureEvent(Capture video) {
  video.read();
}

//removed code i was trying out but wasn't working for end screens.

//ADDED: mouse dragged function to be able to drag the boxes into feminist hell 
void mouseDragged() {

  if (draggingBox ==false) {
    draggingIndex =-1;

    for (int i=0; i<yValueOfBoxes.size(); i=i+1) {
      //it is true that the mouse is within the X position of the ball if its within its 20 pixel diameter
      boolean withinXPositionOfBox= (mouseX>xValueOfBoxes.get(i)-30 && mouseX< (xValueOfBoxes.get(i)+30));
      //it is true that the mouse is within the y position of the ball if its within its 20 pixel height
      boolean withinYPositionOfBox=(mouseY>yValueOfBoxes.get(i)-30 && mouseY< (yValueOfBoxes.get(i)+30));

      //if the mouse is touching a box when it is clicked then
      if (withinXPositionOfBox && withinYPositionOfBox) {
        //the box is dragged
        draggingBox = true;
        draggingIndex =i;
        break;
      }
    }
  }
}

//void handleVideoInput() {


//  // If we're here, there IS a frame to look at so read it in
//  video.read();
//}

//when mouse is released, the dragging stops
//CHANGED: when mouse is released and is in bottom 100 pixels of screen on y axis, 
//then the boxes disappear and score increases by 1.
void mouseReleased()
{

  if (draggingIndex!=-1 && mouseY>700) {
    xValueOfBoxes.remove(draggingIndex);
    yValueOfBoxes.remove(draggingIndex);
    score=score+1;
    println("SCORE"+score);
    //Added: made a fire sound (hell song for the boxes) play when boxes are dropped into feminist hell
    songBoxes.play();
  }
  draggingBox = false;
  draggingIndex =-1;
}

void keyPressed() {
  //call the avatar's key pressed method
  avatar.keyPressed();
  if (key==CODED) {
    if (keyCode==SHIFT) {
      isShiftPressed=true;
      //ADDED: time of the program begins when shift is pressed
      time = millis();
    }
    if (keyCode==CONTROL) {
      isControlPressed=true;
    }
  }
}


// As for keyPressed, except for released!
void keyReleased() {
  //call the avatar's key released method
  avatar.keyReleased();
}