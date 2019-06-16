public class MainBody extends Component {
  int baseMat;
  float baseHealth;
  float baseCoolDown;

  public Component copy() {
    MainBody temp = new MainBody(getShip(), getPosition(), getVelocity(), getMaxVelocity(), getAcceleration(), getHitBoxes(), getHealth(), getCoolDown(), baseMat);
    return temp;
  }

  public MainBody(Ship ship, PVector p, PVector v, PVector mV, PVector a, Rect[] hBoxes, float nH, float cD, int mat) {
    super(ship, p, v, mV, a, hBoxes, nH, cD);
    baseMat = mat; //it can be 0, 1, 2, 3, 4
  }

  public void use() {
  }

  public void mutate(float mutationFactor) { //mF is between 0 and 1, inclusive of 0, exclusive of 1
    baseMat += (int)((abs(mutationFactor) - 1/3) * 3);
    if (baseMat > 4) {
      baseMat = 4;
    }
    if (baseMat < 0) {
      baseMat = 0;
    }
  }

  public void update(float secsPassed, float dt) {
  }

  public void reset() {
    setHealth(baseHealth);
    setCoolDown(baseCoolDown);
  }

  public void display(float secsPassed, float dt) {
    rectMode(CORNER);
    if (baseMat == 0) {
      fill(67, 75, 77);
    } else if (baseMat == 1) {
      fill(67, 70, 75);
    } else if (baseMat == 2) {
      fill(106, 105, 111);
    } else if (baseMat == 3) {
      fill(198, 200, 201);
    } else {
      fill(102, 78, 174);
    }
    rect(getHitBoxes()[0].x(), getHitBoxes()[0].y(), getHitBoxes()[0].width(), getHitBoxes()[0].height());
  }
}
