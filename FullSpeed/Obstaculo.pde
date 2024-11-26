public class Obstaculo extends GameObject{
  
  protected PVector velocidad;
  protected Collider collider;
  /**
  ----- CONSTRUCTOR -----
  */
  
  public Obstaculo(){
    collider = new Collider();
    collider.setAlto(40);
    collider.setAncho(40);
  }
  
  /**
  ----- SETTERS Y GETTERS -----
  */

  public Collider getCollider(){
    return this.collider;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    imageMode(CENTER);
    image(textura, this.posicion.x, this.posicion.y, 40, 40);
    collider.setPosicion(this.posicion);
    collider.display();
  }
  
  @Override
  public void mover(){
    this.posicion.y += this.velocidad.y;
  }
  
}
