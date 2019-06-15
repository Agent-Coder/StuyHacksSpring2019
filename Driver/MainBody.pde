public class MainBody extends Component{
  public MainBody(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration, float nH, float coolDown) {
    super(position, velocity, maxVelocity, acceleration, nH, coolDown);
  }
  
  public void use();
}
