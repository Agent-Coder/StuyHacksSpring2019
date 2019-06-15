class Ship extends GameObject{
  private List<Component> components;
  private Ship enemyShip;
  private float health;
  private String baseMat;
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float nH, String nMat) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
    health = nH;
    baseMat = nMat;
    components = new ArrayList<Component>();
  }
  
  public void setEnemyShip(Ship s) {
    this.enemyShip = s;
  }
  
  public Ship getEnemyShip() {
    return enemyShip;
  }
  
  public void updateHealth() {
    float nH = 0;
    for (int i = 0; i < components.size(); i++) {
      nH += components.get(i).getHealth();
    }
    health = nH;
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
}
