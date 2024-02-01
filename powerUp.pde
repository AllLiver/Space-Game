class PowerUp {
  boolean oneTime;
  int type; // index for valid types
  String[] types = {"hardPlas", "highCali", "exMag", "exMiss", "torch"}; // oneTime items start after index 1
  PImage powUp; // RES IS 20x20
  float x, y;
  int size;
  float speed;
  
  PowerUp(float x, float y, float speed, int type) {
    if(type > 1) {
      oneTime = true;
    } else {
      oneTime = false;
    }
    powUp = loadImage(types[type] + ".png");
    this.type = type;
    
    this.x = x;
    this.y = y;
    
    size = 20;
    this.speed = speed;
  }
  
  void display() {
    imageMode(CENTER);
    image(powUp, x, y);
  }
  
  void move() {
    y += speed;
  }
  
  boolean reachedBottom() {
    if(y > height + size) {
      return true;
    } else {
      return false;
    }
  }
}

// TYPES:

// Hardened plasma: increases laser damage | stored | 0
// Higher calibre: increases missile damage | stored | 1
// Extra mag: increases laser magazine by 10 | stored | 2
// Extra missile bays: increases missile magazine by 1 | stored | 3
// Welding torch: increases ship health by 5 | one time | 4

// One time = true 
// means power up is not stored in inventory, and is used on the spot
// (not a permanent upgrade)
