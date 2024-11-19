public class Jugador extends GameObject implements IVisualizable{
  
  private int durabilidad; // Representa la durabilidad del jugador
  private PVector velocidad; 
  private int puntaje; // Se va a utilizar par almacenar el puntaje
  private int tiempoAnterior; // Variable que almacena el tiempo 
  
  // Variables utilizadas para la animación de la explosión
  private PImage texturaExplosion;
  private int widthFrame;
  private int heightFrame;
  private int xFrame;
  private int yFrame;
  private int cantFrames;
  private int contFrames;
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  Jugador(PVector posicion, PVector velocidad){
    this.posicion = posicion;
    this.velocidad = velocidad;
    this.durabilidad = 100;
    this.tiempoAnterior = millis();
    this.widthFrame = 64;
    this.heightFrame = 64;
    this.cantFrames = 25;
    this.contFrames = 1;
  }
  
  /**
  ----- SETTERS Y GETTERS -----
  */
  
  public void setVelocidad(PVector velocidad){
    this.velocidad = velocidad;
  }
  
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
      switch(durabilidad){
        case 100:
          textura = loadImage("auto1.png");
          break;
        case 80:
          textura = loadImage("auto2.png");
          break;
        case 60:
          textura = loadImage("auto3.png");
          break;
        case 40:
          textura = loadImage("auto4.png");
          break;
        case 20:
          textura = loadImage("auto5.png");
          break;
      }
    image(textura, this.posicion.x, this.posicion.y, 50, 100);
  }
  
  public void mover(int direccion){
    switch(direccion){
      // El jugador podra sobrepasar los limites de la pista en ningun caso
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
    this.durabilidad -= 20; // Si el jugador choca, se reducira la durabilidad del auto en 20 unidades
  }
  
  public void calcularPuntaje(){
  int tiempoActual = millis();
    if (tiempoActual - tiempoAnterior >= 1000) { // Si el tiempo actual - el tiempo anterior es menor 1000 milisegundos (1 segundo)
      puntaje += 100; // se suma 100 a puntaje
      tiempoAnterior = tiempoActual; // Se asigna el valor de tiempo actual al tiempo anterior
    }
  }
  
  public void explotarAuto(){
    texturaExplosion = loadImage("explosion.png");
    imageMode(CENTER);
      if(this.durabilidad == 0){ // Si la durabilidad es 0
        if(contFrames < cantFrames){ //Si el conteo de frames es menor a la cantidad de los mismos
          image(texturaExplosion.get(xFrame, yFrame, widthFrame, heightFrame), this.posicion.x, this.posicion.y, 100, 100);
          xFrame += widthFrame; // Es lo mismo que decir xFrame = xFrame + widthFrame
          contFrames++; // Se suma en uno el conteo de frames
        if(xFrame >= texturaExplosion.width){
          xFrame = 0;
          yFrame += heightFrame;
        }
        }
      }
    this.velocidad = new PVector(0, 0); // Al explotar el auto, se setea su velocidad en 0 en ambos ejes, provocando que no pueda moverse por tener el auto destrozado
  }
  
}
