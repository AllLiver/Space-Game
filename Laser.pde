class Laser {
  float x, y;
  int w, h, speed;
  float damage;

  Laser(float x, float y, int w, int h, int speed, float damage) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.damage = damage;
  }

  void display() {
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void move() {
    y -= speed;
  }

  boolean reachedTop() { // TO DO: implement this method
    if (y + h/2 < 0) {
      return true;
    } else {
      return false;
    }
  }

  boolean intersect(Rock rock) {
    float testX = x;
    float testY = y - h/2;

    if (dist(testX, testY, rock.x, rock.y) <= rock.radius) {
      return true;
    } else {
      return false;
    }
  }
}
