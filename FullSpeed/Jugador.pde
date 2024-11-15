class Jugador extends GameObject implements IVisualizable{
  
  private PVector velocidad;
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  Jugador(PVector posicion, PVector velocidad){
    this.posicion = posicion;
    this.velocidad = velocidad;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    
  }
  
  public void mover(int direccion){
    
  }
}
