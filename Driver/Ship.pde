class Ship extends GameObject{
  List<Component> components;
  float health;
  String baseMat; //material
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float nH, String mat) {
    super(position, velocity, maxVelocity, acceleration);
    components = new ArrayList<Component>();
    health = nH;
    baseMat = mat;
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
  
}
