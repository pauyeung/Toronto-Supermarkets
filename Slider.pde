class slider {
  int x, y;             // x and y coordinates
  float sw, sh;         // slider width and height
  float pos;            // posititon of slider thumb
  float posMin, posMax; // max and min values of thumb (actual)
  boolean rollover;     // true when the mouse is over
  boolean locked;       // true when its the active slider
  float minVal, maxVal; // min and max values for the thumb (scaled)


  // constructor
  slider(int xp, int yp, int w, int h, float miv, float mav) {
    x = xp;
    y = yp;
    sw = w;
    sh = h;
    minVal = miv;
    maxVal = mav;
    pos = x + sw / 2 - sh / 2;
    posMin = x;
    posMax = x + sw - sh;
  }

  // updates the over boolean and the position of the thumb
  void update(int mx, int my) {
    if (over(mx, my) == true) {
      rollover = true;
    } else {
      rollover = false;
    }
    if (locked == true) {
      pos = constrain(mx - sh / 2, posMin, posMax);
    }
  }

  // activates slider for movement when it is pressed
  void press(int mx, int my) {
    if (rollover == true) {
      locked = true;
    } else {
      locked = false;
    }
  }

  // Resets the slider to neutral
  void release() {
    locked = false;
  }

  // returns true if the cursor is over the slider
  boolean over(int mx, int my) {
    if ((mx > x) && (mx < x + sw) && (my > y) && (my < y + sh)) {
      return true;
    } else {
      return false;
    }
  }

  // draws slider
  void display() {
    fill(50);
    rect(x, y, sw, sh);
    if ((rollover == true) || (locked == true)) {
      fill(255);
    } else {
      fill(200);
    }
    rect(pos, y, sh, sh);
  }

  // Returns the current value of the thumb
  float getPos() {
    float scalar = sw / (sw - sh);
    float ratio = (pos - x) * scalar;
    float offset = minVal + (ratio / sw * (maxVal - minVal));
    return offset;
  }
}

