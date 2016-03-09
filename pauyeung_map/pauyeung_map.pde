// please open with Processing 2

// the smooth/noSmooth error exists in the original Modest Maps to Processing code
// even when all smooth() functions are removed this error will still show up, so I kept the original documentation

// import Modest Maps library. ensure Modest Map library files are within the "Processing > libraries" folder structure
import processing.opengl.*;
import com.modestmaps.*;
import com.modestmaps.core.*;
import com.modestmaps.geo.*;
import com.modestmaps.providers.*;

// load Modest Map map
InteractiveMap map;

// make interface buttons using x and y positions, width, height, and type
ZoomButton out = new ZoomButton(5, 5, 14, 14, false);
ZoomButton in = new ZoomButton(22, 5, 14, 14, true);
PanButton up = new PanButton(14, 25, 14, 14, UP);
PanButton down = new PanButton(14, 57, 14, 14, DOWN);
PanButton left = new PanButton(5, 41, 14, 14, LEFT);
PanButton right = new PanButton(22, 41, 14, 14, RIGHT);

// all the buttons are collected in an array, for looping:
Button[] buttons = { 
  in, out, up, down, left, right
};

//load user interface
boolean gui = true;
double tx, ty, sc;

// --------------------------

//create font variables
PFont font;

// make a table to load Toronto supermarket data and create the empty array to collect data on the stores
Table table;
Supermarket[] myStores = {
};

//make a new slider for the supermarket service range distance
slider bar1;

// --------------------------

void setup() {
  size(800, 600, OPENGL);
  smooth();

  //set up my own functions (see MY_FUNCTIONS tab)
  setupMyFunctions();


  // create a new map provider using Mapbox and link map template to custom style's API
  String template = "https://api.mapbox.com/v4/mapbox.dark/{Z}/{X}/{Y}.png?access_token=pk.eyJ1IjoicG9sbHlhdXlldW5nIiwiYSI6ImNpaHAxbGJndTAxMmJ0Z200OHNpemk0eDkifQ.3CadvqrA_8l82Q-3q_-BWg";
  String[] subdomains = new String[] {"otile1", "otile2", "otile3", "otile4"  }; 
  map = new InteractiveMap(this, new TemplatedMapProvider(template, subdomains));

  // set the initial location of the map to Toronto's downtown. zoom 0 is the whole world, 19 is street level
  map.setCenterZoom(new Location(43.713, -79.379), 11);  

  // set a label font
  font = loadFont("AkkuratPro-Bold-12.vlw");
}

void draw() {
  background(0);

  // draw the Modest Map map:
  map.draw();

  //draw my own functions (see MY_FUNCTIONS tab)
  drawMyFunctions();

  // draw all the buttons and check for mouse-over
  boolean arrow = false;
  if (gui) {
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].draw();
      arrow = arrow || buttons[i].mouseOver();
    }
  }

  // if we're over a button or slider, use the arrow pointer, otherwise use the cross
  cursor(arrow || (bar1.rollover == true) ? ARROW : CROSS);

  // see if the arrow keys or +/- keys are pressed and toggle map accordingly
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        map.tx += 5.0/map.sc;
      } else if (keyCode == RIGHT) {
        map.tx -= 5.0/map.sc;
      } else if (keyCode == UP) {
        map.ty += 5.0/map.sc;
      } else if (keyCode == DOWN) {
        map.ty -= 5.0/map.sc;
      }
    } else if (key == '+' || key == '=') {
      map.sc *= 1.05;
    } else if (key == '_' || key == '-' && map.sc > 2) {
      map.sc *= 1.0/1.05;
    }
  }

  //cursor and map center information
  if (gui) {
    textFont(font, 12);

    // grab the lat/lon location under the mouse point:
    Location location = map.pointLocation(mouseX, mouseY);

    // draw the mouse location, bottom left:
    fill(0);
    noStroke();
    rect(5, height-5-g.textSize, textWidth("mouse: " + location), g.textSize+textDescent());
    fill(255);
    textAlign(LEFT, BOTTOM);
    text("mouse: " + location, 5, height-5);

    // grab the map center location
    location = map.pointLocation(width/2, height/2);

    // draw the map center location, bottom left:
    fill(0);
    noStroke();
    rect(5, height-20-g.textSize, textWidth("mouse: " + location), g.textSize+textDescent());
    fill(255);
    textAlign(LEFT, BOTTOM);
    text("map: " + location, 5, height-20);
  }
}


// map dragging capabilities
void mouseDragged() {
  //check if mouse is over zoom buttons 
  boolean arrow = false;
  if (gui) {
    for (int i = 0; i < buttons.length; i++) {
      arrow = arrow || buttons[i].mouseOver();
      if (arrow) break;
    }
  }
  // if mouse is not over zoom buttons nor the slidebar, then the map can be dragged
  if (!arrow && (bar1.locked == false)) {
    map.mouseDragged();
  }
}



// see if we're over any buttons, and toggle map accordingly when clicked:
void mouseClicked() {
  if (in.mouseOver()) {
    map.zoomIn();
    for (int i=0; i<myStores.length; i++) {
      // scale supermarket markers to zoom factor so they do not clutter the map
      // scale the distance range to zoom factor so it shows the correct distance
      myStores[i].diameter += 2;
      myStores[i].dist *=2;
    }
  } else if (out.mouseOver()) {
    map.zoomOut();
    for (int i=0; i<myStores.length; i++) {
      // scale supermarket markers by the same increment as the "zoom in" in the opposite operation
      // scale the distance range by the same increment as the "zoom in" in the opposite operation
      myStores[i].diameter -= 2;
      myStores[i].dist /=2;
    }
  } else if (up.mouseOver()) {
    map.panUp();
  } else if (down.mouseOver()) {
    map.panDown();
  } else if (left.mouseOver()) {
    map.panLeft();
  } else if (right.mouseOver()) {
    map.panRight();
  }
}



