class Point extends GameObject {
  private float points;
  public Point(PVector position) {
    super(position, new PVector(0, 0), new PVector(0, 0), new PVector(0, 0), new Rect[] {
      new Rect(new PVector(0, 10), new PVector(30, 20)),
      new Rect(new PVector(10, 0), new PVector(20, 30))
    });
    points = random(.1) + .1;
  }
  
  public float getPointLevel() {
    return points;
  }
  
  public void update(float secs, float dt) {
    
  }
  
  public void display(float secs, float dt) {
    int num = 200;
    for (Rect hitbox : getHitBoxes()) {
      fill(0, num, 0);
      rect(getPosition().x + hitbox.x(), getPosition().y + hitbox.y(), hitbox.width(), hitbox.height(), 5);
      num += 25;
    }
  }
  
  public Point copy() {
    return new Point(getPosition());
  }
}
