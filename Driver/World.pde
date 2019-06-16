class World {
  private List<Fuel> fuels;
  private List<Point> points;

  //private List<Point> points;

  private float fuelSpawnCoolDown;
  private float baseFuelSpawnCoolDown;
  private float pointSpawnCoolDown;
  private float basePointSpawnCoolDown;
  ArrayList<Rocket> rockets;

  public World(float fuelSpawnCoolDown, float pointSpawnCoolDown) {
    this.fuels = new ArrayList<Fuel>();
    this.baseFuelSpawnCoolDown = this.fuelSpawnCoolDown = fuelSpawnCoolDown;
    this.points = new ArrayList<Point>();
    this.basePointSpawnCoolDown = this.pointSpawnCoolDown = pointSpawnCoolDown;
    rockets = new ArrayList<Rocket>();
  }
  
  public List<Fuel> getFuels() {
    return fuels;
  }
  public List<Point> getPoints() {
    return points;
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
  }
  
  public void display(float secs, float dt) {
    for (Fuel fuel : fuels) {
      fuel.display(secs, dt);
    }
    for (Point point : points) {
      point.display(secs, dt);
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
