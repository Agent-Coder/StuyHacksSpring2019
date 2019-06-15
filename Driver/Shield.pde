class Shield extends Component {
  public Shield(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, float((int)random(0, 5) * 5 + 10), 0.0);
  }
  public void use();
  public void mutate(float mutationFactor) {
  }
  public void update(float secsPassed, float dt);


}
