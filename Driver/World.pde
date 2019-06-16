class World {
  private List<Fuel> fuels;
  private List<Point> points;
  private List<Rocket> rockets;

  private float fuelSpawnCoolDown;
  private float baseFuelSpawnCoolDown;
  private float pointSpawnCoolDown;
  private float basePointSpawnCoolDown;

  public World(float fuelSpawnCoolDown, float pointSpawnCoolDown) {
    this.fuels = new ArrayList<Fuel>();
    this.baseFuelSpawnCoolDown = this.fuelSpawnCoolDown = fuelSpawnCoolDown;
    this.points = new ArrayList<Point>();
    this.basePointSpawnCoolDown = this.pointSpawnCoolDown = pointSpawnCoolDown;
    this.rockets = new ArrayList<Rocket>();
  }

  public List<Fuel> getFuels() {
    return fuels;
  }
  public List<Point> getPoints() {
    return points;
  }
  public List<Rocket> getRockets() {
    return rockets;
  }

  public void update(float secs, float dt) {
    fuelSpawnCoolDown -= dt;
    if (fuelSpawnCoolDown <= 0) {
      fuelSpawnCoolDown = baseFuelSpawnCoolDown;
      genFuel();
    }
    pointSpawnCoolDown -= dt;
    if (pointSpawnCoolDown <= 0) {
      pointSpawnCoolDown = basePointSpawnCoolDown;
      genPoint();
    }
    for (int i = 0; i < rockets.size(); i++) {
      Rocket r = rockets.get(i);
      r.update(secs, dt);
      boolean isDone = false;
      for (int j = 0; j < r.getEnemy().getComponents().size() && !isDone; j++) {
        Component c = r.getEnemy().getComponents().get(j);
        Rect hC = c.getHitBoxes()[0];
        Rect hR = r.getHitBoxes()[0];
        Rect transHC = new Rect(hC, r.getEnemy().getPosition().add(c.getPosition()));
        Rect transHR = new Rect(hR, r.getPosition());
        if (transHC.collides(transHR)) {
          c.addHealth(-1 * r.getDam());
          world.getRockets().remove(this);
          i--;
          isDone = true;
        }
      }
    }
  }

  public void display(float secs, float dt) {
    for (Fuel fuel : fuels) {
      fuel.display(secs, dt);
    }
    for (Point point : points) {
      point.display(secs, dt);
    }
    for (Rocket rocket : rockets) {
      rocket.display(secs, dt);
    }
  }

  void genFuel() {
    PVector pos;
    do {
      pos = new PVector(random(width - 80) + 40, random(height - 80) + 40);
    } while (!(pos.dist(ships[0].getPosition()) > 80 && pos.dist(ships[1].getPosition()) > 80));

    fuels.add(new Fuel(pos.copy()));
  }

  void genPoint() {
    PVector pos;
    do {
      pos = new PVector(random(width - 80) + 40, random(height - 80) + 40);
    } while (!(pos.dist(ships[0].getPosition()) > 80 && pos.dist(ships[1].getPosition()) > 80));

    points.add(new Point(pos.copy()));
  }
}
