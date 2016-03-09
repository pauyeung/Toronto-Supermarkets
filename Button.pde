class Button {
  float x, y, w, h;
  
  
  // constructor
  Button(float x, float y, float w, float h) {
    this.x = x; // x position
    this.y = y; // y position
    this.w = w; // button width
    this.h = h; // button height
  } 
  
  // checks if mouse cursor is over button
  boolean mouseOver() {
    return (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h);
  }
  
  // draws button geometry
  void draw() {
    noStroke();
    fill(mouseOver() ? 255 : 200);
    rect(x,y,w,h); 
  }
  
}

// class for zooming buttons
class ZoomButton extends Button {
  boolean in = false;
  
  // constructor
  ZoomButton(float x, float y, float w, float h, boolean in) {
    super(x, y, w, h);
    this.in = in;
  }
  
  // draws button geometry
  void draw() {
    super.draw();
    stroke(0);
    strokeWeight(2);
    line(x+3,y+h/2,x+w-3,y+h/2);
    if (in) {
      line(x+w/2,y+3,x+w/2,y+h-3);
    }
  }
  
}

// class for panning buttons
class PanButton extends Button {
  int dir = UP;
  
  // constructor
  PanButton(float x, float y, float w, float h, int dir) {
    super(x, y, w, h);
    this.dir = dir;
  }
  
  //draws button geometry
  void draw() {
    super.draw();
    stroke(0);
    switch(dir) {
      case UP:
        line(x+w/2,y+3,x+w/2,y+h-3);
        line(x-3+w/2,y+6,x+w/2,y+3);
        line(x+3+w/2,y+6,x+w/2,y+3);
        break;
      case DOWN:
        line(x+w/2,y+3,x+w/2,y+h-3);
        line(x-3+w/2,y+h-6,x+w/2,y+h-3);
        line(x+3+w/2,y+h-6,x+w/2,y+h-3);
        break;
      case LEFT:
        line(x+3,y+h/2,x+w-3,y+h/2);
        line(x+3,y+h/2,x+6,y-3+h/2);
        line(x+3,y+h/2,x+6,y+3+h/2);
        break;
      case RIGHT:
        line(x+3,y+h/2,x+w-3,y+h/2);
        line(x+w-3,y+h/2,x+w-6,y-3+h/2);
        line(x+w-3,y+h/2,x+w-6,y+3+h/2);
        break;
    }
  }
}
