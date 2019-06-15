public Ship[] ships;
public World world;

class Game {

  private Button[] buttons;
  private String gameState;
  private String nextGameState;

  private int gridSize = 20;

  LaserShooter l;

  public Game() {
    ships = new Ship[2];
    ships[0] = new Ship(new PVector(width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));
    ships[1] = new Ship(new PVector(2*width/3, height/2), new PVector(0, 0), new PVector(5, 5), new PVector(0, 0));
    ships[0].setEnemyShip(ships[1]);
    ships[1].setEnemyShip(ships[0]);
    
    buttons = new Button[3];
    buttons[0] = new Button(new PVector(10, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Laser", 32, "laser");
    buttons[1] = new Button(new PVector(160, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Shield", 32, "shield");
    buttons[2] = new Button(new PVector(310, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Crew", 32, "crew");
    //buttons[3] = new Button(new PVector(300, 0), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(100, 100))}, "Las", 32, "laser");
    
    world = new World(3);
    
    gameState = "game";
    nextGameState = gameState;
  }
  
  void buttonPressedOnce(String buttonText) { //sends signal when first pressed
    println("Button " + buttonText + " was pressed.");
  }
  
  void buttonPressed(String buttonText) { //sends signal while pressed
    
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
      drawGrid(0, 100, width, height-100);
      for (Button b : buttons) {
        b.update(secsRunning, dt);
      }
      for (Button b : buttons) {
        b.display(secsRunning, dt);
      }
    } else if (gameState.equals("game")) {
      background(255);
      world.update(secsRunning, dt);
      world.display(secsRunning, dt);
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
      l.update(secsRunning, dt);
      l.display(secsRunning, dt);
      text("You messed up lmao", width/2, height/2);
    }
    gameState = nextGameState;
  }
}
