class Shield extends Component{

  public Shield(PVector position, PVector velocity, PVector maxVelocity, PVector acceleration){
    super(position, velocity, maxVelocity,acceleration,(int)random(0,5) * 5 + 10,0); 
  }
  public use{}
}
