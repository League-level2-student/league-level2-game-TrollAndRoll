double xSpeed = 0;
double xVelocity = 0.3;
final double velocityconst = -12.0;
double velocity = velocityconst;
double gravity = 0.98;

boolean keyLeft, keyRight, keyUp, keyDown, jump;

void gameScreen() {
  setupScreen(false);
  background(0);
  fill(150, 100, 255);
  coatedPlayer.setFrameRate(4);
  coatedPlayer.display((int)x, (int)y, 25, 55);//display player at proper coordinates
  countSpeed();//updates velocity variables (given speed/gravity) and animation factors (i.e., running?, facingLeft?)
  changePosition();//actually updates x-coordinate

  if (jump == true) jump();//call the jump method if the up key has been pressed
  xSpeed *= 0.9;//friction (ends in player stopped)
  //println(xSpeed);
}

void map1() {
}

void countSpeed() {
  if (keyLeft) {//if left key pressed...
    xSpeed-= xVelocity;//speed decreases (goes left) at the rate of xVelocity
    coatedPlayer.running(true);//makes the animation play
    coatedPlayer.facingLeft(true);//mirrors the image to face left
  }
  if (keyRight) {//if right key pressed...
    xSpeed+= xVelocity;//speed increases (goes right) at the rate of xVelocity
    coatedPlayer.running(true);//animation plays
    coatedPlayer.facingLeft(false);//does nothing to image (will face right by default)
  }
  if (keyUp) {//if up key pressed...
    jump = true;//set jump to true
    coatedPlayer.running(true);//animation plays
  }
}

void changePosition() {//updates player's x-coordinate
  x+= xSpeed;//x position of player is incremented by xSpeed
}

void jump() {
  velocity+= gravity;//sets the amount to jump by (less is higher so: higher gravity = lower jump)
  if (y + velocity > (200)) {//if touching the floor...
    y = 200;//no more falling
    jump = false;
    velocity = velocityconst;
  } else {//if in the air...
    y += velocity;//keep falling
  }
}
