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
  
  void display(float secsPassed, float dt){
  }
  
  void update(float secsPassed, float dt){
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      setCoolDown(getBaseCoolDown());
      PVector rocketVel = new PVector(4, 0);
      Rocket r = new Rocket(getPosition().add(getShip().getPosition()), rocketVel, rocketVel, getAcceleration(), new Rect[] {new Rect(new PVector(0, 0), new PVector(100, 100))}, getShip() );
      world.rockets.add(r);
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
    setAcceleration(enemy.getPosition().sub(getPosition()));
    applyAcceleration();
    applyVelocity();
  }
  void display(float secsPassed, float dt){
    pushMatrix();
    translate(getPosition().x, getPosition().y);
    rotate(getPosition().heading());
    fill(32, 52, 204);
    rectMode(CORNER);
    rect(0, 0, getHitBoxes()[0].width(), getHitBoxes()[0].height(), getHitBoxes()[0].width() / 2, getHitBoxes()[0].height() / 2, 0, 0);
    popMatrix();
  }
}
