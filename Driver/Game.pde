public Rect mouse;
public Ship[] ships;
public World world;

class Game {

  private Button[] buttons;
  private String gameState;
  private String nextGameState;
  private String selected;
  private int gridSize = 20;
  public int money;

  LaserShooter l;

  public Game() {
    ships = new Ship[2];
    money=100;
    buttons = new Button[4];
    buttons[0] = new Button(new PVector(10, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Laser", 32, "laser");
    buttons[1] = new Button(new PVector(160, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Shield", 32, "shield");
    buttons[2] = new Button(new PVector(310, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Crew", 32, "crew");
    buttons[3] = new Button(new PVector(width-100, height-90), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(80, 80))}, "Next", 32, "Go");

    ships[0] = new Ship(new PVector(300, 300), new PVector(0, 0), new PVector(2, 2), new PVector(0, 0), 1);
    ships[1] = new Ship(new PVector(500, 500), new PVector(0, 0), new PVector(2, 2), new PVector(0, 0), 1);
    ships[0].setEnemyShip(ships[1]);
    ships[1].setEnemyShip(ships[0]);

    world = new World(3);

    gameState = "game";
    nextGameState = gameState;
    selected="";
    
    ship = ships[0];
  }

  void buttonPressedOnce(String buttonText) { //sends signal when first pressed
    println("Button " + buttonText + " was pressed.");
    selected=buttonText;
    if (ship.getComponents().get(ship.getComponents().size() - 1) == newComp) {
      ship.getComponents().get(ship.getComponents().size()-1);
    }
    newComp = null;
    if (buttonText.equals("Go")) {
      if (ship == ships[0]) {
        ship = ships[1];
        money=100;
      } else {
        nextGameState = "game";
      }
    }
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

  Component newComp = null;
  Ship ship = null;

  boolean shadowGrid() {
    fill(200, 200, 200);
    Rect gridBounds = new Rect(new PVector(-1, 99), new PVector(width+1, height - 99));

    float x = round(mouseX/gridSize)*gridSize;
    float y = round(mouseY/gridSize)*gridSize;

    //println(s.getComponents());

    if (newComp == null) {
      if (selected.equals("laser")) {
        newComp = new LaserShooter(ship, new PVector(x, y).sub(ship.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(40, 20))
          }, 20, 1, 0, 1);
      } else if (selected.equals("shield")) {
        newComp = new Shield(ship, new PVector(x, y).sub(ship.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(40, 40))
          });
      } else if (selected.equals("crew")) {
        newComp = new Crew(ship, new PVector(x, y).sub(ship.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(20, 20))
          });
      }
      if (newComp != null && mouse.collides(gridBounds)) {
        ship.addComponent(newComp);
      }
    } else {
      if (ship.getComponents().get(ship.getComponents().size()-1) != newComp && mouse.collides(gridBounds)) {
        ship.addComponent(newComp);
      } else {
        newComp.setPosition(new PVector(x, y).sub(ship.getPosition()));
      }
    }

    List<Component> comp=ship.getComponents();
    boolean placeable=mouse.collides(gridBounds) && newComp != null;
    if (placeable) {
      boolean tangent = false;
      for (Component c : comp) {
        if (c != newComp) {
          //println(gridBounds.contains(new Rect(newComp.getHitBoxes()[0], ship.getPosition().add(newComp.getPosition()))));

          Rect cTranslated = new Rect(c.getHitBoxes()[0], ship.getPosition().add(c.getPosition()));
          Rect newTranslated = new Rect(newComp.getHitBoxes()[0], ship.getPosition().add(newComp.getPosition()));

          if (cTranslated.getIntersectPoints(newTranslated) >= 2) {
            tangent = true;
          }

          if (c != newComp && cTranslated.collides(newTranslated) || !gridBounds.contains(newTranslated)) {
            placeable = false;
          }
        }
      }
      if (mousePressed && tangent) {
        if (selected.equals("laser")&&money-25>=0) {
          money-=25;
          newComp=null;
          selected="";
        } else if (selected.equals("shield")&&money-20>=0) {
          money-=20;
          newComp=null;
          selected="";
        } else if (selected.equals("crew")&&money-10>=0) {
          money-=10;
          newComp=null;
          selected="";
        }
      }
    }
    if (ship.getComponents().get(ship.getComponents().size()-1) == newComp && ((!mouse.collides(gridBounds)) || !placeable)) {
      ship.getComponents().remove(ship.getComponents().size()-1);
      newComp = null;
    }
    fill(0, 0, 0);
    return false;
  }

  public void update(float secsRunning, float dt) {

    mouse = new Rect(new PVector(mouseX, mouseY), new PVector(mouseX, mouseY));
    if (gameState.equals("menu")) {
    } else if (gameState.equals("editor")) {
      background(255);
      drawGrid(0, 100, width, height-100);
      fill(0, 255, 255);
      rect(0, 600, 100, 100);
      fill(50, 180, 50);
      text("$"+str(money), 50, height-50);
      for (Button b : buttons) {
        b.update(secsRunning, dt);
      }
      for (Button b : buttons) {
        b.display(secsRunning, dt);
      }
      shadowGrid();
      ship.display(secsRunning, dt);
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
      text("You messed up lmao", width/2, height/2);
    }
    gameState = nextGameState;
  }
}
