// Oliver Fedderson | SpaceGame | 7 December 2023 //<>//

// Space ship declaring
SpaceShip s1;

// ArrayList declaring
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<HomingMissile> missiles = new ArrayList<HomingMissile>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();

// Timer declaring
Timer rockTimer;
Timer starTimer;
Timer powTimer;

// Game variable declaring
int score;
boolean play;
int level;

float clickX;
float clickY;

float laserCooldown;

void setup() {
  //size(800, 800);
  fullScreen();
  frameRate(60);
  noStroke();

  s1 = new SpaceShip(width/2, height/2, 10, 20);

  score = 0;

  rockTimer = new Timer();
  rockTimer.start(0);

  starTimer = new Timer();
  starTimer.start(0);

  play = false;

  clickX = 0;
  clickY = 0;
  
  laserCooldown = 0;
}

void draw() {
  if (play == false) {
    startScreen();
  } else {

    background(10);

    // Adds a new star once the star timer is finished
    if (starTimer.isFinished() == true) {
      stars.add(new Star(int(random(3, 6)), random(0.1, 0.5)));
      starTimer.start(int(random(50, 100)));
    }
    //println(stars.size()); // debug

    // Move and display each star
    for (int i = 0; i < stars.size(); i++) {
      // Refrence the star object in memory for readability
      Star star = stars.get(i);

      // Moving each star object
      star.move();

      // If the star has reached the bottom, delete it, move i back 1 to account for the removed object, and skip to the next part of the for loop
      if (star.reachedBottom() == true) {
        stars.remove(i);
        i -= 1;
        continue;
      }

      // Finally, display the star
      star.display();
    }

    // Move the ship
    s1.move(mouseX, mouseY);
    //s1.fire(new Laser(s1.x + s1.w/2, s1.y + s1.h/2, 3, 8, 1)); // Just for fun

    // Add a new rock after a random ammount of time
    if (rockTimer.isFinished() == true) {
      rocks.add(new Rock(random(1, 3)));
      rockTimer.start(int(random(500, 800)));
    }
    
    
    
    // Move and display each laser
    for (int i = 0; i < lasers.size(); i++) {
      // Refrence the respective laser object in memory for readability
      Laser laser = lasers.get(i);

      // Moves the laser
      laser.move();

      // If the laser has moved off the top of the screen, remove it
      if (laser.reachedTop() == true) {
        lasers.remove(i);
        i -= 1;
      }

      // Display the laser
      laser.display();
    }
    
    if(mousePressed == true) {
      if(mouseButton == LEFT && millis()-laserCooldown >= 100) {
        laserCooldown = millis();
        s1.fire(new Laser(s1.x, s1.y, 3, 8, 6, 10));
      }
    }
    
    // Moves, displays, and homes each laser
    for (int i = 0; i < missiles.size(); i++) {
      // Refrence the laser for readability
      HomingMissile missile = missiles.get(i);

      // Only homes to the nearest one IF any rocks exist
      if (rocks.size() > 0) {
        // Refrences the closest rock in memory, starts at 0
        Rock closestRock = rocks.get(0);

        // Keeps track of the most recent closest distance, starts really high to ensure that any distance is always less than this
        float closestDist = 100000000;

        // Goes over every rock to see which one is the closest
        for (int x = 0; x < rocks.size(); x ++) {
          // Refrences the rock in memory for readability
          Rock rock = rocks.get(x);

          // Calculates the distance between the missile and rock
          float dist = dist(missile.x, missile.y, rock.x, rock.y);

          // If the distance is less than the current closest rock, set closest rock and closest dist respectively
          if (dist < closestDist) {
            closestDist = dist;
            closestRock = rocks.get(x);
          }
        }

        // When all this is done, make the missile home onto the closest rocks coordinates
        missile.home(closestRock.x, closestRock.y);
      }

      // Moves the missile regardless if it has homed or not
      missile.move();

      // Removes any missiles that have gone off screen
      if (missile.offScreen() == true) {
        missiles.remove(i);
        i -= 1;
        continue;
      }

      // Displays the missile
      missile.display();
    }

    for (int i = 0; i < rocks.size(); i++) {
      // Refrence the rock object in memory for readability
      Rock rock = rocks.get(i);

      // Moves the rock
      rock.move();

      // Deletes the rock object if it goes off screen, if it does subtract from the score
      if (rock.reachedBottom() == true) {
        rocks.remove(i);
        i -= 1;
        score -= int(random(100, 200.1));
        continue;
      }


      // Detects if the rock is touching any lasers
      for (int x = 0; x < lasers.size(); x++) {
        // Refrences the laser object in memory
        Laser laser = lasers.get(x);

        // Detects if the laser is touching the rock, then removes both the laser and the rock and adds to the score
        if (laser.intersect(rock) == true) {
          rock.damage(laser.damage);
          lasers.remove(x);
          break;
        }
      }


      for (int x = 0; x < missiles.size(); x++) {
        HomingMissile missile = missiles.get(x);

        if (missile.intersect(rock) == true) {
          rock.damage(missile.damage);
          missiles.remove(x);
          break;
        }
      }


      if (s1.intersect(rock) == true) {
        rock.damage(100);
        s1.health -= 5;
      }

      if (rock.isDead()) {
        if (random(0, 10) <= 2) {
          powerUps.add(new PowerUp(rock.x, rock.y, 0.5, int(random(0, 4.1))));
        }

        rocks.remove(i);
        i -= 1;
        score += int(random(100, 150.1));

        continue;
      }

      rock.display();
    }

    for (int i = 0; i < powerUps.size(); i ++) {
      PowerUp powerUp = powerUps.get(i);

      if (s1.intersectPow(powerUp) && powerUp.type == 4) {
        s1.health += 5;
        powerUps.remove(i);
        i -= 1;
        continue;
      } else if(s1.intersectPow(powerUp) && powerUp.oneTime == false) {
        s1.collectItem(powerUp);
        powerUps.remove(i);
        i -= 1;
        continue;
      }

      powerUp.move();

      if (powerUp.reachedBottom() == true) {
        powerUps.remove(i);
        i -= 1;
        continue;
      }

      powerUp.display();
    }

    // Display this ship and info panel
    s1.reloadMissiles();
    s1.reloadLasers();
    s1.display();
    infoPanel();
    println(lasers.size());
    println(stars.size());
    println(rocks.size());
    println(frameRate);
    println(s1.mreloading);

    if (s1.health <= 0) {
      gameOver();
    }
  }
  noCursor();
}

void infoPanel() {
  rectMode(CORNER);
  fill(150, 50);
  rect(0, 0, width, 60);
  fill(255, 150);
  textSize(30);
  textAlign(CENTER);
  text(str(score), width/2, 40);

  textAlign(LEFT);
  text(str(s1.health), 30, 40);
  text("Lasers: " + s1.laserAmmo + "/" + s1.lmagSize, 100, 40);

  textAlign(RIGHT);
  text("Missiles: " + s1.missileAmmo + "/" + s1.mmagSize, width - 100, 40);
}

void startScreen() {
  background(5);
  fill(255);
  textSize(45);
  textAlign(CENTER);
  text("Space Game", width/2, 100);

  fill(255);
  text("CLICK TO START", width/2, height/2 + 15);
}

void gameOver() {
  background(5);
  fill(255);
  textAlign(CENTER);
  text("Score: " + score, width/2, height/2 + 15);
  text("GAME OVER", width/2, 100);
  noLoop();
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (play == false) {
      play = true;
    }
  } else if (mouseButton == RIGHT) {
    if (play == false) {
      play = true;
    } else {
      s1.missile(new HomingMissile(s1.x, s1.y, 2.5, 5, 6, 5, 15));
    }
  }
}
