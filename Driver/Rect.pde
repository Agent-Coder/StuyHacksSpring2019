class Rect {
  private PVector topLeft;
  private PVector botRight;
  
  public Rect(PVector topLeft, PVector botRight) {
    this.topLeft = topLeft.copy();
    this.botRight = botRight.copy();
  }
  
  public Rect(Rect r) {
    this.topLeft = r.topLeft.copy();
    this.botRight = r.botRight.copy();
  }
  
  public float x() {
    return topLeft.x;
  }
  
  public float y() {
    return topLeft.y;
  }
  
  public float width() {
    return botRight.x - topLeft.x;
  }
  
  public float height() {
    return topLeft.y - botRight.y;
  }
  
  public boolean collides(Rect r) {
    Rect r1 = this;
    Rect r2 = r;
    
    return r1.x() < r2.x() + r2.width() && r1.x() + r1.width() > r2.x() && r1.y() < r2.y() + r2.height() && r1.y() + r1.height() > r2.y();
  }
}
