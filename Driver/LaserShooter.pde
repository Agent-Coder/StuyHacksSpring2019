class LaserShooter extends Component {
  float attack;
  
  public Component copy() {
    RocketShooter temp = new RocketShooter(getShip(), getPosition(), getVelocity(), getMaxVelocity(), getAcceleration(), getHitBoxes(), getHealth(), getCoolDown(), attack);
    return temp;
  }
  
  public LaserShooter(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown, float attack) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, health, coolDown);
    this.attack = attack;
  }
  
  void mutate(float mutationFactor){
    attack += mutationFactor *20;
  }
  
  void reset(){
    setHealth(getBaseHealth());
  }
  
  void display(float secsPassed, float dt) {
    float percent = (attack)/(5);
    int rVal = 128;
    int bVal = 159-51;
    int gVal = 255-204;
    fill(128-(percent * rVal), 159 - (percent * bVal), 255 - (percent * gVal));
    rect(getPosition().x, getPosition().y, 40, 20);
  }
  
  void update(float secsPassed, float dt){
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      println("hl");
      setCoolDown(getBaseCoolDown());
      PVector rocketVel = getShip().getEnemyShip().getPosition().sub(getPosition().add(getShip().getPosition()));
      rocketVel.normalize().mult(10);
      Rocket r = new Rocket(getPosition().add(getShip().getPosition()), rocketVel, rocketVel, rocketVel.normalize(), new Rect[] {new Rect(new PVector(0, 0), new PVector(20, 10))}, getShip(), attack);
      world.rockets.add(r);
    }
  }
}

class Laser extends GameObject{
  Ship ship, enemy;
  float damage;
  PVector direct;
  public Laser(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitboxes, Ship s, float damage) {
    super(position,velocity, maxVelocity, acceleration, hitboxes);
    ship = s;
    enemy = ship.getEnemyShip();
    this.damage = damage;
    direct = enemy.getPosition().sub(getPosition());
  } 
  
  void update(float secsPassed, float dt){
    setAcceleration(enemy.getPosition().sub(getPosition()));
    applyVelocity();
    
  }
  
  Ship getShip() {
    return ship;
  }
  Ship getEnemy() {
    return enemy;
  }
  
  float getDam() {
    return damage;
  }
  
  void display(float secsPassed, float dt){
    pushMatrix();
    translate(getPosition().x , getPosition().y);
    rotate(direct.heading());
    fill(32, 52, 204);
    rectMode(CORNER);
    rect(0, 0, getHitBoxes()[0].width(), getHitBoxes()[0].height());
    popMatrix();
  }
  
  String toString() {
    return "rocket";
  }
}
