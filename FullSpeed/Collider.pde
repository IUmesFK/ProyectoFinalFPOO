class Collider{

  private int ancho;
  private int alto;
  private PVector posicion;
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  Collider(){
    
  }
  
  /**
  ----- SETTERS Y GETTERS -----
  */
  
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
  
  public void setPosicion(PVector posicion){
    this.posicion = posicion;
  }
  
  public PVector getPosicion(){
    return this.posicion;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    noFill();
    strokeWeight(0);
    rectMode(CENTER);
    rect(this.posicion.x, this.posicion.y, this.ancho, this.alto);
  }
  
  
  public boolean validarColision(Collider otroCollider){
    
    boolean isCollide = true;
    
      if(this.posicion.x > otroCollider.getPosicion().x + otroCollider.getAncho()){
        isCollide = false;
      }
      if(this.posicion.x + this.ancho < otroCollider.getPosicion().x){
        isCollide = false;
      }
      if(this.posicion.y > otroCollider.getPosicion().y + otroCollider.getAlto()){
        isCollide = false;
      }
      if(this.posicion.y + this.alto < otroCollider.getPosicion().y){
        isCollide = false;
      }
      
    return isCollide;
    
  }
  
  
}
