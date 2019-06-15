public Rect mouse;

public class Button extends GameObject {
  private String buttonName;
  private String text;
  private float tSize;

  private color tintColor = color(255, 255, 255);
  
  private boolean lastPressed;

  public Button(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitboxes, String text, float tSize, String buttonName) {
    super(position, velocity, maxVelocity, acceleration, hitboxes);
    this.buttonName = buttonName;
    this.text = text;
    this.tSize = tSize;
  }

  public void update(float secs, float dt) {
    mouse = new Rect(new PVector(mouseX, mouseY), new PVector(mouseX, mouseY));
    if (mouseOver()) {
      if (mousePressed) {
        tintColor = color(195, 195, 195);
        g.buttonPressed(buttonName);
        if (!lastPressed) {
          g.buttonPressedOnce(buttonName);
        }
        lastPressed = true;
      } else {
        lastPressed = false;
        tintColor = color(225, 225, 225);
      }
    } else {
      tintColor = color(255, 255, 255);
    }
  }

  public boolean mouseOver() {
    return mouse.collides(new Rect(getHitBoxes()[0], getPosition()));
  }

  public void display(float secs, float dt) {
    //tint(tintColor);
    
    fill(tintColor);

    pushMatrix();
    translate(getPosition().x, getPosition().y);
    
    rect(0, 0, getHitBoxes()[0].width(), getHitBoxes()[0].height(), 10);
    
    textAlign(CENTER);
    textSize(tSize);
    fill(0);
    text(text, getHitBoxes()[0].width()/2, getHitBoxes()[0].height()/2);
    //text(text, image.width/2, image.height/2 + 24);
    popMatrix();

    //tint(color(255, 255, 255));
  }
}
