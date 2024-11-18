class Hud{
  
  private int tiempoTranscurrido;
  private int tiempoRestante;
  private int cuentaRegresiva;

  /**
  ----- CONSTRUCTOR -----
  */
  
  Hud(){
    
  }
  
  /**
  ----- SETTERS Y GETTERS -----
  */
  
  public int getTiempoRestante(){
    return this.tiempoRestante;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void mostrarTiempo(){
    this.tiempoTranscurrido = millis() / 1000;
    this.cuentaRegresiva = 60;
    this.tiempoRestante = cuentaRegresiva - tiempoTranscurrido;
    
    fill(255);
    textSize(20);
    textAlign(LEFT, TOP);
    
    if(this.tiempoRestante > 1){
      text("Tiempo Restante: " + this.tiempoRestante + " segundos.", 10, 10);
    }else if(this.tiempoRestante == 1){
      text("Tiempo Restante: " + this.tiempoRestante + " segundo.", 10, 10);
    }
  }
  
  public void mostrarPuntaje(Jugador jugador){
    fill(255);
    textSize(20);
    textAlign(RIGHT, TOP);
    text("Puntaje: " + jugador.getPuntaje(), width - 20, 10);
  }
  
}
