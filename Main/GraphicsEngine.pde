class Image {
  PImage image1, image2;
  float rw, rh, rx, ry, pxz, pyz;
  boolean selected, pressed, played;
  SoundFile selectedFile = new SoundFile(Main.this, FX + "selected.wav");
  //selected.wav is only used for buttons (a kind of image) so I initialize it here

  Image(String image1Name, String image2Name) {
    image1 = loadImage(image1Name + ".png");
    if (image2Name != null) {//only load second parameter if its not empty (otherwise program would stop :/)
      image2 = loadImage(image2Name + ".png");
    }
    //area to check for collision in is equal to that of the image dimensions.
    rw = image1.width;
    rh = image1.height;
  }

  public void rescale(float percent) {//rescales images by percentage
    rw = rw * percent;
    rh = rh * percent;
  }

  public void display(float rx, float ry, String type) {
    if (type == "BUTTON") {//only do button things if it is said to be a "BUTTON" (when called)
      pxz = px/(width/iniWidth);//recalobrating to account for scale()
      pyz = py/(height/iniHeight);
      // is the point inside the rectangle's bounds?
      if (pxz >= rx &&        // right of the left edge AND
        pxz <= rx + rw &&   // left of the right edge AND
        pyz >= ry &&        // below the top AND
        pyz <= ry + rh) {   // above the bottom
        selected = true;
      } else {
        selected = false;
      }
      if (selected) {//if mouse is over button...
        if (selectedFile.isPlaying() == false && played == false) {//play 'selected' noise
          if (GUISoundOn) selectedFile.play();
          played = true;
        }
        image(image2, rx-(rx*0.015), ry-(ry*0.015), rw*1.05, rh*1.05);//draw button slightly larger
        if (mousePressed && (mouseButton == LEFT)) {//if button was clicked the play pressed noise
          if (GUISoundOn) pressed2.play();
          pressed = true;
        }
      } else {//if mouse is not over button...
        image(image1, rx, ry, rw, rh);//just draw a regular button
        played = false;
      }
    } else {//if its not a button then just draw the image
      image(image1, rx, ry, rw, rh);
    }
  }

  public boolean selected() {//getter to check, elsewhere, if buttons have been clicked
    return selected;
  }

  public boolean clicked() {//getter to check, elsewhere, if buttons have been clicked
    return pressed;
  }
}

// Class for animating a sequence of GIFs
class Animation {
  PImage[] images;//array of images (all the ones in the GIF)
  int imageCount, frame, framesPerSecond = 15;
  long startTime;
  float timePerFrame;
  float wz, hz;//variables for recalobrated width & height
  boolean dynamicDimensions;//will the inputed width & height change?
  boolean run = true;//should the animation play?
  boolean facingLeft;//should a sprite be mirrored on y-axis?

  Animation(String imagePrefix, int count, boolean dynamicDimensions) {
    this.dynamicDimensions = dynamicDimensions;
    this.startTime = System.currentTimeMillis();//returns time in millis between now & midnight
    this.timePerFrame = 1.0f / (float)framesPerSecond;//saves fps in timePerFrame float

    imageCount = count;//sets the amount of images in GIF as a local variable
    images = new PImage[imageCount];//initializes 'images' array to be as big as the amount of images in the GIF

    for (int i = 0; i < imageCount; i++) {//goes through the array filling each slot with an image
      // Use nf() to number format 'i' into however many digits (set to 1 rn)
      String filename = imagePrefix + nf(i, 1) + ".gif";//we can do this because of how the files are named
      images[i] = loadImage(filename);//setting the array slot to the image
    }
  }

  public void setFrameRate(int rate) {//method to change the frame rate of the animation
    this.framesPerSecond = rate;
    this.timePerFrame = 1.0f / (float)framesPerSecond;
  }
  public void display(float xpos, float ypos, float w, float h) {
    if (run) {//if run is true, the play animation
      //checks how much time has elapsed between now and when the class was called
      float epsilon = (float)(((double)System.currentTimeMillis() - (double)startTime) / 1000.0);
      if (epsilon > timePerFrame) {//once time between frames is greater than the desire frame rate...
        frame++;//go to the next frame
        if (frame >= imageCount) {//reset the first image once we hit the end of the array
          frame = 0;
        }
        startTime = System.currentTimeMillis();//makes start time current time so that epilson is the time between frames
      }
    }
    //println(epsilon);
    //this.w = w;
    //this.h = h;
    if(dynamicDimensions){//(essentially reserved for backgrounds 'cause their dimensions are the width/height variables)
    wz = w/(width/iniWidth);//recalobrating to account for scale()
    hz = h/(height/iniHeight);
    }
    else{
    wz = w;
    hz = h;
    }
    if (facingLeft) {
      //pushMatrix();
      //translate(images[frame].width, 0);
      //scale(-1, 1); //mirrors image
      image(images[frame], xpos, ypos, 0-wz, hz);//display the current frame at inputed position and width/height
      //popMatrix();
    } else {
      image(images[frame], xpos, ypos, wz, hz);//display the current frame at inputed position and width/height
    }
  }

  public void running(boolean run) {
    this.run = run;//set local run equal to whatever was passed in
  }

  public void facingLeft(boolean facingLeft) {
    this.facingLeft = facingLeft;//set local facingLeft equal to whatever was passed in
  }

  int getFrame() {//return the frame the animation is on
    return frame;
  }

  void setFrame(int frame) {//updates the animation frame to the inputed number
    this.frame = frame;
  }

  int getWidth() {
    return images[0].width;//returns the widht of the GIF (assuming all frames are the same widht as frame 1)
  }
}
