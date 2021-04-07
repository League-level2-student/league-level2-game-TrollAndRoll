final int floor = 350;
final float playerWidth = 15, playerHeight = 35; //25 & 55
float xSpeed = 0;
float xVelocity = 0.3;
final float yVelocityConst = -12.0;
float yVelocity = 0;
float gravity = 0.80;
float newPosition, objectHeight;

boolean keyLeft, keyRight, keyUp, keyDown, jump, onObject;

void gameScreen() {
  setupScreen(false);
  background(0);
  fill(150, 100, 255);
  player.setFrameRate(4);
  player.display();//display player
  map1();
  countSpeed();//updates velocity variables (given speed/gravity) and animation factors (i.e., running?, facingLeft?)
  changePlayerPosition();//actually updates x-coordinate

  xSpeed *= 0.9;//friction (ends in player stopped)
  //println(xSpeed);
}

int sqrX = 300;
int sqrDimensions = 50;
void map1() {
  randomBox.display();
  handleSolidBlockCollision(randomBox);
}

void countSpeed() {
  if (keyLeft) {//if left key pressed...
    xSpeed-= xVelocity;//speed decreases (goes left) at the rate of xVelocity
    player.running(true);//makes the animation play
    player.facingLeft(true);//mirrors the image to face left
  }
  if (keyRight) {//if right key pressed...
    xSpeed+= xVelocity;//speed increases (goes right) at the rate of xVelocity
    player.running(true);//animation plays
    player.facingLeft(false);//does nothing to image (will face right by default)
  }
  if (keyUp) {//if up key pressed...
    jump();
    player.running(true);//animation plays
  }
}

void changePlayerPosition() {//updates player's x-coordinate
  player.setX(player.x() + xSpeed);//x position of player is incremented by xSpeed

  yVelocity += gravity;//increases the speed by which the player falls (less is higher so: higher gravity = lower jump)
  player.setY(player.y() + yVelocity);//make player fall
  if (player.y() > (floor)) {//if going through floor...
    player.setY(floor);//set y position to floor
    yVelocity = 0;//& no more falling
  }
}

void jump() {
  if (yVelocity == 0) {//if not in the air...
    yVelocity = yVelocityConst;
    keyUp = false;//make sure player can't jump in mid air
  }
}

//Rectangle-Rectangle Collision Detection
void handleSolidBlockCollision(Image obstacle) {

  float nx = player.x() + xSpeed;//determines will where the player x will be next frame
  float ny = player.y() + yVelocity;//determines where the player y will be next frame

  if (xSpeed > 0) {//If player moving to the right then...
    if (nx + player.w > obstacle.x() && //if right side of player passes left side of the obstacle
      nx < obstacle.x() && //and left side of player is to left of obstacle 
      ny + player.h > obstacle.y() && //and the bottom of the player is below the obstacle
      ny < obstacle.y() + obstacle.h()) {//and the top of the player is ontop the obstacle's bottom
      xSpeed = 0; //stop the plyaer from moving
      player.setX(obstacle.x() - player.w()); //set the player to the left edge of the obstacle
    }
  } else if (xSpeed < 0) {
    if (nx < obstacle.x() + obstacle.w() &&
      nx + player.w() > obstacle.x() + obstacle.w() &&
      ny + player.h() > obstacle.y() &&
      ny < obstacle.y() + obstacle.h()) {
      xSpeed = 0;
      player.setX(obstacle.x() + obstacle.w());
    }
  }
  if (yVelocity > 0) {
    if (ny + player.h > obstacle.y() &&
      ny < obstacle.y() &&
      player.x() + player.w() > obstacle.x() &&
      player.x() < obstacle.x() + obstacle.w()) {
      yVelocity = 0;
      player.setY(obstacle.y() - player.h());
    }
  } else if (yVelocity < 0) {
    if (ny < obstacle.y() + obstacle.h() &&
      ny + player.h() > obstacle.y() + obstacle.h() &&
      player.x() + player.w() > obstacle.x() &&
      player.x() < obstacle.x() + obstacle.w()) {
      yVelocity = 0;
      player.setY(obstacle.y() + obstacle.h());
    }
  }
}
