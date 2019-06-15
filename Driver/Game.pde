class Game {

  private Ship[] ships;
  private String gameState;
  private String nextGameState;

  private int gridSize = 20;

  public Game() {
    ships = new Ship[2];
    ships[0] = new Ship(new PVector(width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));
    ships[1] = new Ship(new PVector(2*width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));

    gameState = "editor";
    nextGameState = gameState;
  }

  void drawGrid(float xOff, float yOff, float x2Off, float y2Off) {
    float x = xOff;
    while (x <= x2Off) {
      line(x, yOff, x, y2Off);
      x += gridSize;
    }
    float y = yOff;
    while (y <= y2Off) {
      line(xOff, y, x2Off, y);
      y += gridSize;
    }
  }

  public void update(float secsRunning, float dt) {
    if (gameState.equals("menu")) {
    } else if (gameState.equals("editor")) {
      background(255);
      drawGrid(0, 100, width - 100, height);
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
