abstract class GameObject {
  private PVector position;
  private PVector velocity;
  private PVector maxVelocity;
  private PVector acceleration;
  private Rect[] hitboxes;

  public GameObject(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitboxes) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.maxVelocity = maxVelocity.copy();
    this.acceleration = acceleration.copy();

    this.hitboxes = new Rect[hitboxes.length];
    for (int i = 0; i < hitboxes.length; i++) {
      this.hitboxes[i] = new Rect(hitboxes[i]);
    }
  }
  
  public abstract void update(float secsPassed, float dt);
  public abstract void display(float secsPassed, float dt);
  
  public Rect[] getHitBoxes() {
    return hitboxes;
  }
  
  public PVector getPosition() {
    return position.copy();
  }

  public void setPosition(PVector p) {
    position = p.copy();
  }

  public PVector getVelocity() {
    return velocity.copy();
  }

  public void setVelocity(PVector v) {
    velocity = v.copy();
  }

  public PVector getAcceleration() {
    return acceleration.copy();
  }

  public void setAcceleration(PVector a) {
    acceleration = a.copy();
  }
  
  public void applyAcceleration() {
    velocity.add(acceleration);
    
    velocity.x = constrain(velocity.x, -maxVelocity.x, maxVelocity.x);
    velocity.y = constrain(velocity.y, -maxVelocity.y, maxVelocity.y);
  }
  
  public void applyVelocity() {
    position.add(velocity);
  }
  
  public void setMaxVelocity(PVector vel) {
    maxVelocity = vel.copy();
  }
  
  public PVector getMaxVelocity() {
    return maxVelocity.copy();
  }
}
