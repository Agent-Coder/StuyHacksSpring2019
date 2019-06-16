class RocketShooter extends Component {
  float attack;
  PVector rocketVel;
  public RocketShooter(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown, float attack, PVector rockVel) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, health, coolDown);
    this.attack = attack;
    rocketVel = rockVel;
  }
  
  void mutate(float mutationFactor){
    attack += mutationFactor *20;
    rocketVel.x *= mutationFactor;
    rocketVel.y *= mutationFactor;
  }
  
  void reset(){
    setHealth(getBaseHealth());
  }
  
  void display(float secsPassed, float dt){
  }
  
  void update(float secsPassed, float dt){
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      setCoolDown(getBaseCoolDown());
      Rocket r = new Rocket(getPosition(), rocketVel, rocketVel, getAcceleration(), new Rect[] {new Rect(new PVector(0, 0), new PVector(100, 100))}, getShip() );
    }
  }
}

class Rocket extends GameObject{
  Ship ship, enemy;
  public Rocket(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitboxes, Ship s) {
    super(position,velocity, maxVelocity, acceleration, hitboxes);
    ship = s;
    enemy = ship.getEnemyShip();
    
  } 
  
  void update(float secsPassed, float dt){
    PVector target = enemy.getPosition();
    
  }
  void display(float secsPassed, float dt){
  }
}
