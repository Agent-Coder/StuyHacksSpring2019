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
}
