class Ship extends GameObject {
  private List<Component> components;
  public MainBody mainBody;
  private Ship enemyShip;
  private float fuel;
  private PVector baseAcceleration;

  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float nFuel) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
    components = new ArrayList<Component>();
    //mainBody = new MainBody(this, position, velocity, maxVelocity, acceleration, new Rect[] {
    //  new Rect(new PVector(0, 0), new PVector(100, 100))
    //}, 20, 1, 0);
    mainBody = new MainBody(this, new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
      new Rect(new PVector(0, 0), new PVector(100, 100))
      }, 20, 1, 0);
    fuel = nFuel;
    components.add(mainBody);
    baseAcceleration = acceleration;
  }
  
  public Ship(Ship s) {
    super(s.getPosition(), s.getVelocity(), s.getMaxVelocity(), s.getAcceleration(), new Rect[0]);
    components = new ArrayList<Component>();
    mainBody = s.mainBody;
    fuel = s.fuel;
    enemyShip = s.enemyShip;
    
    for (Component c : s.components) {
      components.add(c);
    }
    
    
    baseAcceleration = s.baseAcceleration;
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
      fuel -= 0.1 * dt; //TEMP]
      baseAcceleration = getAcceleration();
      setMaxVelocity( new PVector(2, 2));
    } else {
      setMaxVelocity( new PVector(1, 1));
      Fuel closest = getClosestFuel();
      if (closest != null) {
        PVector target = closest.getPosition().sub(getPosition());
        setAcceleration(target.normalize().mult(.2)); //TEMP
        for (int i = 0; i < components.size(); i++) {
          Rect hB = components.get(i).getHitBoxes()[0];
          
          Rect translatedB = new Rect(hB, getPosition().add(components.get(i).getPosition()));
          Rect translatedClosest = new Rect(closest.getHitBoxes()[0], closest.getPosition());
          if (translatedB.collides(translatedClosest)) {
            fuel += closest.getFuelLevel();
            setMaxVelocity(new PVector(2, 2));
            world.getFuels().remove(closest);
          }
        }
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

  public Fuel getClosestFuel() {
    List<Fuel> allFuel = world.getFuels();
    float closestDist = Float.MAX_VALUE;
    Fuel closestFuel = null;
    for (int i = 0; i < allFuel.size(); i++) {
      Fuel f = allFuel.get(i);
      PVector center = getPosition().add(mainBody.getHitBoxes()[0].width() / 2, mainBody.getHitBoxes()[0].height() / 2);
      float dist = center.dist(f.getPosition());
      if (dist < closestDist) {
        closestDist = dist;
        closestFuel = f;
      }
    }
    return closestFuel;
  }
  
  public void reflect() {
    
  }
}
