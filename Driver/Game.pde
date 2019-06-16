public Rect mouse;
public Ship[] ships;
public World world;

public PFont gameFont;

class Game {

  private Button[] buttons;
  private String gameState;
  private String nextGameState;
  private String selected;
  private int gridSize = 20;
  private int numLevels = 0;
  private int numNextEditors = 0;
  public int money;
  public boolean firstMut;
  public int shape;
  LaserShooter l;

  private Button[] menuButtons;
  private Button tutorialNext;

  public Game() {
    ships = new Ship[2];
    money=100;
    buttons = new Button[5];
    buttons[0] = new Button(new PVector(10, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Laser", 32, "laser");
    buttons[1] = new Button(new PVector(160, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Shield", 32, "shield");
    buttons[2] = new Button(new PVector(310, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Crew", 32, "crew");
    buttons[3] = new Button(new PVector(460, 10), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(130, 80))}, "Rocket", 32, "rocket");
    buttons[4] = new Button(new PVector(width-100, height-90), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(80, 80))}, "Next", 32, "Go");

    menuButtons = new Button[2];
    menuButtons[0] = new Button(new PVector(width/2 - 180, height/2-100), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(360, 160))}, "Play", 100, "play");
    menuButtons[1] = new Button(new PVector(width/2 - 180, height/2+100), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(360, 130))}, "Guide", 100, "guide");

    tutorialNext = new Button(new PVector(width - 125, height - 125), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {new Rect(new PVector(0, 0), new PVector(120, 120))}, "->", 100, "nextPage");

    ships[0] = new Ship(new PVector(300, 300), new PVector(0, 0), new PVector(2, 2), new PVector(0, 0), 1);
    ships[1] = new Ship(new PVector(300, 300), new PVector(0, 0), new PVector(2, 2), new PVector(0, 0), 1);
    ships[0].setEnemyShip(ships[1]);
    ships[1].setEnemyShip(ships[0]);

    world = new World(3, 1);

    gameState = "menu";
    nextGameState = gameState;
    selected="";

    gameFont = createFont("INVASION2000.TTF", 100);
    textFont(gameFont);
    firstMut=true;
    ship = ships[0];
  }

  int page = 0;
  int finalPageIndex = 3;

  void buttonPressedOnce(String buttonText) { //sends signal when first pressed
    println("Button " + buttonText + " was pressed.");
    if (gameState.equals("editor")) {
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
          ships[0].setPosition(new PVector(100, 300));
          ships[1].setPosition(new PVector(500, 300));
          nextGameState = "game";
        }
      }
    } else if (gameState.equals("menu")) {
      if (buttonText.equals("play")) {
        nextGameState = "editor";
      } else if (buttonText.equals("guide")) {
        nextGameState = "tutorial";
      }
    } else if (gameState.equals("tutorial")) {
      if (buttonText.equals("nextPage")) {
        page++;
        if (page > finalPageIndex) {
          nextGameState = "menu";
          page = 0;
        }
      }
    } else if (gameState.equals("animation")) {
      if (buttonText.equals("next")) {
        nextGameState = "mutating";
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
      } else if (selected.equals("rocket")) {
        newComp = new RocketShooter(ship, new PVector(x, y).sub(ship.getPosition()), new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
          new Rect(new PVector(0, 0), new PVector(40, 20))
          }, 3, 2, 1.0);
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
      if (mousePressed && tangent && placeable) {
        if (selected.equals("laser")&&money-25>=0) {
          money-=25;
        } else if (selected.equals("shield")&&money-20>=0) {
          money-=20;
        } else if (selected.equals("crew")&&money-10>=0) {
          money-=10;
        } else if (selected.equals("rocket") &&money-10>= 0) {
          money -=10;
        }
        newComp=null;
        selected="";
      }
    }
    if (ship.getComponents().get(ship.getComponents().size()-1) == newComp && ((!mouse.collides(gridBounds)) || !placeable)) {
      ship.getComponents().remove(ship.getComponents().size()-1);
      newComp = null;
    }
    fill(0, 0, 0);
    return false;
  }
  boolean mutationAdd(Rect gridBounds) {
    float x = round(mouseX/gridSize)*gridSize;
    float y = round(mouseY/gridSize)*gridSize;
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
      } else if (selected.equals("rocket")) {
        newComp = new RocketShooter(ship, new PVector(x,y).sub(ship.getPosition()), new PVector(0, 0), new PVector(0,0), new PVector (0,0), new Rect[] {
          new Rect(new PVector(0,0), new PVector(40, 20))}, 3, 2, 1.0
          );
      }
      if (newComp != null && mouse.collides(gridBounds)) {
        //println("yes");
        ship.addComponent(newComp);
      } else {
        //println("no");
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
      //println("yes");
      boolean tangent = false;
      println(comp + ", " + newComp);
      for (Component c : comp) {
        if (c != newComp) {
          //println(gridBounds.contains(new Rect(newComp.getHitBoxes()[0], ship.getPosition().add(newComp.getPosition()))));

          Rect cTranslated = new Rect(c.getHitBoxes()[0], ship.getPosition().add(c.getPosition()));
          Rect newTranslated = new Rect(newComp.getHitBoxes()[0], ship.getPosition().add(newComp.getPosition()));

          //println(cTranslated.getIntersectPoints(newTranslated));
          if (cTranslated.getIntersectPoints(newTranslated) >= 2) {
            tangent = true;
          }

          if (cTranslated.collides(newTranslated) || !gridBounds.contains(newTranslated)) {
            placeable = false;
          }
        }
      }
      if (mousePressed && tangent&&placeable) {
        newComp = null;
        selected = "";
      }
    }
    if (ship.getComponents().get(ship.getComponents().size()-1) == newComp && ((!mouse.collides(gridBounds)) || !placeable)) {
      ship.getComponents().remove(ship.getComponents().size()-1);
      newComp = null;
    }
    fill(0, 0, 0);
    return false;
  }

  Ship[] tempShips = new Ship[3];
  boolean otherFirstMut = true;

  public void mutations(float secsRun, int shipnum, Rect mice) {
    Rect choice1= new Rect(new PVector(-1, 299.0), new PVector( 221.0, 521.0));
    Rect choice2= new Rect(new PVector(220.0, 280.0), new PVector( 480.0, 540.0));
    Rect choice3= new Rect(new PVector(440.0, 280.0), new PVector( 720.0, 540.0));

    if (mice.collides(choice1)) {
      fill(100, 200, 200);
      rect(0, 300, 220, 220);
    } else if (mice.collides(choice2)) {
      fill(100, 200, 200);
      rect(240, 300, 220, 220);
    } else if (mice.collides(choice3)) {
      fill(100, 200, 200);
      rect(480, 300, 220, 220);
    }
    fill(255, 255, 255);
    drawGrid(0, 300, 220, 520);
    drawGrid(240, 300, 460, 520);
    drawGrid(480, 300, 700, 520);

    if (otherFirstMut) {
      otherFirstMut = false;
      for (int i = 0; i < tempShips.length; i++) {
        tempShips[i] = null;
      }
    }

    for (int i = 0; i < tempShips.length; i++) {
      if (tempShips[i] == null) {
        tempShips[i] = new Ship(ships[shipnum]);
      }
    }

    for (int i = 0; i < tempShips.length; i++) {
      Ship copy = tempShips[i];
      copy.setPosition(new PVector(60.0 + i * 240, 360.0));
      ship=copy;
      if (firstMut) {
        firstMut=false;
        //reset to true after selected
        shape=(int)random(0, 3); //use arrays
      }
      if (shape==0) {
        selected="laser";
      } else if (shape==1) {
        selected="crew";
      } else {
        selected="shield";
      }
      if (i == 0) {
        mutationAdd(choice1); //use arrays
      }
      copy.display(secsRun, dt);
    }
  }
  public void update(float secsRunning, float dt) {

    mouse = new Rect(new PVector(mouseX, mouseY), new PVector(mouseX, mouseY));
    if (gameState.equals("menu")) {
      color col1 = color(255, 255, 240);
      color col2 = color(240, 255, 255);
      background(lerpColor(col1, col2, sin(secsRunning * 2.5f)));

      textAlign(CENTER);

      fill(0);
      textSize(72);
      text("Space Crafting", width/2, 80);

      fill(127);
      textSize(32);
      text("Make your own spaceship and battle\nit against a friend's!\nWatch as it changes over time.", width/2, 130);

      for (Button b : menuButtons) {
        b.update(secsRunning, dt);
      }

      for (Button b : menuButtons) {
        b.display(secsRunning, dt);
      }

      textSize(30);
      fill(220, 40, 40);
      text("Made by Greg Zborovsky, George Zhou,\nAmanda Zheng, Vivian Huynh", width/2, height - 60);

      textAlign(CORNER);
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
      if (!ships[0].isDead() && !ships[1].isDead() && secsRunning <= 75) {
        world.update(secsRunning, dt);
        world.display(secsRunning, dt);
        for (Ship ship : ships) {
          ship.update(secsRunning, dt);
        }
        for (Ship ship : ships) {
          ship.display(secsRunning, dt);
        }
      } else {
        println(numLevels);
        if (numLevels >= 9) {
          nextGameState = "end";
        } else {
          nextGameState = "mutating";
        }
        numLevels++;
      }
    } else if (gameState.equals("mutating")) {
      background(255);
      textSize(50);
      fill(255, 200, 0);
      text("Player 1 Won!", 175, 50);
      textSize(30);
      text("5-4", 325, 100);
      fill(10, 10, 200);
      text("Player 1 Mutations:", 20, 200);
      mutations(secsRunning, 0, mouse);
    } else if (gameState.equals("tutorial")) {
      color col1 = color(255, 255, 240);
      color col2 = color(240, 255, 255);
      background(lerpColor(col1, col2, sin(secsRunning * 2.5f)));

      textAlign(CENTER);

      fill(0);
      textSize(72);
      text("Space Crafting", width/2, 80);

      String header = "";
      String textContent ="";

      if (page == 0) {
        header = "Spaceship Creation";
        textContent = "Use the editor to place\ndown different types of components\nusing the money you have.\nBe strategic!";
      } else if (page == 1) {
        header = "Game Field";
        textContent = "This is the actual game field.\nWatch as your ship and the enemy\nship battle one another on the board.";
      } else if (page == 2) {
        header = "Mutation";
        textContent = "After every round, both\nspaceships will mutate into something\nslightly different to make\nthe game more exciting!";
      } else if (page == 3) {
        header = "Final Notes";
        textContent = "Whoever won the most rounds\nis the winner. Remember,\n HAVE FUN!";
      } else {
        header = "Default Page";
        textContent = "You've hit a\ndefault page!";
      }

      fill(50);
      textSize(58);
      text(header, width/2, 140);

      //Maybe add an image here?

      fill(100);
      textSize(32);
      text(textContent, width/2, height/2 - 150);

      textAlign(CORNER);

      fill(0);
      textSize(48);
      text("Page #" + (page + 1), 10, height-20);

      tutorialNext.update(secsRunning, dt);
      tutorialNext.display(secsRunning, dt);

      textAlign(CORNER);
    } else if (gameState.equals("end")) {
      background(255);
      textAlign(CENTER);
      if (ships[0].getWins() > ships[1].getWins()) {
        fill(127);
        textSize(50);
        text("PLAYER ONE WON!!!", width/2, 130);
      } else if (ships[0].getWins() < ships[1].getWins()) {
        fill(127);
        textSize(50);
        text("PLAYER TWO WON!!!", width/2, 130);
      } else {
        fill(127);
        textSize(50);
        text("GAME ENDED IN DRAW", width/2, 130);
      }
    } else {
      background(255);
      fill(255);
      text("We messed up lmao", width/2, height/2);
    }
    gameState = nextGameState;
  }
}
