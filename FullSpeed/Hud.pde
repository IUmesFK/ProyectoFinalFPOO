class Hud{
  
  private int tiempoInicio; 
  private int tiempoTranscurrido;
  private int tiempoRestante;
  private int cuentaRegresiva;

  /**
  ----- CONSTRUCTOR -----
  */
  
  Hud(){
   this.tiempoInicio = millis();  
    this.cuentaRegresiva = 60; 
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
  
   public void reiniciarTiempo() {
    this.tiempoInicio = millis();  // Reinicia el tiempo al momento actual
  }
  
  public void mostrarTiempo(){
    this.tiempoTranscurrido = (millis() -this.tiempoInicio)/ 1000;
    this.tiempoRestante = this.cuentaRegresiva - this.tiempoTranscurrido;
    
    fill(0);
    textSize(20);
    textAlign(LEFT, TOP);
    
    if(this.tiempoRestante > 1){
      text("Tiempo Restante: " + this.tiempoRestante + " segundos.", 10, 10);
    }else if(this.tiempoRestante == 1){
      text("Tiempo Restante: " + this.tiempoRestante + " segundo.", 10, 10);
    }
  }
  
  public void mostrarPuntaje(Jugador jugador){
    fill(0);
    textSize(30);
    textAlign(RIGHT, TOP);
    text("Puntaje: " + jugador.getPuntaje(), width - 20, 10);
  }
  
  public void mostrarDurabilidad(Jugador jugador){
    fill(0);
    textSize(30);
    textAlign(LEFT, BOTTOM);
    text("Durabilidad: " + jugador.getDurabilidad(), 20, height - 20);
  }
  
  
}
