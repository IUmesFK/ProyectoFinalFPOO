public class Roca extends Obstaculo{
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  public Roca(PVector posicion, PVector velocidad){
    this.posicion = posicion;
    this.velocidad = velocidad;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  @Override
  public void display(){
    textura = loadImage("roca.png");
    super.display();
  }
}
