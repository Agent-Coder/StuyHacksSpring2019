class Ship extends GameObject{
  private List<Component> components;
  private Ship enemyShip;
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
  }
  
  public void setEnemyShip(Ship s) {
    this.enemyShip = s;
  }
  
  public Ship getEnemyShip() {
    return enemyShip;
  }
  
  public void update(float secsPassed, float dt) {
    for (int i = 0; i < components.size(); i++) {
      Component c = components.get(i);
      
      c.update(secsPassed, dt);
    }
  }
  
  public void display(float secsPassed, float dt) {
    for (int i = 0; i < components.size(); i++) {
      Component c = components.get(i);
      
      c.display(secsPassed, dt);
    }
  }
  
  public List<Component> getComponents() {
    return components;
  }
  
  public void addComponent(Component c) {
    components.add(c);
  }
  
  public void removeComponent(Component c) {
    components.remove(c);
  }
}
