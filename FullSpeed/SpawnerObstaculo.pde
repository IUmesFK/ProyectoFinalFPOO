public class SpawnerObstaculo{
  
  private ArrayList<Obstaculo> obstaculos;
  private int ultimoTmp;
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  public SpawnerObstaculo(){
    obstaculos = new ArrayList<Obstaculo>();
  }
  
  /**
  ----- MÉTODOS -----
  */
  
    public void generarObstaculo(){
    int tiempoActual = millis(); 
    if(tiempoActual - ultimoTmp > 2000){
      int tipoObstaculo = int(random(1, 3));
      switch(tipoObstaculo){
        case 1: // dibujar cono
          obstaculos.add(new Cono(new PVector(random(width/2 - 80, width/2 + 80), -50), new PVector(0, 200*Time.getDeltaTime(frameRate))));
          break;
        case 2: // dibujar roca
          obstaculos.add(new Roca(new PVector(random(width/2 - 80, width/2 + 80), -50), new PVector(0, 200*Time.getDeltaTime(frameRate))));
          break;
      }
      ultimoTmp = tiempoActual;
    }
  }
  
  public void mostrarObstaculos(){
    if(!obstaculos.isEmpty()){
      for(Obstaculo obs:obstaculos){
        obs.display();
        obs.mover();
      }
    }
  }
  
  public void eliminarObstaculos() {
    // Se recorre el array de forma inversa
    for (int i = obstaculos.size() - 1; i >= 0; i--) {
        Obstaculo obstaculo = obstaculos.get(i);
        if (obstaculo.getPosicion().y > height) { // Si la posicion en y del obstaculo generado es mayor al tamaño del lienzo
            obstaculos.remove(i); // Se elimina el obstaculo
            println("se elimino un objeto");
        }
    }
  }

  public void vaciarLista(){
    obstaculos.clear();
  }
  
  public boolean validarColision(Jugador jugador){
    
    boolean isCollide = true;
    
    for(int i = 0; i < obstaculos.size(); i++){
      Obstaculo obs = obstaculos.get(i);
      if(jugador.getPosicion().x > obs.getPosicion().x + obs.getCollider().getAncho()){
        isCollide = false;
      }
      if(jugador.getPosicion().x + 50 < obs.getPosicion().x){
        isCollide = false;
      }
      if(jugador.getPosicion().y > obs.getPosicion().y + obs.getCollider().getAlto()){
        isCollide = false;
      }
      if(jugador.getPosicion().y + 100 < obs.getPosicion().y){
        isCollide = false;
      }
      if(isCollide == true){
        jugador.debilitar();
        obstaculos.remove(i);
      }
    }
    
    return isCollide;
    
  }
  
}
