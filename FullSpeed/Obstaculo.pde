class Obstaculo extends GameObject{
  
  protected PVector velocidad;
  
  Obstaculo(){
  
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    image(textura, this.posicion.x, this.posicion.y, 30, 30);
  }
  
  @Override
  public void mover(){
    this.posicion.y += this.velocidad.y;
  }
  
}
