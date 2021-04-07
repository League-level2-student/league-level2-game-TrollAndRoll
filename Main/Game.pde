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

  if (xSpeed > 0) {//if player moving right then...
    if (nx + player.w > obstacle.x() && //if right side of player passes left side of the obstacle
      nx < obstacle.x() && //and left side of player is to left of obstacle 
      ny + player.h > obstacle.y() && //and the bottom of the player is below the obstacle
      ny < obstacle.y() + obstacle.h()) {//and the top of the player above the obstacle's bottom
      xSpeed = 0; //stop the player
      if (yVelocity > 0) {//if falling (then you'll probably land on an obstacle so...)
        player.setY(obstacle.y() - player.h());//set player ontop of obstacle
      } else {//if not falling
        player.setX(obstacle.x() - player.w());//set player to left of obstacle
      }
    }
  } else if (xSpeed < 0) {//if player moving left then...
    if (nx < obstacle.x() + obstacle.w() && //if left side of player passes right side of obstacle
      nx + player.w() > obstacle.x() + obstacle.w() && //and right side of player is to right of obstacle
      ny + player.h() > obstacle.y() &&//and bottom of player is below top of obstacle
      ny < obstacle.y() + obstacle.h()) {//and top of player is above the obstacle's bottom
      xSpeed = 0;//stop player
      if (yVelocity > 0) {//if falling (then you'll probably land on an obstacle so...)
        player.setY(obstacle.y() - player.h());//set player ontop of obstacle
      } else {//if not falling
        player.setX(obstacle.x() + obstacle.w());//set player to right of obstacle
      }
    }
  }
  if (yVelocity > 0) {//if falling
    if (ny + player.h > obstacle.y() &&//if the bottom of the player past the top of the obstacle
      ny < obstacle.y() &&//and the top of the player above the obstacle
      player.x() + player.w() > obstacle.x() &&//and the right of the player is past the obstacle's left
      player.x() < obstacle.x() + obstacle.w()) {//and the left of the player is to the left of the obstacle' right
      yVelocity = 0;//stop player
      player.setY(obstacle.y() - player.h());//set player's y to the base of the obstacle
    }
  } else if (yVelocity < 0) {//if jumping
    if (ny < obstacle.y() + obstacle.h() &&//if player's top is above obstacle's top
      ny + player.h() > obstacle.y() + obstacle.h() &&//and player's bottom is below top
      player.x() + player.w() > obstacle.x() &&//and player's right is to the right of obstacle's left
      player.x() < obstacle.x() + obstacle.w()) {//and player's left is to the left of obstacle's right
      yVelocity = 0;//stop player
      player.setY(obstacle.y() + obstacle.h());//set player's y to top of obstacle
    }
  }
}
