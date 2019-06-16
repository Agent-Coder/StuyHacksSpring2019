class LaserShooter extends Component {
  float accuracy; //theta
  float attack;
  Laser laser;
  int frames;
  
  public Component copy() {
    LaserShooter temp = new LaserShooter(getShip(), getPosition(), getVelocity(), getMaxVelocity(), getAcceleration(), getHitBoxes(), getHealth(), getCoolDown(), accuracy, attack);
    temp.frames = frames;
    return temp;
  }

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
      PVector enemyPos = other.getPosition();
      float theta = random(0, accuracy);
      if ((int) random(2) == 0) theta *= -1;
      PVector shootVec = other.getPosition().sub(getShip().getPosition());
      float dist = getPosition().add(getShip().getPosition()).dist(other.getPosition());
      laser = new Laser(getPosition(), shootVec, dist, getShip(), accuracy);
    }
    if (laser != null && laser.timeLeft >= 0) {
      laser.update();
      laser.display();
    }
  }


  void display(float secsPassed, float dt) {
    if (laser != null) {
      laser.display();
    }
    int bVal = 153-26;
    int gVal = 204-140;
    float percent = (attack - 5)/ (30-5);
    fill(255, 153- (percent*bVal), 204-(percent * gVal));
    rect(getPosition().x, getPosition().y, 40, 20);
  }

  void reset() {
    setHealth(getBaseHealth());
    laser = null;
    frames = 0;
  }
}
