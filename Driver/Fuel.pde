class Fuel extends GameObject {
  private float fuel;
  public Fuel(PVector position) {
    super(position, new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
      new Rect(new PVector(0, 10), new PVector(30, 20)),
      new Rect(new PVector(10, 0), new PVector(20, 30))
    });
    fuel = random(.1) + .1;
  }
  
  public float getFuelLevel() {
    return fuel;
  }
  
  public void update(float secs, float dt) {
    
  }
  
  public void display(float secs, float dt) {
    int num = 127;
    for (Rect hitbox : getHitBoxes()) {
      fill(num);
      rect(getPosition().x + hitbox.x(), getPosition().y + hitbox.y(), hitbox.width(), hitbox.height(), 5);
      num += 25;
    }
  }
  
  public Fuel copy() {
    return new Fuel(getPosition());
  }
}
