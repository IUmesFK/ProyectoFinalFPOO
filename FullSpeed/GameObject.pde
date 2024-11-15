abstract class GameObject{
  
  protected PImage textura;
  protected PVector posicion;
  
  /**
  ----- SETTERS Y GETTERS -----
  */
  
  public void setPosicion(PVector posicion){
    this.posicion = posicion;
  }
  
  public PVector getPosicion(){
    return this.posicion;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void mover(){
  
  }
  
}
