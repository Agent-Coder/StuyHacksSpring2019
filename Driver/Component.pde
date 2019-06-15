abstract class Component extends GameObject{
  private float health;
  private float coolDown;
  private Ship ship;
  public Component(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes, float health, float coolDown) {
    super(position, velocity, maxVelocity, acceleration, hitBoxes);
    this.health = health;
    this.coolDown = coolDown;
    this.ship = ship;
  }
  
  public abstract void use();
  public abstract void mutate(float mutationFactor);
  public abstract void update(float secsPassed, float dt);
  
  public void setHealth(float health) {
    this.health = health;
  }
  
  public float getHealth() {
    return health;
  }
  
  public void addHealth(float dHealth) {
    this.health += dHealth;
  }
  

}
