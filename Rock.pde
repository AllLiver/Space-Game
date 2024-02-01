class Rock {
  float x;
  float y;
  float speed;
  float radius;
  int diam;
  PImage rock;

  Rock(float speed) {
    diam = int(random(25, 50));
    y = 0 - diam/2;
    this.speed = speed;
    radius = diam/2;
    x = random(0 + radius, width - radius);
    rock = loadImage("rock" + int(random(1, 9.1)) + ".png");
    rock.resize(diam, diam);
  }

  void display() {
    fill(100);
    imageMode(CENTER);
    image(rock, x, y);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y > height + diam/2) {
      return true;
    } else {
      return false;
    }
  }

  void damage(float damage) {
    diam -= damage;
    radius = diam/2;
    if (diam > 0) {
      rock.resize(diam, diam);
    }
  }

  boolean isDead() {
    if (diam <= 25) {
      return true;
    } else {
      return false;
    }
  }
}
