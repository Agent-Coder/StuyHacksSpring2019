class Game {

  private Ship[] ships;
  private String gameState;
  private String nextGameState;

  private int gridSize = 50;

  public Game() {
    ships = new Ship[2];
    ships[0] = new Ship(new PVector(width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));
    ships[1] = new Ship(new PVector(2*width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));

    gameState = "editor";
    nextGameState = gameState;
  }

  void drawGrid() {
    int x = 0;
    while (x < width) {
      line(x, 0, x, height);
      x += gridSize;
    }
    int y = 0;
    while (y < height) {
      line(0, y, width, y);
      y += gridSize;
    }
  }

  public void update(float secsRunning, float dt) {
    if (gameState.equals("menu")) {
    } else if (gameState.equals("editor")) {
      background(255);
      drawGrid();
    } else if (gameState.equals("game")) {
      background(255);
      for (Ship ship : ships) {
        ship.update(secsRunning, dt);
      }
      for (Ship ship : ships) {
        ship.display(secsRunning, dt);
      }
    } else if (gameState.equals("mutating")) {
    } else {
      background(255);
      fill(255);
      text("You messed up lmao", width/2, height/2);
    }
    gameState = nextGameState;
  }
}
