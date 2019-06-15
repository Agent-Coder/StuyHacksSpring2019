class Ship extends GameObject{
  List<Component> components;
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration) {
    super(position, velocity, maxVelocity, acceleration);
  }
}
