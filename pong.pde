color gameColor = color(252,186,3);

// player positions on the screen
int p1Y;
int p2Y;
int p1X;
int p2X;

// paddle display information
int paddleW = 10;
int paddleH = 75;

// player scores
int p1Score = 0;
int p2Score = 0;

// ball position on the screen and motion
int ballX;
int ballY;
int ballMoveX;
int ballMoveY;

int ballSize = 10;



void setup() {
 
  size(600, 400);
  
  // set the paddle positions based on the ball location
  p1X = 5;
  p2X = width - 5 - ballSize;
  
  // move the ball to the middle of the screen and give it a direction
  resetBall();
  
}


void draw() {
  
  background(255);
  
  drawObjects();

  update();
}

void drawObjects() {
  noStroke();
  
  // draw the playing elements
  fill(gameColor); // atari ST baby, one colour for everything
  rect(ballX, ballY, ballSize, ballSize);
  rect(p1X, p1Y, paddleW, paddleH);
  rect(p2X, p2Y, paddleW, paddleH);
  
  // draw the scores
  textSize(30);
  text(p1Score, 30, 30);
  text(p2Score, width - 60, 30);
  
  
}

void update() {
  // move the ball and paddles
  bounceEdge();
  bouncePaddle(p1X, p1Y);
  bouncePaddle(p2X, p2Y);
  
  moveBall();
  moveP1Paddle();
  moveP2Paddle();
  score();
}

void moveBall() {
  ballX += ballMoveX;
  ballY += ballMoveY;
}

void moveP1Paddle(){
  p1Y = min(mouseY, height - paddleH);
  
}

void moveP2Paddle() {
  p2Y = min(mouseY, height - paddleH);
}

void bounceEdge() {
  // bounces the ball off the top and bottom edges
   if ((ballY <= 0) || (ballY + ballSize >= height)) {
     ballMoveY *= -1;
   }
}
   
   
void bouncePaddle(int paddleX, int paddleY) {
    // bounces the ball off the paddle 
   if (((ballX + ballSize >= paddleX) && (ballX <= paddleX + paddleW)) && 
              ((ballY + ballSize >= paddleY) && (ballY <= paddleY + paddleH))) 
        {
     ballMoveX *= -1;
     
     // reflects the ball back on the y axis if it hits near the edge of the paddle
     // mostly for fun, not sure it was in pong, but I enjoy it in most clones
     if ((ballY + ballSize < (paddleY + (paddleH / 8))) || 
         (ballY + ballSize > (paddleY + 7 * (paddleH / 8)))) {
       ballMoveY *= -1;
     }
     
   }
   
}

void score() {
  // counts the score if
   if (ballX + ballSize < 0) {
     p2Score++;
     resetBall();
   } else if (ballX > width) {
     p1Score++;
     resetBall();
   }
    
}

void resetBall() {
  // flashes the screen
  background(gameColor);
  
  // move ball to the middle
  ballX = width / 2;
  ballY = height / 2;
  
  // give the ball a relativly random initial direction
  ballMoveX = ((int) random(2)) + 2;
  if (random(1) > 0.5) {
    ballMoveX *= -1;
  }
  ballMoveY = ((int) random(2)) + 2;
  if (random(1) > 0.5) {
    ballMoveY *= -1;
  }
}
