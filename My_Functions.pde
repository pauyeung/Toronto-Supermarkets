// MY FUNCTIONS for plotting data


//my setup functions
void setupMyFunctions() {
  
  // load Toronto Supermarket data from a CSV file
  table = loadTable("SupermarketsEdit.csv", "header");
  int datalength = table.getRowCount();
  
  // organize supermarket data into a series of arrays according to the table headers
  for (int i=0; i < datalength; i++) {
    String[] name = new String[datalength];
    name[i] = table.getString(i, "name");
    Float[] lat = new Float[datalength];
    lat[i] = table.getFloat(i, "lat");
    Float[] lon = new Float[datalength];
    lon[i] = table.getFloat(i, "lon");
    int[] risk = new int[datalength];
    risk[i] = table.getInt(i, "risk");
    
    // collect each piece of data from the arrays into a Supermarket class for each establishment
    Supermarket thisSupermarket = new Supermarket(name[i], lat[i], lon[i], risk[i]);
    
    // append each establishment into an array of stores
    myStores = (Supermarket[])append(myStores, thisSupermarket);
    
    // test if data is loading correctly 
    println(myStores[i].name + " (" + myStores[i].lat + ", " + myStores[i].lon + "): " + myStores[i].risk);

 
  }
  
  //define slider bar
    bar1 = new slider(width-100, height-15, 90, 10, 0.0, 1000.0);
}

// my draw functions
void drawMyFunctions() {
  // Modest Maps coordinate plotting classes
  Location location;
  Point2f p;

  // draw slider bar
  fill(255);
  // get slider thumb value from its location
  int pos1 = int(bar1.getPos());
  
  //slider distance legend updates with thumb value 
  textAlign(LEFT);
  text("distance: " + nf(pos1, 2) + "m", width-200, height-5);
  bar1.update(mouseX, mouseY);
  bar1.display();

  // get supermarket coordinates by taking the data from the stores array
  for (int i=0; i<myStores.length; i++) {
    location = new Location(myStores[i].lat, myStores[i].lon);
    p = map.locationPoint(location);
    noStroke();
    
    fill(255, 25);
    // draw variable distance of service range based on the slider thumb value. 
    // comment out line below when using fixed service range found in "Supermarket" class.
    myStores[i].dist = pos1*9/250;
    
    ellipse(p.x, p.y, myStores[i].dist, myStores[i].dist);
    // draw supermarket markers
    fill(myStores[i].colourVal);
    ellipse(p.x, p.y, myStores[i].diameter, myStores[i].diameter);
  }
}


//activate slider for dragging when mouse pressed
void mousePressed() {
  bar1.press(mouseX, mouseY);
}

//deactivate slider for dragging when mouse released
void mouseReleased() {
  bar1.release();
}

