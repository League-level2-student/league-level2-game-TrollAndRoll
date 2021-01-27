double xSpeed = 0;
double xVelocity = 0.8;
final double velocityconst = -12.0;
double velocity = velocityconst;
double gravity = 0.98;

boolean keyLeft, keyRight, keyUp, keyDown, jump;

void gameScreen() {
  setupScreen(false);
  background(0);
  fill(150, 100, 255);
  coatedPlayer.setFrameRate(4);
  coatedPlayer.display((int)x, (int)y, 25, 55);
  //rect((int)x, (int)y, 15, 15);//draws player (temporary)
  //println(x);
  countSpeed();
  changePosition();

  if (jump == true) jump();
  xSpeed *= 0.9;//friction (ends in player stopped)
  //println(xSpeed);
}

void map1() {
  
}

void countSpeed() {
  if (keyLeft) xSpeed-= xVelocity; //speed increases at the rete of xVelocity
  if (keyRight) xSpeed+= xVelocity;
  if (keyUp) jump = true;
}

void changePosition() {//updates player's x-coordinate
  x+= xSpeed;
}

void jump() {
  velocity+= gravity;//amount to jump (less is higher so: higher gravity = lower jump) by
  if (y + velocity > (200)) {//if touching the floor...
    y = 200;//no more falling
    jump = false;
    velocity = velocityconst;
  } else {//otherwise keep falling
    y += velocity;
  }
}
