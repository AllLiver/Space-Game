class SpaceShip {
  float x, y;
  PImage ship;
  int w, h;
  int health;
  int laserAmmo;
  int lmagSize;


  int missileAmmo;
  int mmagSize;

  float lreloadStart;
  boolean lreloading;

  float mreloadStart;
  boolean mreloading;
  
  int ldamage;
  int mdamage;
  
  ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();

  SpaceShip(float x, float y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;

    ship = loadImage("spaceShip1.png");
    health = 100;

    lmagSize = 50;
    laserAmmo = lmagSize;

    lreloadStart = 0;
    lreloading = false;

    mmagSize = 8;
    missileAmmo = mmagSize;

    mreloadStart = 0;
    mreloading = false;
    
    mdamage = 15;
    ldamage = 10;
  }

  void display() {
    imageMode(CENTER);
    image(ship, x, y);
  }

  void move(float x, float y) { // TO DO: add speed parameter
    float angle = atan2(y - this.y, x - this.x);
    float dist = dist(this.x, this.y, x, y);


    this.x += cos(angle) * dist/10;
    this.y += sin(angle) * dist/10;
  }


  void fire(Laser i) {
    if (laserAmmo > 0 && lreloading == false) {
      lasers.add(i);
      laserAmmo -= 1;
    } else if(laserAmmo <= 0 && lreloading == false) {
      lreloading = true;
      lreloadStart = millis();
    }
  }
  
  void reloadLasers() {
    if(lreloading == true && (millis() - lreloadStart)/1000 >= 2) {
      lreloading = false;
      laserAmmo = lmagSize;
    }
  }

  void missile(HomingMissile i) {
    if (missileAmmo > 0 && mreloading == false) {
      mreloadStart = millis();
      missiles.add(i);
      missileAmmo -= 1;
    }
  }

  void reloadMissiles() {
    if (missileAmmo <= 0 && mreloading == false) {
      mreloadStart = millis();
      mreloading = true;
    }
    if ((millis() - mreloadStart) / 1000 >= 1 && mreloading == false) {
      mreloadStart = millis();
      if (missileAmmo < 8) {
        missileAmmo += 1;
      }
    }
    if ((millis() - mreloadStart) / 1000 >= 4 && mreloading == true) {
      mreloading = false;
      missileAmmo = mmagSize;
    }
  }

  boolean intersect(Rock rock) {
    float tempX = x;
    float tempY = y + h/2;

    if (dist(tempX, tempY, rock.x, rock.y) <= rock.radius) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersectPow(PowerUp pow) {

    if (dist(x, y, pow.x, pow.y) <= pow.size) {
      return true;
    } else {
      return false;
    }
  }
  
  void collectItem(PowerUp i)  {
    if (i.oneTime) {
      powerUps.add(i);
    }
  }
  
  void updatePowers() {
  }
}
