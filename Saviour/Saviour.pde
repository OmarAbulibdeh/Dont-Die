import processing.sound.*; 
import g4p_controls.*;

//Variables 
int meteorSize = 50;
int playerXCor = 600;  // cordiantes of the players avatar
int playerYCor = 590;
int playerWidth = 55;  // width and height of the players avatar
int playerHeight = 55;
int difficulty = 10;  //the higher the diffucluty the more Meteor drops offalling fallings
int limit = 10;
float score = 0;
int lives = 4;
boolean isCollided = false; // detects the collison between the Meteordrops and the player
boolean lost = true;
boolean hasHit = false;
boolean paused = false;  //Detects if the game is paused
boolean moveMouse = true; 

ArrayList stars;
Meteor[] Meteor;
//images
PImage ufoImg;
PImage meteorImg;
PImage explosionImg;
//Meteor
void fallingMeteor(int xMin, int xMax, int yMin, int yMax, int num) {
  Meteor = new Meteor[num];

  for (int i = 0; i < Meteor.length; i++) {  // for loops for the Meteorfalling
    int x = (int)random(xMin, xMax);
    int y = (int)random(yMin, yMax);
    Meteor[i] = new Meteor(x, y, 30);
  }
}
void setup() {
  size(1280, 720);
  createGUI();
  noLoop();
  background(0);
//Loading images
  ufoImg = loadImage("ufo.png");
  meteorImg = loadImage("meteor.png");
  explosionImg = loadImage("explosion.png");
  
  explosionImg.resize(300, 300);
  ufoImg.resize(50, 50);
  meteorImg.resize(meteorSize, meteorSize);

  //background stars
  stars = new ArrayList();
  for (int i = 1; i <= width; i++) {
    stars.add(new Star());
  }


  fallingMeteor(-100, width + 20, -250, -80, difficulty);  // spawning in the Meteordrops
}
// Players Avatar
void drawPlayer() {
  stroke(0);
  strokeWeight(2);
  fill(0, 250, 0);
  image(ufoImg, playerXCor, playerYCor);
  
  
  //lives
   fill(255);
   textSize(40);
   text("Lives: "+(int)lives, width-200, 40);
   
}

void draw() {
  background(0);

  //If not paused
  if (!paused){
  //background stars
    noStroke();
    moveMouse = true;
    for (int i = 0; i <= stars.size()-1; i++) {
      Star starUse = (Star) stars.get(i);
      starUse.display();

  
      //Lives  
     if (lives <= 0) {
      image(explosionImg, playerXCor - 140,playerYCor-150);
      fill(255);
      textSize(40);
      text("Your Final Score Is: "+(int)score, 400, 40);
      
      noLoop();
    
    }
  }
  
    drawPlayer();
  
    if (!isCollided) {      // if the collision happens then:
      moveMeteor();
      if (score > limit && score < limit + 1) {
        fallingMeteor(-100, width + 20, -260, -80, difficulty); 
        difficulty += 10; 
        limit += 20;
      }
    }
  }
  //If the game is paused
  else {
    moveMouse = false;
    text("Lives: "+(int)lives, width-200, 40);
    text("Score: "+(int)score, 10, 40);
    for (int i = 0; i <= stars.size()-1; i++) {
      Star starUse = (Star) stars.get(i);
      starUse.display();
    }
    for (int i = 0; i < Meteor.length; i++) {
      Meteor[i].display();
    }
    drawPlayer();
  }
}
//Animation for falling meteor
void moveMeteor() {
  for (int i = 0; i < Meteor.length; i++) {  // where the next group offalling Meteor will be summoned
    if (Meteor[i].yCor > height) {
      Meteor[i].yCor = -10;
    }
    Meteor[i].display();
    Meteor[i].drop(random(1, 20));

    // detecting if the colliosn of the player happened with thefalling Meteor
      boolean conditionXLeft = Meteor[i].xCor + Meteor[i].size >= playerXCor;
      boolean conditionXRight = Meteor[i].xCor + Meteor[i].size <= playerXCor + playerWidth + 4;
      boolean conditionUp =  Meteor[i].yCor >= playerYCor;
      boolean conditionDown = Meteor[i].yCor + Meteor[i].size <= playerYCor + playerHeight;

      if (conditionXLeft && conditionXRight && conditionUp && conditionDown) {
        isCollided = true;
        hasHit = true;
        lives = lives -1;
    }
    
    
  else {
    isCollided = false;
    hasHit = false;
   
  }
  
  }


  score += 0.1;

  fill(255);
  text("Score: "+(int)score, 10, 40);
  textSize(30);
}



// Allows player to control the avatar with cursor (learned in class... read notes to finish)
void mouseDragged() {
  if(moveMouse){
    if (mouseX >= 0 && mouseX <= width - playerWidth + 1) {
      playerXCor = mouseX;
    }
    if (mouseY >= 0 && mouseY <= height - playerHeight) {
      playerYCor = mouseY;
    }
  }
}

//Reseting function
void reset(){
  score = 0;
  lives = Lives.getValueI();
  fallingMeteor(-100, width + 20, -250, -80, difficulty);
}
