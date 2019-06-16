class World {
  private List<Fuel> fuels;

  //private List<Point> points;

  private float fuelSpawnCoolDown;
  private float baseFuelSpawnCoolDown;
  ArrayList<Rocket> rockets;

  public World(float fuelSpawnCoolDown) {
    this.fuels = new ArrayList<Fuel>();
    this.baseFuelSpawnCoolDown = this.fuelSpawnCoolDown = fuelSpawnCoolDown;
    rockets = new ArrayList<Rocket>();
  }
  
  public List<Fuel> getFuels() {
    return fuels;
  }

  public void update(float secs, float dt) {
    fuelSpawnCoolDown -= dt;
    if (fuelSpawnCoolDown <= 0) {
      fuelSpawnCoolDown = baseFuelSpawnCoolDown;
      genFuel();
    }
  }
  
  public void display(float secs, float dt) {
    for (Fuel fuel : fuels) {
      fuel.display(secs, dt);
    }
  }

  void genFuel() {
    PVector pos;
    do {
      pos = new PVector(random(width), random(height));
    } while (!(pos.dist(ships[0].getPosition()) > 80 && pos.dist(ships[1].getPosition()) > 80));
    
    fuels.add(new Fuel(pos.copy()));
  }
  
  
}
