public class Jugador extends GameObject implements IVisualizable{
  
  private int durabilidad;
  private PVector velocidad;
  private int puntaje;
  private int tiempoAnterior;
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  Jugador(PVector posicion, PVector velocidad){
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.durabilidad = 100;
    this.tiempoAnterior = millis();
  }
  
  /**
  ----- SETTERS Y GETTERS -----
  */
  
  public void setDurabilidad(int durabilidad){
  this.durabilidad=durabilidad;
  }
  
  
  public int getDurabilidad(){
    return this.durabilidad;
  }
  public void setPuntaje(int puntaje){
  this.puntaje=puntaje;
  }
  public int getPuntaje(){
    return this.puntaje;
  }
  
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    imageMode(CENTER);
    textura = loadImage("auto1.png");
    image(textura, this.posicion.x, this.posicion.y, 50, 50);
  }
  
  public void mover(int direccion){
    switch(direccion){
      case 1: // Se mueve hacia arriba
        if(this.posicion.y > 40){
        this.posicion.y -= this.velocidad.y;
        }
        break;
      case 2: // Se mueve hacia abajo
        if(this.posicion.y < height - 40){
        this.posicion.y += this.velocidad.y;
        }
        break;
      case 3: // Se mueve hacia la izquierda
        if(this.posicion.x > width / 2 - 80){
        this.posicion.x -= this.velocidad.x;
        }
        break;
      case 4: // Se mueve hacia la derecha
        if(this.posicion.x < width / 2 + 80){
        this.posicion.x += this.velocidad.x;
        }
        break;
    }
  }
  
  public void debilitar(){
    this.durabilidad -= 10;
    println("Durabilidad: " + this.durabilidad);
  }
  
  public void calcularPuntaje(){
  int tiempoActual = millis();
    if (tiempoActual - tiempoAnterior >= 1000) { // Si el tiempo actual - el tiempo anterior es menor 1000 milisegundos (1 segundo)
      puntaje += 100; // se suma 100 a puntaje
      tiempoAnterior = tiempoActual; // Se asigna el valor de tiempo actual al tiempo anterior
    }
  }

}
