class RocketShooter extends Component {
  float attack;
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
      rocketVel.normalize().mult(4);
      Rocket r = new Rocket(getPosition().add(getShip().getPosition()), rocketVel, rocketVel, rocketVel.normalize(), new Rect[] {new Rect(new PVector(0, 0), new PVector(40, 20))}, getShip(), attack);
      world.rockets.add(r);
    }
  }
}
