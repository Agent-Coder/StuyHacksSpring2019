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
    mutationFactor=abs(mutationFactor);
    defense=(1+mutationFactor)*defense;
    setBaseHealth(getBaseHealth()+mutationFactor/3);
  }
  //health is gonna be one third of mutation factor
  public void update(float secsPassed, float dt){
  }
  public void reset(){
    setHealth(getBaseHealth());
  };

 void display(float secsPassed, float dt) {
    fill(255, 255, 0);
    rect(getPosition().x, getPosition().y, 40, 40);
 }
}
