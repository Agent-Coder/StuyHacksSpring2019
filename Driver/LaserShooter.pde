class LaserShooter extends Component {
  float accuracy; //theta
  float attack;
  Laser laser;
  int frames;

  public LaserShooter(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown, float accuracy, float attack) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, health, coolDown);
    this.accuracy = accuracy;
    this.attack = attack;
    laser = null;
    frames = 0;
  }

  void mutate(float mutationFactor) { //mutation factor is a percent in decimal form (?? what)
    accuracy -= abs(mutationFactor*3);
    attack += abs(mutationFactor*20);
  }

  void update(float secsPassed, float dt) { //time since game starts, time since last frame
    Ship other = getShip().getEnemyShip();
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      setCoolDown(getBaseCoolDown());
      frames = 30;
    }
    if (frames >= 0) {
      PVector enemyPos = other.getPosition();
      float theta = random(0, accuracy);
      if ((int) random(2) == 0) theta *= -1;
      PVector shootVec = new PVector (cos(theta)*(enemyPos.x-getPosition().x), sin(theta)*(enemyPos.y-getPosition().y));
      laser = new Laser(getPosition(), shootVec, 100);
      frames--;
    }
  }


  void display(float secsPassed, float dt) {
    if (laser != null) {
      laser.display();
    }
    fill(255, 0, 0);
    rect(getPosition().x, getPosition().y, 40, 20);
  }

  void reset() {
    setHealth(getBaseHealth());
    laser = null;
    frames = 0;
  }
}

class Laser {
  PVector start, end;

  Laser(PVector start, PVector direction, float laserLength) {
    this.start = start.copy();
    PVector directionNormal = direction.copy().normalize();
    directionNormal.mult(laserLength);
    end = PVector.add(start, directionNormal);
  }

  void display() {
    stroke(255, 0, 0);
    strokeWeight(20);
    line(start.x, start.y, end.x, end.y);
    stroke(255, 102, 102);
    strokeWeight(10);
    line(start.x, start.y, end.x, end.y);
    strokeWeight(1);
    stroke(0);
  }
}
