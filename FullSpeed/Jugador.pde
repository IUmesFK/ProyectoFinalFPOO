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
    imageMode(CENTER);
    textura = loadImage("auto1.png");
    image(textura, this.posicion.x, this.posicion.y, 40, 40);
  }
  
  public void mover(int direccion){
    switch(direccion){
      case 1: // Se mueve hacia arriba
        this.posicion.y -= this.velocidad.y;
        break;
      case 2: // Se mueve hacia abajo
        this.posicion.y += this.velocidad.y;
        break;
      case 3: // Se mueve hacia la izquierda
        this.posicion.x -= this.velocidad.x;
        break;
      case 4: // Se mueve hacia la derecha
        this.posicion.x += this.velocidad.x;
        break;
    }
  }
}
