import processing.sound.*;

int stage = 1;
int frameRate = 60;

final float iniWidth = 768;//initial window dimentions
final float iniHeight = 432;

float px = 0, py = 0;//Mouse x & y
double x, y; //Player Coordinates
boolean fullscreen;//probably wont use this- turns out you can only call fullScreen()/size() once :(

void setup() {
  size(768, 432, P2D);//16:9
  //fullScreen(P2D);
  background(255);
  frameRate(frameRate);
  //smooth();
  x = width*0.08333;
  y = height*0.5;
  surface.setTitle("IDK Yet");
  surface.setResizable(true);
  surface.setLocation(550, 250);
  //surface.setAlwaysOnTop(true);

  loadFonts();
  loadImages();
  loadAnimations();
  loadSounds();
}

void draw() {
  if (stage == 0) {
    homeScreen();
  }
  else if (stage == 1) {
    gameScreen();
  }
  else if (stage == 2) {
    settingsScreen();
  }
}
