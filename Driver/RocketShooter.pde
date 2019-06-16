class RocketShooter extends Component {
  float attack;
  
  public Component copy() {
    RocketShooter temp = new RocketShooter(getShip(), getPosition(), getVelocity(), getMaxVelocity(), getAcceleration(), getHitBoxes(), getHealth(), getCoolDown(), attack);
    return temp;
  }
  
  public RocketShooter(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown, float attack) {
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
    fill(32, 52, 204);
    rect(getPosition().x, getPosition().y, 40, 20);
  }
  
  void update(float secsPassed, float dt){
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      println("hl");
      setCoolDown(getBaseCoolDown());
      PVector rocketVel = getShip().getEnemyShip().getPosition().sub(getPosition().add(getShip().getPosition()));
      rocketVel.normalize().mult(4);
      Rocket r = new Rocket(getPosition().add(getShip().getPosition()), rocketVel, rocketVel, rocketVel.normalize(), new Rect[] {new Rect(new PVector(0, 0), new PVector(40, 20))}, getShip(), attack);
      world.rockets.add(r);
    }
  }
}
