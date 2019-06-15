public class MainBody extends Component{
  int baseMat;
  float baseHealth;
  
  public MainBody(Ship ship, PVector p, PVector v, PVector mV, PVector a, Rect[] hBoxes, float nH, float bH, float bCD, float cD, int mat) {
    super(ship, p, v, mV, a, hBoxes, nH, cD);
    baseMat = mat;
  }
  
  public void use() {
    
  }
  
  public void mutate(float mutationFactor) { //mF is between 0 and 1, inclusive of 0, exclusive of 1
    baseMat += (int)(mutationFactor * 2.25);
    if (baseMat > 4) {
      baseMat = 4;
    }
  }
  
  public void update(float secsPassed, float dt) {
    
  }
  
  public void reset() {
    setHealth(baseHealth);
  }
}
