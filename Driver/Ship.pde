class Ship extends GameObject{
  List<Component> components;
  float health;
  String baseMat; //material
  int crew; //num of crew members
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration) {
    super(position, velocity, maxVelocity, acceleration);
    components = new ArrayList<Component>();
    health = 0;
  }
  
  public void setHealth(float nH) {
    health = nH;
  }
  public float getHealth() {
    return health;
  }
  public void addHealth(float dH) {
    health += dH;
  }
  
  public String getMat() {
    return baseMat;
  }
  public void setMat(String nMat) {
    baseMat = nMat;
  }
  
  public boolean isDead() {
    if (health <= 0) {
      return true;
    }
    return false;
  }
  
  public int numCrewMembers() {
    return crew;
  }
  public void addHealth() {
    
  }
  
}
