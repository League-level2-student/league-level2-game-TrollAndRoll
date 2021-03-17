//using these strings so that there is less typing when inputing files in parameters
final String font = "fonts" + '/';

final String gameAsset = "gameAssets" + '/';

final String players = gameAsset + "players" + '/';
final String backdrop = gameAsset + "backdrops" + '/';

final String button = gameAsset + "UI_buttons" + '/';
final String rectButton = button + "largeButtons" + '/';
final String squButton = button + "squareButtons" + '/';

final String sound = gameAsset + "sound" + '/';
final String FX = sound + "FX" + '/';
final String music = sound + "music" + '/';

PFont unispace;
Animation waterfallBackdrop, player;
Image playButton, newGameButton, optionsButton, exitButton, backButton, //fScreenButton, windowedButton,
      gameSoundButton, GUISoundButton, ambienceSoundButton, musicButton, infoButton, 
      randomBox,
      caveBackdrop1, caveBackdrop2, caveBackdrop3, caveBackdrop4;
SoundFile pressed1, pressed2, 
          selectedSound, waterfall, cave, waterDrip, waterFlow,
          themeTrack, track1, track2;
StageSounds SThemeTrack, SWaterfall, SCave, SWaterDrip;
UpdateSoundValue GUISound, gameSound, ambienceSound, musicSound;

void loadImages() {
  //backdrops
  caveBackdrop1 = new Image(backdrop + "pixelCaveBackdrop1", null, 0, 0, null);
  caveBackdrop1.rescale(0.62);
  caveBackdrop2 = new Image(backdrop + "pixelCaveBackdrop2", null, 0, 0, null);
  caveBackdrop3 = new Image(backdrop + "pixelCaveBackdrop3", null, 0, 0, null);
  caveBackdrop4 = new Image(backdrop + "pixelCaveBackdrop4", null, 0, 0, null);
  
  //buttons || ('rescale' is changing size by percentage)
  playButton = new Image(rectButton + "playButton", rectButton + "playColButton", 290, 100, "BUTTON");
  playButton.rescale(0.30);
  newGameButton = new Image(rectButton + "newGameButton", rectButton + "newGameColButton", 0, 0, "BUTTON");
  newGameButton.rescale(0.30);
  optionsButton = new Image(rectButton + "optionsButton", rectButton + "optionsColButton", 290, 200, "BUTTON");
  optionsButton.rescale(0.30);
  exitButton = new Image(rectButton + "exitButton", rectButton + "exitColButton", 310, 300, "BUTTON");
  exitButton.rescale(0.25);
  backButton = new Image(rectButton + "backButton", rectButton + "backColButton", 10, 10, "BUTTON");
  backButton.rescale(0.20);
  //fScreenButton = new Image(rectButton + "fullScreenButton", rectButton + "fullScreenColButton");
  //fScreenButton.rescale(0.35);
  //windowedButton = new Image(rectButton + "windowedButton", rectButton + "windowedColButton");
  //windowedButton.rescale(0.35);
  gameSoundButton = new Image(squButton + "audioSquareButton", squButton + "audioColSquareButton", 0, 0, "BUTTON");
  gameSoundButton.rescale(0.23);
  GUISoundButton = new Image(squButton + "audioSquareButton", squButton + "audioColSquareButton", 0, 0, "BUTTON");
  GUISoundButton.rescale(0.23);
  ambienceSoundButton = new Image(squButton + "audioSquareButton", squButton + "audioColSquareButton", 0, 0, "BUTTON");
  ambienceSoundButton.rescale(0.23);
  musicButton = new Image(squButton + "musicSquareButton", squButton + "musicColSquareButton", 0, 0, "BUTTON");
  musicButton.rescale(0.23);
  infoButton = new Image(squButton + "questionMarkSquareButton", squButton + "questionMarkColSquareButton", 600, 355, "BUTTON");
  infoButton.rescale(0.20);
  
  //game objects
  randomBox = new Image(squButton + "audioSquareButton", null, sqrX, floor, null);
  randomBox.rescale(0.20);
}

void loadAnimations() {
  waterfallBackdrop = new Animation(backdrop+"waterfallGif"+'/'+"waterfall_", 4, true, 0, 0, width, height);
  player = new Animation(players+"coatPlayer"+'/'+"coatPlayer_", 4, false, 10, floor, (int)playerWidth, (int)playerHeight);
  player.running(false);
}

void loadSounds() {
  pressed1 = new SoundFile(Main.this, FX + "pressed1.wav");
  pressed2 = new SoundFile(this, FX + "pressed2.wav");
  SThemeTrack = new StageSounds(themeTrack, music + "themeTrack", true);
  SWaterfall = new StageSounds(waterfall, FX + "waterfall", true);
  SCave = new StageSounds(cave, FX + "caveNoises", true);
  SWaterDrip = new StageSounds(waterDrip, FX + "caveWaterDripSound", true);
}

void loadFonts() {
  unispace = loadFont("Unispace-Bold-48.vlw");
}

//reloads imagery (depends), pauses uneccary sound, and changes the stage
void reload(boolean reloadAll, int designatedStage) {
  if (reloadAll) {
    loadImages();
    loadAnimations();
  }
  pauseSound(stage);
  stage = designatedStage;
}
