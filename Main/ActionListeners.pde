void keyPressed() {
  //  if (key == CODED) {
  if (key == ESC) {
    key = 0;  //clear the key so the sketch doesn't close
  }
  if (keyCode == UP || keyCode == 'W' || keyCode == 'w') {
    keyUp = true;
    coatedPlayer.running(true);
  }
  if (keyCode == DOWN || keyCode == 'S' || keyCode == 's') {
    keyDown = true;
    coatedPlayer.running(true);
  }
  if (keyCode == LEFT || keyCode == 'A' || keyCode == 'a') {
    keyLeft = true;
    coatedPlayer.running(true);
  }
  if (keyCode == RIGHT || keyCode == 'D' || keyCode == 'd') {
    keyRight = true;
    coatedPlayer.running(true);
  }
  //  }
}
void keyReleased() {
  //  if (key == CODED) {
  if (keyCode == UP || keyCode == 'W' || keyCode == 'w') {
    keyUp = false;
    coatedPlayer.running(false);
    coatedPlayer.setFrame(0);
  }
  if (keyCode == DOWN || keyCode == 'S' || keyCode == 's') {
    keyDown = false;
    coatedPlayer.running(false);
    coatedPlayer.setFrame(0);
  }
  if (keyCode == LEFT || keyCode == 'A' || keyCode == 'a') {
    keyLeft = false;
    coatedPlayer.running(false);
    coatedPlayer.setFrame(0);
    coatedPlayer.facingLeft(true);
  }
  if (keyCode == RIGHT || keyCode == 'D' || keyCode == 'd') {
    keyRight = false;
    coatedPlayer.running(false);
    coatedPlayer.setFrame(0);
    coatedPlayer.facingLeft(false);
  }
  //  }
}

void getMouseCoordinates() {//update mouse coordinates
  px = mouseX;
  py = mouseY; 
  //println(px, py);
}
