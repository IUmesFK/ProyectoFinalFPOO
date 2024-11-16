public class Obstaculo extends GameObject{
  
  protected PVector velocidad;
  /**
  ----- CONSTRUCTOR -----
  */
  
  public Obstaculo(){
  
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    image(textura, this.posicion.x, this.posicion.y, 40, 40);
  }
  
  @Override
  public void mover(){
    this.posicion.y += this.velocidad.y;
  }
  
}
