class Star {
  float x, y;
  float speed;
  int diam;
  int opacity;

  Star(int diam, float speed) {
    this.x = random(0, width);
    this.y = 0 - diam/2;
    this.diam = diam;
    this.speed = speed;
    this.opacity = int(random(50, 255));
  }

  void display() {
    fill(255, 255, 0, opacity);
    circle(x, y, diam/2);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y > height + diam/2) return true;
    else return false;
  }
}
