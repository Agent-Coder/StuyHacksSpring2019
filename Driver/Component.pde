abstract class Component extends GameObject{
  float health;
  float coolDown;
  public Component(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float health, float coolDown) {
    super(position, velocity, maxVelocity, acceleration);
    this.health = health;
    this.coolDown = coolDown;
  }
  
  public abstract void use();
  
  public void setHealth(float health) {
    this.health = health;
  }
  
  public float getHealth() {
    return health;
  }
  
  public void addHealth(float dHealth) {
    this.health += dHealth;
  }
  
  public float getCoolDown() {
    return coolDown;
  }
  
  public void setCoolDown(float coolDown) {
    this.coolDown = coolDown;
  }
  
  public void addCoolDown(float dCoolDown) {
    this.coolDown += dCoolDown;
  }
}
