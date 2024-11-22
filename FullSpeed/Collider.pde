class Collider{

  private int ancho;
  private int alto;
  
  Collider(){
    
  }
  
  public void setAlto(int alto){
    this.alto = alto;
  }
  
  public int getAlto(){
    return this.alto;
  }
  
  public void setAncho(int ancho){
    this.ancho = ancho;
  }
  
  public int getAncho(){
    return this.ancho;
  }
  
  
  
  public void display(PVector posicion){
    noFill();
    rectMode(CENTER);
    rect(posicion.x, posicion.y, this.ancho, this.alto);
  }
  
  
}
