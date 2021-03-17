final int floor = 350;
final float playerWidth = 15, playerHeight = 35; //25 & 55
float xSpeed = 0;
float xVelocity = 0.3;
final float velocityconst = -13.0;//-12
float velocity = velocityconst;
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
  objectHeight = handleSolidBlockCollision(randomBox);

  //fill(0, 150, 255);

  //rect(sqrX, floor, sqrDimensions, sqrDimensions);
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
    jump = true;//set jump to true
    player.running(true);//animation plays
  }
}

void changePlayerPosition() {//updates player's x-coordinate
  player.setX(player.x() + xSpeed);//x position of player is incremented by xSpeed
  if (jump == true) jump();//call the jump method if the up key has been pressed
}

/*void setPlayerPosition(int x, int y) {
 player.setX(x);
 player.setY(y);
 }*/

void jump() {
  float platform;
  velocity+= gravity;//increases the speed by which the player falls (less is higher so: higher gravity = lower jump)
  if (onObject == true) {
    platform = floor - objectHeight;
  } else {
    platform = floor;
  }
  if (player.y() + velocity > (platform)) {//if falling and any more would go through floor...
    player.setY(platform);//no more falling
    jump = false;
    velocity = velocityconst;
  } else {//if on the floor
    player.setY(player.y() + velocity);//jump
  }
}

//Rectangle-Rectangle Collision Detection
float handleSolidBlockCollision(Image obstacle) {

  float nx = player.x() + xSpeed;
  float ny = player.y() + velocity;

  if (xSpeed > 0) {
    if (nx + player.w > obstacle.x() && //if right side of player touches/passes left side of the obstacle
      nx < obstacle.x() && //and left side of player is not past the right side of the obstacle 
      ny + player.h > obstacle.y() && //and the top of the player is below the obstacle
      ny < obstacle.y() + obstacle.h()) {//and the bottom of the player is above the obstacle
      xSpeed = 0;
      player.setX(obstacle.x() - player.w());
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
  if (velocity > 0) {
    if (ny + player.h > obstacle.y() &&
      ny < obstacle.y() &&
      player.x() + player.w() > obstacle.x() &&
      player.x() < obstacle.x() + obstacle.w()) {
      velocity = 0;
      player.setY(obstacle.y() - player.h());
    }
  } else if (velocity < 0) {
    if (ny < obstacle.y() + obstacle.h() &&
      ny + player.h() > obstacle.y() + obstacle.h() &&
      player.x() + player.w() > obstacle.x() &&
      player.x() < obstacle.x() + obstacle.w()) {
      velocity = 0;
      player.setY(obstacle.y() + obstacle.h());
    }
  }
  if (player.x() > obstacle.x() && player.x() + player.w() < obstacle.x() + obstacle.w()) {
    onObject = true;
  } else {
    onObject = false;
  }
  return obstacle.h();
}
