class Ship extends GameObject{
  private List<Component> components;
  private Ship enemyShip;
  
  public Ship(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration) {
    super(position, velocity, maxVelocity, acceleration, new Rect[0]);
    
  }
  
  public void setEnemyShip(Ship s) {
    this.enemyShip = s;
  }
  
  public Ship getEnemyShip() {
    return enemyShip;
  }
}
