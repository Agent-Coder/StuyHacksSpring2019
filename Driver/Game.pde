public Rect mouse;
public Ship[] ships;
public World world;

class Game {

  private Button[] buttons;
  private String gameState;
  private String nextGameState;
  private String selected;
  private int gridSize = 20;

  LaserShooter l;

  public Game() {
    ships = new Ship[2];

    buttons = new Button[4];
    buttons[0] = new Button(new PVector(10, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Laser", 32, "laser");
    buttons[1] = new Button(new PVector(160, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Shield", 32, "shield");
    buttons[2] = new Button(new PVector(310, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Crew", 32, "crew");
    buttons[3] = new Button(new PVector(width-100, height-90), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(80, 80))}, "Next", 32, "Go");
    gameState = "editor";

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
    selected="";
  }

  void buttonPressedOnce(String buttonText) { //sends signal when first pressed
    println("Button " + buttonText + " was pressed.");
    selected=buttonText;
    if (ship.getComponents().get(ship.getComponents().size() - 1) == newComp) {
      ship.getComponents().get(ship.getComponents().size()-1);
    }
    newComp = null;
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

  boolean shadowGrid(Ship s) {
    fill(200, 200, 200);
    Rect gridBounds = new Rect(new PVector(0, 100), new PVector(width-20, height - 120));

    float x = round(mouseX/gridSize)*gridSize;
    float y = round(mouseY/gridSize)*gridSize;

    //println(s.getComponents());

    if (newComp == null) {
      if (selected.equals("laser")) {
        newComp = new LaserShooter(s, new PVector(x, y).sub(s.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(40, 20))
          }, 20, 1, 0, 1);
      } else if (selected.equals("shield")) {
        newComp = new Shield(s, new PVector(x, y).sub(s.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(40, 40))
          });
      } else if (selected.equals("crew")) {
        newComp = new Crew(s, new PVector(x, y).sub(s.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(60, 20))
          });
      }
      if (newComp != null && mouse.collides(gridBounds)) {
        s.addComponent(newComp);
      }
    } else {
      if (s.getComponents().get(s.getComponents().size()-1) != newComp && mouse.collides(gridBounds)) {
        s.addComponent(newComp);
      } else {
        newComp.setPosition(new PVector(x, y).sub(s.getPosition()));
      }
    }

    //if (newComp != null) {
    //  s.addComponent(newComp);
    //}

    List<Component> comp=ship.getComponents();
    println(comp.size());
    boolean placeable=mouse.collides(gridBounds) && newComp != null;
    if (placeable) {
      for (Component c : comp) {
        if (c != newComp) {
          //  //println(new Rect(c.getHitBoxes()[0], ship.getPosition().add(c.getPosition())));
          //  //println(new Rect(newComp.getHitBoxes()[0], ship.getPosition().add(newComp.getPosition())));
          //  //println();
          //}
          if (c != newComp && new Rect(c.getHitBoxes()[0], ship.getPosition().add(c.getPosition())).collides(new Rect(newComp.getHitBoxes()[0], ship.getPosition().add(newComp.getPosition())))) {
            placeable = false;
          }
        }
      }
    }

    //println(s.getComponents().get(s.getComponents().size()-1));
    //println(newComp);
    if (s.getComponents().get(s.getComponents().size()-1) == newComp && ((!mouse.collides(gridBounds)) || !placeable)) {
      s.getComponents().remove(s.getComponents().size()-1);
    }

    //if (placeable) {
    //  if (selected.equals("laser")) {
    //    ship[0].addComponent(LaserShooter);
    //  }
    //}

    //if (mousePressed && placeable) {
    //  placeOnGrid();
    //}

    fill(0, 0, 0);
    return false;
  }
  //void placeOnGrid(float x, float y) {



  //  if (selected.equals("laser")) {
  //    rect(round(a, b, 40, 20));
  //  } else if (selected.equals("shield")) {
  //    rect(round(mouseX/gridSize)*gridSize, round(mouseY/gridSize)*gridSize, 40, 40);
  //  }
  //}
  public void update(float secsRunning, float dt) {

    mouse = new Rect(new PVector(mouseX, mouseY), new PVector(mouseX, mouseY));

    if (gameState.equals("menu")) {
    } else if (gameState.equals("editor")) {
      background(255);
      drawGrid(0, 100, width, height-100);
      //square(300, 300, 100);
      for (Button b : buttons) {
        b.update(secsRunning, dt);
      }
      for (Button b : buttons) {
        b.display(secsRunning, dt);
      }
      //if (shadowGrid(ships[0])) {
      //  placeOnGrid();
      //}
      //for (Ship ship : ships) {
      //  ship.display(secsRunning, dt);
      //}
      ship = ships[0];
      shadowGrid(ships[0]);
      ships[0].display(secsRunning, dt);
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
      //l.update(secsRunning, dt);
      //l.display(secsRunning, dt);
      text("You messed up lmao", width/2, height/2);
    }
    gameState = nextGameState;
  }
}
