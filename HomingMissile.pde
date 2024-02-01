class HomingMissile {
  float x, y, angle, offset, size, speed;
  float creationTime;
  float accSpeed;
  float damage;

  HomingMissile(float x, float y, float offset, float size, float speed, float accSpeed, float damage) {
    this.x = x;
    this.y = y;
    this.offset = offset;
    this.size = size;
    this.speed = speed;
    angle = HALF_PI * -1;
    creationTime = millis();
    this.accSpeed = accSpeed;
    this.damage = damage;
  }

  void display() {
    fill(0, 100, 150);
    triangle(cos(angle) * size + x, sin(angle) * size + y, cos(angle + offset) * size + x, sin(angle + offset) * size + y, cos(angle - offset) * size + x, sin(angle - offset) * size + y);
  }

  void home(float x, float y) {
    angle = atan2(y - this.y, x - this.x);
  }

  void move() {
    this.x += cos(angle) * (log((millis() - creationTime + 1000) / 1000) * speed + accSpeed);
    this.y += sin(angle) * (log((millis() - creationTime + 1000) / 1000) * speed + accSpeed);
  }

  boolean intersect(Rock rock) {
    if (dist(cos(angle) * size + x, sin(angle) * size + y, rock.x, rock.y) <= rock.radius) {
      return true;
    } else {
      return false;
    }
  }

  boolean offScreen() {
    if (x < 0 || y < 0 || x > width || y > height) {
      return true;
    } else {
      return false;
    }
  }
}
