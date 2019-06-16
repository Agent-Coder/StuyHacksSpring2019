class Ship extends GameObject {
  private List<Component> components;
  public MainBody mainBody;
  private Ship enemyShip;
  private float fuel;
  private PVector baseAcceleration;
  private float points;
  private int wins;

  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float nFuel) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
    components = new ArrayList<Component>();
    //mainBody = new MainBody(this, position, velocity, maxVelocity, acceleration, new Rect[] {
    //  new Rect(new PVector(0, 0), new PVector(100, 100))
    //}, 20, 1, 0);
    mainBody = new MainBody(this, new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
      new Rect(new PVector(0, 0), new PVector(100, 100))
      }, 50, 1, 0);
    fuel = nFuel;
    components.add(mainBody);
    baseAcceleration = acceleration;
    points = 0;
    wins = 0;
  }
  
  public void reset() {
    points = 0;
    fuel = 1;
    
    for (Component c : getComponents()) {
      c.reset();
    }
    
    mainBody.reset();
    mainBody.setHealth(50);
    world.fuels.clear();
    world.points.clear();
    world.rockets.clear();
    world.lasers.clear();
    
    
    
    println("HEALTH: " + mainBody.getHealth());
  }

  public Ship(Ship s) {
    super(s.getPosition(), s.getVelocity(), s.getMaxVelocity(), s.getAcceleration(), new Rect[0]);
    components = new ArrayList<Component>();
    mainBody = s.mainBody;
    fuel = s.fuel;
    enemyShip = s.enemyShip;

    for (Component c : s.components) {
      components.add(c.copy());
    }


    baseAcceleration = s.baseAcceleration;
  }
  
  public void incWins() {
    wins++;
  }
  public int getWins() {
    return wins;
  }

  public void setEnemyShip(Ship s) {
    this.enemyShip = s;
  }

  public Ship getEnemyShip() {
    return enemyShip;
  }

  public float getPoints() {
    return points;
  }
  public void update(float secsPassed, float dt) {
    println(getPoints());
    for (int i = 0; i < components.size(); i++) {
      Component c = components.get(i);
      c.checkDead();
      c.update(secsPassed, dt);
    }
    if (fuel >= 0) {
      fuel -= 0.2 * dt;
      setMaxVelocity(new PVector(2, 2));
    } else {
      setMaxVelocity(new PVector(1, 1));
    }
    if (getPosition().dist(getEnemyShip().getPosition()) <= 200) {
      setAcceleration(new PVector(0, 0));
      setVelocity(new PVector(0, 0));
      //PVector vec = getPosition().sub(getEnemyShip().getPosition()).normalize();
      //vec.add(random(-.1, .1), random(-.1, .1));
      //setAcceleration(vec.mult(.3));
      //setVelocity(vec.mult(.3));
      setMaxVelocity( new PVector(2, 2));
    }
    if (mainBody.getHealth() <= 0.2) { //TEMP
      setAcceleration(getEnemyShip().getPosition().sub(getPosition()));
      setAcceleration(getAcceleration().normalize().mult(-0.5));
    } else if (fuel <= 0) {
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
    } else if (getClosestPoint() != null && getPosition().dist(getClosestPoint().getPosition()) <= 200) {
      Point closest = getClosestPoint();
      if (closest != null) {
        PVector target = closest.getPosition().sub(getPosition());
        setAcceleration(target.normalize().mult(.2)); //TEMP
        for (int i = 0; i < components.size(); i++) {
          Rect hB = components.get(i).getHitBoxes()[0];

          Rect translatedB = new Rect(hB, getPosition().add(components.get(i).getPosition()));
          Rect translatedClosest = new Rect(closest.getHitBoxes()[0], closest.getPosition());
          if (translatedB.collides(translatedClosest)) {
            points += closest.getPointLevel();
            setMaxVelocity(new PVector(2, 2));
            world.getFuels().remove(closest);
          }
        }
      }
    } else if (getPosition().dist(getEnemyShip().getPosition()) >= 200) {
      setAcceleration(getEnemyShip().getPosition().sub(getPosition()));
      setAcceleration(getAcceleration().normalize().mult(0.5));
      setMaxVelocity( new PVector(2, 2));
    }
    boolean isDone = false;
      for (int i = 0; i < world.fuels.size() && !isDone; i++) {
        for (int j = 0; j < components.size() && !isDone; j++) {
          Fuel f = world.fuels.get(i);
          Component c = components.get(j);
          Rect hf = f.getHitBoxes()[0];
          Rect hc = c.getHitBoxes()[0];

          Rect transC = new Rect(hc, getPosition().add(c.getPosition()));
          Rect transF = new Rect(hf, f.getPosition());
          if (transC.collides(transF)) {
            fuel += f.getFuelLevel();
            world.getFuels().remove(f);
            isDone = true;
          }
        }
      }
      isDone = false;
      for (int i = 0; i < world.points.size() && !isDone; i++) {
        for (int j = 0; j < components.size() && !isDone; j++) {
          Point p = world.points.get(i);
          Component c = components.get(j);
          Rect hp = p.getHitBoxes()[0];
          Rect hc = c.getHitBoxes()[0];

          Rect transC = new Rect(hc, getPosition().add(c.getPosition()));
          Rect transP = new Rect(hp, p.getPosition());
          if (transC.collides(transP)) {
            points += p.getPointLevel();
            world.getPoints().remove(p);
            isDone = true;
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
      c.displayHealth(secsPassed, dt);
    }
    textSize(10);
    text("Points: " + (int)(getPoints() * 100), 50, 50);
    if (ships[0] == this) {
      text("Player 1", 50, 60); 
    } else {
      text("Player 2", 50, 60);
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

  public boolean isDead() {
    return mainBody.getHealth() <= 0;
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

  public Point getClosestPoint() {
    List<Point> allPoint = world.getPoints();
    float closestDist = Float.MAX_VALUE;
    Point closestPoint = null;
    for (int i = 0; i < allPoint.size(); i++) {
      Point p = allPoint.get(i);
      PVector center = getPosition().add(mainBody.getHitBoxes()[0].width() / 2, mainBody.getHitBoxes()[0].height() / 2);
      float dist = center.dist(p.getPosition());
      if (dist < closestDist) {
        closestDist = dist;
        closestPoint = p;
      }
    }
    return closestPoint;
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
      if (x + components.get(i).getHitBoxes()[0].width() > maxX) {
        maxX = x + components.get(i).getHitBoxes()[0].width();
      }
      if (y < minY) {
        minY = y;
      }
      if (y + components.get(i).getHitBoxes()[0].height() > maxY) {
        maxY = y + components.get(i).getHitBoxes()[0].height();
      }
    }
    return new Rect(new PVector(minX, minY), new PVector(maxX, maxY));
  }
  public void reflect() {
    Rect bounds = calcBound();
    if (bounds.x() + getPosition().x <= 2 || bounds.x() + bounds.width() + getPosition().x >= width - 2) {
      setVelocity(new PVector(getVelocity().x * -1, getVelocity().y));
      setAcceleration(new PVector(getAcceleration().x * -1, getAcceleration().y));
      if (bounds.x() + getPosition().x <= 2) {
        setPosition(new PVector(2.01 - bounds.x(), getPosition().y));
      } else {
        setPosition(new PVector(width - 2.01 - bounds.width() - bounds.x(), getPosition().y));
      }
    }
    if (bounds.y() + getPosition().y <= 2 || bounds.y() + bounds.height() + getPosition().y >= height - 2) {
      setVelocity(new PVector(getVelocity().x, getVelocity().y * -1));
      setAcceleration(new PVector(getAcceleration().x, getAcceleration().y * -1));
      if (bounds.y() + getPosition().y <= 2) {
        setPosition(new PVector(getPosition().x, 2.01 - bounds.y()));
      } else {
        setPosition(new PVector(getPosition().x, height - 2.01 - (bounds.height() + bounds.y())));
      }
    }
  }

  boolean collidingEnemy() {
    for (int i = 0; i < components.size(); i++) {
      for (int j = 0; j < getEnemyShip().getComponents().size(); j++) {
        Component cC = components.get(i);
        Component cE = getEnemyShip().getComponents().get(j);
        Rect hC = cC.getHitBoxes()[0];
        Rect hE = cE.getHitBoxes()[0];

        Rect transHC = new Rect(hC, getPosition().add(cC.getPosition()));
        Rect transHE = new Rect(hE, getEnemyShip().getPosition().add(cE.getPosition()));

        if (transHC.collides(transHE)) {
          println("yeay");
          return true;
        }
      }
    }
    return false;
  }
}
