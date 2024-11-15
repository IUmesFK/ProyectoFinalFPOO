class Cono extends Obstaculo{
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  Cono(PVector posicion, PVector velocidad){
    this.posicion = posicion;
    this.velocidad = velocidad;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  @Override
  
  public void display(){
    textura = loadImage("cono.png");
    super.display();
  }
  
}
