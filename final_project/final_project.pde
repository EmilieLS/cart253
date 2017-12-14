/*Artist's statement: //<>//

I decided I would be very motivated to create my game if it were to be inspired by a concept I cared and knew about a lot. Feminism is very important to me, so I chose to make a 
game that shows people how to become better feminists. This theme gave me ample ideas for things the improving feminist player could "reject" (i.e. republicans, mainsplainers, 
cat calling, etc., as well as self-deprecation, which every improving feminist should avoid). This theme also gave me many ideas for things the player could strive to have
(thus the "femme friends", "Bell Hooks", and "intersectional" feminist spheres). This dualism that arose in my feminist theme allowed me to develop a game in which two actions
are needed to win: dragging the oppressive cubes into feminist hell with a mouse, and using the arrows to make the avatar collide with feminist concepts (and avoid self-Deprecation!).
I think this dual action is creative, especially that these actions were coded with the fact that this game should be a cooperative game in mind. Indeed, feminism is a movement 
towards community building and anti-individualism, and I wanted my feminist game to reflect that. Therefore, two players work together to win!
Additionally, songs by Rihanna and Beyoncé - feminist idols - play at the end of the game, making women feel warm and welcomed, whether they won or lost! 
A webcam at the end also shows the player how wonderful they are (I was careful not to say "beautiful", because women's worth is sadly mostly placed on their beauty). 
I was also careful to use language directed at women on the end screens, because women could use a space to feel specifically welcomed, as many spaces are unwelcoming to us.

I believe a specifically interesting coding technique I used was the coding for the movement of the boxes, spheres, and self-deprecating cubes.
It was difficult figuring out how to make them move in a flowing way with the noise function on the y axis without the speed of the cubes on the x axis influencing
the movement of the objects on the y axis. A totally separate array needed to be created to implement the noise. It was also hard figuring out how to make elements of arrays
disappear, as we had not really looked at this much in the exercises nor in class. A floatList was what was necessary to remove elements from the arrays.

I designed my work on the programming knowledge I gained over the course almost exclusively. I used the exercises we did in class as well as the 
midterm "Pong" as models. Thanks to the class and these coded examples, I was able to use classes, arrays, sound, the webcam, an internal timer for 
the game, 3D rendering, how to change fonts, how to make objects collide, how to implement functions like keyPressed() and mouseDragged(), and more. 
I tried to take something we learned from every week and implement it into my game.

I hope you enjoy learning to be a better feminist!

*/

/*Game: Becoming a better feminist!
the point is to make 19 points in less then 1 minute
the player can make points by 1)dragging the boxes (which are negative for someone's feminist growth)
into feminist hell and 2) by moving the avatr and making it collide with the spheres.
One point is made for each box dragged into feminist hell, and one point is made each time the avatar collides with a sphere */

//ADDED: Import the video library for webcam
import processing.video.*;

//The capture object for reading from the webcam
Capture video;

//ADDED: Import the sound library
import processing.sound.*;

//ADDED: storing sound in a variable for when boxes are dropped into feminist hell,
//when avatar collides with spheres and self-Deprecation cubes, for when game is lost, and for when game is won.
SoundFile songBoxes;
SoundFile songSpheres;
SoundFile songLost;
SoundFile songWon;
SoundFile songMinusOne;

/* The base for the code for the mountains comes from here:
 By Joan Soler-Adillon
 www.joan.cat
 processing.joan.cat
 @jsoleradillon
*/

// array for the moutains. m is every pixel position for the mountains
float m[] = new float[1300];
//offset on the y axis begins at 0.
float yoff = 0;
//how much the mountains grow on the y axis
float yincrement = 0.03;
//ADDED: value for r (red) is 255
float r=255;
//ADDED: for better fading and brightning of red on mountains
boolean isBrightning=false;

//declare object avatar
Avatar avatar;

//removed background colour
//removed random sphereY variable

//arrays that store y and x values of spheres. had to make them array float lists to be able to remove the spheres from the array later 
FloatList yValueOfSpheres = new FloatList();
FloatList xValueOfSpheres= new FloatList();
//stores array that makes it easier to deal with noise function
FloatList noiseMarkerSpheres= new FloatList();

//stores array that makes it easier to deal with noise function
FloatList noiseMarkerBoxes= new FloatList();
//array to store the x and y value of the boxes. had to make them array float lists to be able to remove the boxes from the array later
FloatList xValueOfBoxes= new FloatList();
FloatList yValueOfBoxes= new FloatList();

//ADDED: new array to store x and y values of Deprecation cubes which will deduct a point from the score if avatar collides with them.
// had to make array float lists to be able to remove the cubes from the array later
FloatList xValueOfDeprecation= new FloatList();
FloatList yValueOfDeprecation= new FloatList();
//ADDED: stores array that makes it easier to deal with noise function
FloatList noiseMarkerDeprecation= new FloatList();

//ADDED: array to make specific words for each feminist cube
String []feministSpheresArray = {"FEMME FRIENDS", "CONSENT", "BELL HOOKS", "EMPOWEREMENT", "SELF CARE", "COMMUNITY", "ALLIES", "ACTIVE LISTENING", "INTERSECTIONALITY", "INCLUSIVITY"};
//ADDED: array to make specific words for each box of offensive crap
String [] boxesArray= {"SLUT SHAMING", "MANSPLAINERS", "FAT SHAMING", "UNPAID LABOR", "REPUBLICANS", "NOT ALL MEN", "FRAT BOYZ", "TRANSPHOBIA", "CAT CALLING", "TOXIC\nMASCULINITY"};
//ADDED: array for the word "Deprecation" to appear above point-deducting cubes.
String [] DeprecationArray={"SELF-DEPRECATION", "SELF-DEPRECATION", "SELF-DEPRECATION", "SELF-DEPRECATION", "SELF-DEPRECATION"};

//ADDITION: declaring variables imgage and heart
PImage girl;
PImage heart;

//ADDITION: declaring and initializing score. score start at 0 
int score=0;

//ADDED: Text for the mountains so we mnow those are the feminist mountains
String feministHell= "Feminist Hell";

//ADDITION: All the text that shows up on home screen
String intro= "\n\nWANT  TO PRACTICE  FEMINISM?\n\nAVOID FEMINIST HELL BY MAKING AT \nLEAST 18 POINTS UNDER  1  MINUTE.\n\n";
String rules="\n\n- DRAGGING AN OPPRESSIVE CUBE INTO FEMINIST HELL = +1\n\n-USING  ARROWS  TO  COLLIDE WITH FEMINIST SPHERES = +1\n\n-COLLIDING WITH A SELF-DEPRECATING CUBE = -1";
//ADDITION: text saying to press shift to start
String pressShift="\nPRESS 'SHIFT' TO BEGIN :)";
//ADDED text to make sure player knows this game should be played in a team with a partner. 
String friend="\nPLAY IN A TEAM WITH A FRIEND!";

//ADDITION: declaring and initializing new variable which will tells the game what to write depending on if the player wins or loses.
String gameOutcome=" ";

//ADDED a global boolean to see if the player is dragging a box
boolean draggingBox =false;
int draggingIndex =-1;

//ADDITION: declaring and initializing variable which stores the value true. 
//This variable will tell processing whether game is being played or not.
boolean playGame =true;

//ADDED: declaring and initializing boolean to see whether or not the player has pressed shift (which starts the game)
boolean isShiftPressed=false;
//ADDED: declaring and initializing boolean to see whether or not the player has pressed control (which starts the webcam)
boolean isControlPressed=false;

//Added variables for font
PFont snellRoundHandBold;
PFont courierFont;

//declaring and initializing variable time. millis calculates how much time has passed since starting the program.
long time=millis();
//ADDEDED: declaring variable that tells processing how much time has passed since the timer was started (since the game was started)
long timePassed;


void setup() {
  //ADDED 3D feature
  size(1300, 800, P3D);

  //initialized font variables, size 60.
  snellRoundHandBold = createFont("SnellRoundhand-Bold", 60);
  courierFont = createFont("Courier", 60);

  //setting up how big webcam screen will be and the framerate of video.
  video= new Capture (this, 640, 480, 30);

  //ADDED: image of girl avatar for the home screen
  girl= loadImage("girl.png");
  //added hearts to end screens
  heart=loadImage("heart.jpg");

  //ADDED We load a sound by creating a new SoundFile and giving it the path to the file.
  songBoxes = new SoundFile(this, "hell.mp3");
  songSpheres = new SoundFile(this, "twinkle.mp3");
  songLost = new SoundFile(this, "lost.mp3");
  songWon = new SoundFile(this, "won.mp3");
  //start this song after 50 seconds
  songWon.cue(50);
  //ADDED: song loaded for when a point is lost
  songMinusOne= new SoundFile(this, "minusOne.mp3");

  //setting up perlin noise mountains. making them grow on the y axis with the noise function. 
  for (int i=0; i<1300; i++) {
    //CHANGE: made the mountains go up less high
    m[i] = height/1.80 + noise(yoff)*height/1.80;
    yoff += yincrement;
  }

  //putting 10 spheres on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list . spheres will be placed randomly on y axis.
    yValueOfSpheres.set(i, random(0, height));
    //setting x values of spheres here. will have 137 pixels in between each sphere.
    xValueOfSpheres.set(i, (i*137));
    //setting random value of this list which is useful for the noise.
    noiseMarkerSpheres.set(i, random(0, 1000));
  }

  //putting 10 boxes on screen
  for (int i=0; i< 10; i = i+1) {
    //setting the random value of this list.  boxes will be placed randomly on y axis.
    yValueOfBoxes.set(i, random(0, width));
    //setting x values of boxes. 137 pixels in between each box.
    xValueOfBoxes.set(i, (i*137));
    //setting random value of this list which is useful for the noise.
    noiseMarkerBoxes.set(i, random(0, 1000));
  }

  //ADDED: putting 5 cubes on the screen which deduct one point from the score if avatar collides with them
  for (int i=0; i<5; i=i+1) {
    //y position of cubes is random
    yValueOfDeprecation.set(i, random(0, height));
    //cubes are separated by 320 pixels on x axis
    xValueOfDeprecation.set(i, i*320);
    //setting random value of this list which is useful for the noise
    noiseMarkerDeprecation.set(i, random(0, 1000));
  }

  // Create the avatar at the top centre of the screen
  //removed code for old keys, as new keys are simply the arrows.
  avatar = new Avatar (550, 20);
}


void draw() {

  //text will be aligned in the center.
  textAlign(CENTER, CENTER);

  //ADDED: if shift has not yet been pressed, then show the code below (which is the homescreen)
  if (isShiftPressed==false) {

    //background is black
    background (0);
    //draws image of girl  avatar top center or screen.
    image(girl, width/2-50, 30, 100, 100);

    //TEXT TO BE SHOWN ON HOME SCREEN
    textFont(courierFont);
    //fill text is purple and then turns into blue as code below show
    fill(r, 0, 200);
    textSize(22); 
    text (intro, width/2, 210);
    textSize(19); 
    text (rules, width/2, 340);
    textSize(19);
    text(friend, width/2, 460);
    textSize(18); 
    text (pressShift, width/2, 500);
    //ADDED: brightning and fading of red, making it change between purple and blue.
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

    //ADDED mountains to homescreen
    for (int i=0; i<1300; i++) {
      //CHANGED stroke to be able to change colour of mountains over time to make them look more hellish
      //mountains become less and less red and more and more black, and then back to red.
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
    }

    //making the mountains move to the left
    //they will stretch all along x axis.
    for (int i=0; i<1299; i++) {
      m[i] = m[i+1];
    }
    //the mountains grow up and down on y axis
    //CHANGED: last element of the array
    //CHANGE: made the mountains go up less high.
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

      //background almost black
      background(15);

      //ADDED: text for score
      textSize(40);
      textAlign(CENTER, CENTER);
      //make the score appear in middle top of the screen in the middle of the y-axis in random colours on the red and blue scale
      fill(random(0, 255), 0, random(0, 255));
      text(score, width/2, 40);

      //hellish mountains are drawn when game starts
      //changed the limit
      for (int i=0; i<1300; i++) {
        //removed push and pop style because they were unecessary
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
      }

      //making the mountains move to the left
      for (int i=0; i<1299; i++) {
        m[i] = m[i+1];
      }

      //mountains grow up and down on y axis
      m[1299] = height/1.80+ noise(yoff)*height/1.80;
      yoff += yincrement;

      //DRAWING THE SPHERES. the spheres will loop according to the size of the list in the current array (changes whether of not spheres have been collided with)
      for (int i=0; i<yValueOfSpheres.size(); i=i+1) {
        //position of spheres on x axis is every 137 pixels and moves to the right, 
        //and position of spheres on y axis is controlled by the noise function to give cool movement.
        //spheres move to the right at the speed of 2.5
        float sphereX=xValueOfSpheres.get(i)+2.5;
        float sphereY=height*noise(noiseMarkerSpheres.get(i));

        //ADDED: giving the properties to the spheres
        pushMatrix();
        //spheres are displaced at their x and y position
        translate(sphereX, sphereY);
        //ADDITION: Made the spheres rotate on X axis so the the text could be seen more clearly
        rotateX(6);
        stroke(200, 0, 255);
        fill(0);
        sphere(20);
        //ADDED: made the text purple
        fill(200, 0, 255);
        textFont(courierFont);
        textSize(14.5);
        //ADDED: put the text above the spheres
        text(feministSpheresArray[i], 0, -40);
        ;
        popMatrix();

        //storing the x and y value of the ball so we can access it for the collision
        xValueOfSpheres.set(i, sphereX);
        //removed constrain on y position of spheres
        yValueOfSpheres.set(i, sphereY);
        //made the spheres move pretty slowly so player can semi-easily collide with them
        noiseMarkerSpheres.set(i, noiseMarkerSpheres.get(i)+0.003); 

        //if the spheres are off the right of the screen, put them back on the left of the screen to create a continuous flow
        float newX = xValueOfSpheres.get(i);
        if ((newX >1330)) {
          newX = -30;
        }
        xValueOfSpheres.set(i, newX);
      }

      //DRWING THE BOXES. the boxes will loop according to the size of the list in the current array 
      for (int i=0; i<yValueOfBoxes.size(); i=i+1) {

        //ADDED:if the boxes are being dragged, they follow the mouse. otherwise,
        //position of boxes on x axis is every 137 pixels, 
        //and position of boxes on the y axis is controlled by the noise function to give cool movement.
        //boxes move to the right at speed of 1.7
        float boxX =0;
        float boxY =0;
        if (draggingIndex!=i)
        {
          boxX=xValueOfBoxes.get(i)+1.7;
          boxY=height*noise(noiseMarkerBoxes.get(i));
        } else
        {
          boxX = mouseX;
          boxY = mouseY;
        }

        //ADDED: giving properties to the boxes
        pushMatrix();
        translate(boxX, boxY);
        fill(10);
        stroke(255, 0, 0);
        box(25);
        //ADDED: made the text red
        fill(255, 0, 0);
        textFont(courierFont);
        textSize(15);
        //ADDED: put the text above the boxes
        text(boxesArray[i], 0, -39);
        popMatrix();

        //storing the X and y values of the ball so we can access it for the collision
        xValueOfBoxes.set(i, boxX);
        //constraining the spheres not to go below the mountains
        //removed constrain on y position of boxes
        yValueOfBoxes.set(i, boxY);
        //made the spheres move pretty slowly so player can semi-easily collide with them
        noiseMarkerBoxes.set(i, noiseMarkerBoxes.get(i)+0.004); 

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

      //ADDED: DRAWING THE SELF-Deprecating CUBES.
      //the cubes will loop according to the size of the list in the current array 
      //(changes whether of not cubes have been collided with)
      for (int i=0; i<yValueOfDeprecation.size(); i=i+1) {
        //position of cube on x axis is every 400 pixels and moves to the right, 
        //and position of cubes on y axis is controlled by the noise function to give cool movement.
        //cubes move to the left at the speed of 3.5
        float DeprecationX=xValueOfDeprecation.get(i)+3.5;
        float DeprecationY=height*noise(noiseMarkerDeprecation.get(i));


        //ADDED: giving the properties to the self-Deprecation cubes in order to draw them
        pushMatrix();
        translate(DeprecationX, DeprecationY);
        fill(4);
        //they will be blue
        stroke(0, 0, 255);
        box(20);
        //text is blue
        fill(0, 0, 255);
        textFont(courierFont);
        textSize(15);
        //put text above spheres
        text(DeprecationArray[i], 0, -30);
        popMatrix();

        //storing the X and y value of the cubes so we can access it for the collision
        xValueOfDeprecation.set(i, DeprecationX);
        //removed constrain on y position of cubes
        yValueOfDeprecation.set(i, DeprecationY);
        //made the cubes move pretty slowly so player can semi-easily collide with them
        noiseMarkerDeprecation.set(i, noiseMarkerDeprecation.get(i)+0.004); 


        //if the cubes are off the right of the screen, put them back on the left of the screen to create a continuous flow
        float newX = xValueOfDeprecation.get(i);
        if ((newX >1310)) {
          newX = -25;
        }
        xValueOfDeprecation.set(i, newX);
      }

      //ADDED: draw text "feminist hell" at bottom of screen 
      pushMatrix();
      textAlign(CENTER, CENTER);
      translate(width/2, 780, 10);
      textSize(26);
      fill(255, 0, 0);
      text(feministHell, 0, 0);
      popMatrix();

      //updates the avatar
      avatar.update();
      //displays the avatar
      avatar.display();
      //checks if avatar collides with spheres or self-Deprecation cubes
      avatar.collide();

      //ADDITION: if it is true that the player's score is bigger or equal to 18 AND fewer then 60 seconds has passed then...
      if (score>=18 && timePassed<60000) {
        //the game stops
        playGame =false;
        //and the text below is drawn
        gameOutcome= "Girl(s), you did it.\nYour journey of self-care and love,\n and nurturing your community helped you\n grow as a feminist.\n\nPress 'control' to see\nhow wonderful you are! :)";
        //Added song when player wins.
        songWon.play();
      }

      //ADDITION: if it is true that the player's score is smaller than 18 and more then 60 seconds has passed then...
      if (score<=17 && timePassed>60000) {
        //the game stops
        playGame =false;
        //and the text below is drawn
        gameOutcome="Girl(s), you lost, but it's okay!\nKeep fighting the power by investing\nin yourself and other femmes.\n\nPress 'control' to see\nhow wonderful you are!";
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
        //the words of gameOutcome appear in random colours, and they depend on if player won or not.
        fill(255, 0, 0);
        textFont(snellRoundHandBold);
        textSize(35);
        text (gameOutcome, 680, 300);
        //ADDED drawing of score to end screens
        textFont(courierFont);
        fill(random(0, 255), 0, random(0, 255));
        text(score, width/2, 40);

        //ADDED moutains to end screen
        for (int i=0; i<1300; i++) {
          stroke(r, 0, 0);
          //brightning and fading of red of mountains
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
        }
        //making the mountains move to the left
        for (int i=0; i<1299; i++) {
          m[i] = m[i+1];
        }
        //how hight the mountains go.
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

//ADDED: mouse dragged function to be able to drag the boxes into feminist hell 
void mouseDragged() {
  // if a box is not being dragged,
  if (draggingBox ==false) {
    draggingIndex =-1;
    // then we look at if the mouse is touching a box
    for (int i=0; i<yValueOfBoxes.size(); i=i+1) {
      // the mouse is within the X position of the ball if its within its 20 pixel diameter
      boolean withinXPositionOfBox= (mouseX>xValueOfBoxes.get(i)-30 && mouseX< (xValueOfBoxes.get(i)+30));
      //the mouse is within the y position of the ball if its within its 20 pixel height
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

//when mouse is released, the dragging stops, and
//when mouse is released and is in bottom 100 pixels of screen on y axis, 
//then the boxes disappear and score increases by 1.
void mouseReleased() {
  if (draggingIndex!=-1 && mouseY>700) {
    xValueOfBoxes.remove(draggingIndex);
    yValueOfBoxes.remove(draggingIndex);
    score=score+1;
    println("SCORE"+score);
    //Added: made a fire sound (hell song for the boxes) play when boxes are dropped into feminist hell
    songBoxes.play();
  }
  //the box is no longer being dragged once it is dropped
  draggingBox = false;
  draggingIndex =-1;
}

//function called every time a key is pressed
void keyPressed() {
  //call the avatar's key pressed method
  avatar.keyPressed();
  //need to use key code variable for keys like SHIFT and CONTROL
  if (key==CODED) {
    //if the key that is pressed is shift,
    if (keyCode==SHIFT) {
      //then it is true that shift is pressed.
      isShiftPressed=true;
      //ADDED: the game timer begins when shift is pressed
      time = millis();
    }
    //if the key that is pressed is control, 
    if (keyCode==CONTROL) {
      //then it is true that control is pressed.
      isControlPressed=true;
    }
  }
}

//function called every time a key is pressed
void keyReleased() {
  //call the avatar's key released method
  avatar.keyReleased();
}