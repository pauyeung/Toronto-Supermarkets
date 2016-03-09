class Supermarket {
  String name;    // name of supermarket
  float lat, lon; // coordinate points of supermarket
  int colourVal;  // colour value of point fill
  int risk;       // Toronto DineSafe risk level, risk increases with higher volume of food served, larger population served 
  int diameter;   // diameter of point marker
  float service;  // distance of the service range of the supermarket in metres
  float dist;     // diameter of the service range as scaled to map base zoom level

  // Constructor
  Supermarket(String n, float latitude, float longitude, int healthRisk) {
    name = n;
    lat = latitude;
    lon = longitude;
    risk = healthRisk;
    
    //colour coding supermarkets by their DineSafe risk level
    //high 
    if (healthRisk == 2) {
      colourVal=#AEFF64;
    } 
    //medium  
    else if (healthRisk == 1) {
      colourVal=#6A9B3D;
    } 
    //low 
    else {
      colourVal=#354D1E;
    }
    
    // setting the diameter of the marker
    diameter=5;
    
    // if using a fixed service range, activate the lines below and comment out "myStores[i].dist = pos1*9/250;" in My_Functions:
    // service = 500; //input service distance here
    // dist = service*9/250;

  }
}

