class Ship extends GameObject{
  private List<Component> components;
  private MainBody mainBody;
  private Ship enemyShip;
  private float fuel;
  private float timeSinceFuelRanOut;
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float nFuel) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
    components = new ArrayList<Component>();
    mainBody = new MainBody(this, position, velocity, maxVelocity, acceleration, new Rect[] {
      new Rect(new PVector(0, 0), new PVector(100, 100))
    }, 20, 1, 0);
    fuel = nFuel;
    timeSinceFuelRanOut = 0;
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
    if (fuel >= 0) {
      fuel -= 0.05 * dt; //TEMP
      timeSinceFuelRanOut = 0;
    } else {
      if (timeSinceFuelRanOut == 0) {
        //setAcceleration(getClosestFuel().getPosition().sub(getPosition()).getPosition());
        //setAcceleration(getAcceleration.normalize()); //TEMP
      } else if (timeSinceFuelRanOut <= 5) {
        setAcceleration(new PVector(dt, dt)); //TEMP
        timeSinceFuelRanOut += dt;
      }
    }
    applyAcceleration();
    applyVelocity();
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
  
  /*
  public Fuel getClosestFuel() {
    ArrayList<Fuel> allFuel = fjdklsjflkds;
    float closestDist = 1000000;
    Fuel closestFuel = new Fuel();
    for (int i = 0; i < allFuel; i++) {
      Fuel f = allFuel.get(i)
      dist = sqrt(sq(f.getPosition().x - getPosition().x) + sq(f.getPosition().y - getPosition().y));
      if (dist < closestDist) {
        closestDist = dist;
        closestFuel = f;
      }
    }
    return closestFuel;
  }
  */
}
