//You should implement your assign3 here.

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

int gameState;

PImage gameStartImg1;
PImage gameStartImg2;
PImage backgroundImg1;
PImage backgroundImg2;
PImage enemyImg;
PImage fighterImg;
PImage hpImg;
PImage treasureImg;
PImage endImg1;
PImage endImg2;
PImage [] flameImg;
int rectX;
float treasureX;
float treasureY;
float enemyY;
float enemyX;
int bg1X;
int bg2X;
float fighterX, fighterY;
float [] enemysX;
float [] enemysY;
float [] frameX;
float [] frameY;

boolean bomb = false;


boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int widthOfEnemy = 60;
int heightOfEnemy = 60;

float speed = 5;
int times = 1;

int currentFrame;

void setup () {
  size(640, 480);
  
  gameStartImg1 = loadImage("img/start2.png");
  gameStartImg2 = loadImage("img/start1.png");
  backgroundImg1 = loadImage("img/bg1.png");
  backgroundImg2 = loadImage("img/bg2.png");
  enemyImg = loadImage("img/enemy.png");
  fighterImg = loadImage("img/fighter.png");
  hpImg = loadImage("img/hp.png");
  treasureImg = loadImage("img/treasure.png");
  endImg1 = loadImage("img/end2.png");
  endImg2 = loadImage("img/end1.png");
  
  flameImg = new PImage[5];
  for(int i = 0; i < 5; i++){
    flameImg[i] = loadImage("img/flame"+(i+1)+".png");
  }

  currentFrame = 0;

  bg2X = 640;
  bg1X = 0;
  rectX = 55;
  treasureX = random(600);
  treasureY = random(440);
  enemyX = 0;
  enemyY = random(40,420);
  fighterX = 580;
  fighterY = 240;
  
  enemysX = new float[8];
  enemysY = new float[8];
  
  for(int i = 0; i < 5; i++){
    enemysX[i] = enemyX-i*widthOfEnemy;
    enemysY[i] = enemyY;        
  }
  
  frameX = new float[8];
  frameY = new float[8];
  
  for(int i = 0; i < 8; i++){
    frameX[i] = 0;
    frameY[i] = 0;
  }
  
  gameState = 0;
  
}

void draw() {
  
  switch(gameState){
    
    case GAME_START:
      image(gameStartImg1,0,0);
      if(mouseX > 210 && mouseX < 440){
        if(mouseY > 380 && mouseY < 410){
          image(gameStartImg2,0,0);
          if(mousePressed){
            gameState = GAME_RUN;
          }
        }
      }
      break;
    case GAME_RUN:
      
      image(backgroundImg2,bg2X-640,0);
      image(backgroundImg1,bg1X-640,0);
      bg2X = bg2X + 1;
      bg2X = bg2X % 1280;                                                                    
      bg1X = bg1X + 1;
      bg1X = bg1X % 1280;
      
      image(treasureImg,treasureX,treasureY);
      image(fighterImg,fighterX,fighterY);
      
      if(times%3 == 1){
        for(int i = 0; i < 5; i++){
          image(enemyImg,enemysX[i],enemysY[i]);
        }
      }
      else if(times%3 == 2){
        
        for(int i = 0; i < 5; i++){
          image(enemyImg,enemysX[i],enemysY[i]);
        }
      }
      else{
        for(int i = 0; i < 8; i++){
          image(enemyImg, enemysX[i], enemysY[i]);
          
        }
      }
      
      rectMode(CORNERS);
      rect(15,10,rectX,40);
      fill(255,0,0);
      image(hpImg,10,10);
      
      for(int i = 0; i < 8; i++){
        enemysX[i] = enemysX[i] + 5;
      }
      
      if(enemysX[4] == 640){
        
        enemyX = 0;
        times = times + 1;
        if(times%3 == 1){
          enemyY = random(40,420);
          for(int i = 0; i < 5; i++){
            enemysX[i] = enemyX-i*widthOfEnemy;
            enemysY[i] = enemyY;
          }
        }
        else if(times%3 == 2){
          enemyY = random(40,200);
          for(int i = 0; i < 5; i++){
            enemysX[i] = enemyX-i*widthOfEnemy;
            enemysY[i] = enemyY+i*heightOfEnemy*2/3;
          }
        }
        else{
          enemyY = random(120,300);
          for(int i = 0; i < 5; i++){
            enemysX[i] = enemyX-i*widthOfEnemy;
            if(i < 3){
              enemysY[i] = enemyY+i*heightOfEnemy;
            }
            else{
              enemysY[i] = enemyY+(4-i)*heightOfEnemy;
            }
          }
          
          enemysX[5] = enemysX[1];
          enemysX[6] = enemysX[2];
          enemysX[7] = enemysX[3];
          enemysY[5] = enemyY-heightOfEnemy;
          enemysY[6] = enemyY-2*heightOfEnemy;
          enemysY[7] = enemyY-heightOfEnemy;
          
          
        }
        
      }
      
      
      if (upPressed) {
        if(fighterY != 0){
          fighterY -= speed;
        }
      }
      if (downPressed) {
        if(fighterY != height-50){
          fighterY += speed;
        }
      }
      if (leftPressed) {
        if(fighterX != 0){
          fighterX -= speed;
        }
      }
      if (rightPressed) {
        if(fighterX != width-50){
          fighterX += speed;
        }
      }
      
      for(int i = 0; i < 8; i++){
        if(fighterX >= enemysX[i]-45 && fighterX < enemysX[i]+60 && fighterY >= enemysY[i]-45 && fighterY <= enemysY[i]+60){
          
          
          //enemyX = 0;
          //enemyY = random(40,420);
          frameX[i] = enemysX[i];
          frameY[i] = enemysY[i];
          //if(frameCount % (60/10) == 0){
            //int j = (currentFrame++)%5;
          //bomb = true;
          //if(frameCount % (60/10) == 0){
            //int j = (currentFrame++)%5;
            //image(flameImg[j], frameX[j], frameY[j]);
          //}
            
          //}
          enemysX[i] = 0;
          enemysY[i] = 480;
          
          rectX = rectX - 40;
          if(rectX < 15){
            rectX = 15;
          }
          //rect(15,10,rectX,40);
          if(rectX <= 15){
            gameState = GAME_OVER;
          }
          
          
        }
      }
      
      //if(bomb == true){
      //  if(frameCount % (60/10) == 0){
      //    int j = (currentFrame++)%5;
      //    image(flameImg[j], frameX[j], frameY[j]);
      //  }
      //}
      //bomb = false;
      
      if(fighterX >= treasureX-45 && fighterX < treasureX+40 && fighterY >= treasureY-45 && fighterY <= treasureY+40){
        
        treasureX = random(600);
        treasureY = random(440);
        //image(treasureImg,treasureX,treasureY);
        rectX = rectX + 20;
        if(rectX >= 215){
          rectX = 215;
        }
        //rect(15,10,rectX,40);
      }
/*      
      if(enemyY > fighterY){
        enemyY-=2;
      }
      if(enemyY == fighterY){
        enemyX+=3;
      }
      if(enemyY < fighterY){
        enemyY+=2;
      }
*/
      break;
    case GAME_OVER:
      rectX = 215;
      image(endImg1,0,0);
      if(mouseX > 210 && mouseX < 440){
        if(mouseY > 315 && mouseY < 345){
          image(endImg2,0,0);
          if(mousePressed){
            gameState = GAME_RUN;
          }
        }
      }
      for(int i = 0; i < 5; i++){
        enemysX[i] = enemyX-i*widthOfEnemy;
        enemysY[i] = enemyY;        
      }
      for(int i = 5; i < 8; i++){
        enemysY[i] = 480;
      }
      times = 1;
      break;
          
  }
}
void keyPressed(){
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
