class Ship extends GameObject {
  private List<Component> components;
  public MainBody mainBody;
  private Ship enemyShip;
  private float fuel;
  private float timeSinceFuelRanOut;
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
    timeSinceFuelRanOut = 0;
    components.add(mainBody);
    baseAcceleration = acceleration;
    //LaserShooter l = new LaserShooter(this, new PVector(100, 0),new PVector(0, 0),new PVector(0, 0),new PVector(0, 0),new Rect[]{new Rect(new PVector(0, 0), new PVector(100, 100))},100,5,20,100);
    //components.add(l);
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
    reflect();
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
  
  public Rect calcBound() {
    float minX = 0;
    float minY = 0;
    float maxX = 0;
    float maxY = 0;
    for (int i = 0; i < components.size(); i++) {
      float x = components.get(i).getPosition().x;
      float y = components.get(i).getPosition().y;
      if (x < minX) {
        minX = x;
      }
      if (x > maxX) {
        maxX = x;
      }
      if (y < minY) {
        minY = y;
      }
      if (y > maxY) {
        maxY = y;
      }
    }
    return new Rect(new PVector(minX, minY), new PVector(maxX, maxY));
  }
  public void reflect() {
    boolean isDone = false;
    Rect bounds = calcBound();
    /*for (int i = 0; i < components.size() && !isDone; i++) { //do right or left
      Component c = components.get(i);
      if (c.getPosition().x + getPosition().x <= 2 || c.getPosition().x + getPosition().x + c.getHitBoxes()[0].width() >= width - 2) {
        println(getVelocity().x);
        setVelocity(new PVector(getVelocity().x * -1, getVelocity().y));
        setAcceleration(new PVector(getAcceleration().x * -1, getAcceleration().y));
        isDone = true;
        if (c.getPosition().x + getPosition().x <= 2) {
          setPosition(new PVector(2.1, getPosition().y));
        } else {
          setPosition(new PVector(width - 2.1 - c.getHitBoxes, getPosition().y));
        }
      }
    }*/
    if (bounds.x() + getPosition().x <= 2 || bounds.x() + bounds.width() + getPosition().x >= width - 2) {
      setVelocity(new PVector(getVelocity().x * -1, getVelocity().y));
      setAcceleration(new PVector(getAcceleration().x * -1, getAcceleration().y));
      if (bounds.x() + getPosition().x <= 2) {
        setPosition(new PVector(2.1 + bounds.x(), getPosition().y));
      } else {
        setPosition(new PVector(width - 2.1 - bounds.y, getPosition().y));
      }
    }
    for (int i = 0; i < components.size() && !isDone; i++) { //do right or left
      Component c = components.get(i);
      if (c.getPosition().y + getPosition().y <= 2 || c.getPosition().y + getPosition().y + c.getHitBoxes()[0].height() >= height - 2) {
        println(getVelocity().y);
        setVelocity(new PVector(getVelocity().x, getVelocity().y * -1));
        setAcceleration(new PVector(getAcceleration().x, getAcceleration().y *= -1));
        isDone = true;
        if (c.getPosition().y + getPosition().y <= 2) {
          setPosition(new PVector(getPosition().x, 2.1));
        } else {
          setPosition(new PVector(getPosition().x, height - 2.1 - c.getHitBoxes()[0].height()));
        }
      }
    }
    
  }
}
