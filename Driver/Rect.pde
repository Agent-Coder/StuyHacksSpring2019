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
  
  public boolean collides(Rect r) {
    return false;
  }
}
