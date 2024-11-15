class Roca extends Obstaculo{
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  Roca(PVector posicion, PVector velocidad){
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
