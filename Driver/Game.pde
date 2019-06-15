class Game {
  
  Ship[] ships;
  
  public Game() {
    ships = new Ship[2];
    ships[0] = new Ship(new PVector(width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));
    ships[1] = new Ship(new PVector(2*width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));
  }
  
  public void update(float secsRunning, float dt) {
    
  }
  
}
