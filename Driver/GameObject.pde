abstract class GameObject {
  private PVector position;
  private PVector velocity;
  private PVector maxVelocity;
  private PVector acceleration;

  public GameObject(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.maxVelocity = maxVelocity.copy();
    this.acceleration = acceleration.copy();
  }
}
