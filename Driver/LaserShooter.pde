class LaserShooter extends Component{
  float accuracy; //theta
  float attack;
  Laser laser;
  
  public LaserShooter(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown, float accuracy, float attack) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, health, coolDown);
    this.accuracy = accuracy;
    this.attack = attack;
  }
  
  void use() {
    
  }
  
  void mutate(float mutationFactor){ //mutation factor is a percent in decimal form (?? what)
    accuracy -= abs(mutationFactor*3);
    attack += abs(mutationFactor*20);
  }
  
  void update(float secsPassed, float dt){ //time since game starts, time since last frame
    Ship other = getShip().getEnemyShip();
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      setCoolDown(getBaseCoolDown());
      PVector enemyPos = other.getPosition();
      float theta = random(0,accuracy);
      if ((int) random(2) == 0) theta *= -1;
      PVector shootVec = new PVector (cos(theta)*(enemyPos.x-getPosition().x), sin(theta)*(enemyPos.y-getPosition().y));
      if (laser == null) laser = new Laser(getPosition(),shootVec, 100);
    }
  }
  
  void reset() {
    
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
    stroke(255,0,0);
    strokeWeight(20);
    line(start.x,start.y,end.x,end.y);
    stroke(255,102,102);
    strokeWeight(10);
    line(start.x,start.y,end.x,end.y);
  }
}
