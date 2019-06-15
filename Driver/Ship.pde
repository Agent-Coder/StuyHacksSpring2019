class Ship extends GameObject{
  private List<Component> components;
  private MainBody mainBody;
  private Ship enemyShip;
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
    components = new ArrayList<Component>();
    mainBody = new MainBody(this, position, velocity, maxVelocity, acceleration, new Rect[] {
      new Rect(new PVector(0, 0), new PVector(100, 100))
    }, 20, 1, 0);
    components.add(mainBody);
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
    pushMatrix();
    translate(getPosition().x, getPosition().y);
    for (int i = 0; i < components.size(); i++) {
      Component c = components.get(i);
      
      c.display(secsPassed, dt);
    }
    popMatrix();
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
