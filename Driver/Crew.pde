class Crew extends Component {
  private int crew;
  private int baseCrew;
  public Crew(Ship ship, PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, Rect[] hitBoxes) {
    super(ship, position, velocity, maxVelocity, acceleration, hitBoxes, float((int)random(0, 5) * 5 + 10), 5.0);
    crew=(int)getBaseHealth();
    baseCrew=(crew);
    
  }
  public float getCrew(){
    return baseCrew;
  }
  public float getCurrentCrew(){
    return crew;
  }
  public void use(){   
  };
  public void mutate(float mutationFactor) {
    baseCrew+=(int)(mutationFactor*10);
    setBaseHealth(crew);
    setBaseCoolDown(crew);
  }
  //health is gonna be one third of mutation factor
  public void update(float secsPassed, float dt){
    addCoolDown(-dt);
    if (getCoolDown() <= 0) {
      setCoolDown(getBaseCoolDown());
      List<Component> comp=getShip().getComponents();
      for (Component c : comp){
        c.setHealth(getHealth()+crew);
      } 
    }
  }
  void display(float secsPassed, float dt) {
    fill(0, 255, 0);
    rect(getPosition().x, getPosition().y, 20, 20);
  }
  public void reset(){
    setHealth(getBaseHealth());
    crew=baseCrew;
  };


}
