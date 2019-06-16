abstract class Component extends GameObject{
  private float health;
  private float baseHealth;
  
  private float coolDown;
  private float baseCoolDown;
  
  
  private Ship ship;
  public Component(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown) {
    super(position, velocity, maxVelocity, acceleration, hitBoxes);
    this.health = health;
    this.baseHealth = health;
    this.coolDown = coolDown;
    this.baseCoolDown = coolDown;
    this.ship = ship;
  }
  
  public Component(Component c) {
    super(c.getPosition(),c.getVelocity(), c.getMaxVelocity(), c.getAcceleration(), c.getHitBoxes());
    this.health = c.health;
    this.baseHealth = c.baseHealth;
    
    this.coolDown = c.coolDown;
    this.baseCoolDown = c.coolDown;
  }
  
  public abstract void mutate(float mutationFactor);
  public abstract void reset();
  
  public void setHealth(float health) {
    this.health = health;
  }
  
  public float getHealth() {
    return health;
  }
  
  public void addHealth(float dHealth) {
    //this.health += dHealth;
    setHealth(getHealth() + dHealth);
  }
  
  public float getCoolDown() {
    return coolDown;
  }
  
  public void setCoolDown(float coolDown) {
    this.coolDown = coolDown;
  }
  
  public void addCoolDown(float dCoolDown) {
    //this.coolDown += dCoolDown;
    setCoolDown(getCoolDown() + dCoolDown);
  }
  
  public void setBaseHealth(float health) {
    this.baseHealth = health;
  }
  
  public float getBaseHealth() {
    return baseHealth;
  }
  
  public void addBaseHealth(float dHealth) {
    this.baseHealth += dHealth;
  }
  
  public float getBaseCoolDown() {
    return baseCoolDown;
  }
  
  public void setBaseCoolDown(float coolDown) {
    this.baseCoolDown = coolDown;
  }
  
  public void addBaseCoolDown(float dCoolDown) {
    this.baseCoolDown += dCoolDown;
  }
  
  public void setShip(Ship s) {
    this.ship = s;
  }
  
  public Ship getShip() {
    return ship;
  }
  
  public void displayHealth(float secsPassed, float dt) {
    fill(127);
    rect(getPosition().x+2, getPosition().y+2, 15, 7);
    if (health >= 0) {
      fill (0,255,0);
      rect (getPosition().x+2, getPosition().y+2, (health/baseHealth)*15, 7);
    }
  }
}
