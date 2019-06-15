class Shield extends Component {
  private float defense;
  public Shield(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, float((int)random(0, 5) * 5 + 10), 0.0);
    defense=float((int)random(0, 5) * 5 + 10);
    
    
  }
  public float getDefense(){
    return defense;
  }
  public void use(){   
  };
  public void mutate(float mutationFactor) {
    defense=mutationFactor;
    setBaseHealth(mutationFactor/3);
  }
  //health is gonna be one third of mutation factor
  public void update(float secsPassed, float dt){
  }


}
