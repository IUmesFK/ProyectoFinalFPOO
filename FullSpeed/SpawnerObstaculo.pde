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
    if(tiempoActual - ultimoTmp > 1500){
      int tipoObstaculo = int(random(1, 3));
      switch(tipoObstaculo){
        case 1: // dibujar cono
          obstaculos.add(new Cono(new PVector(random(width/2 - 80, width/2 + 80), -50), new PVector(0, 500*Time.getDeltaTime(frameRate))));
          break;
        case 2: // dibujar roca
          obstaculos.add(new Roca(new PVector(random(width/2 - 80, width/2 + 80), -50), new PVector(0, 500*Time.getDeltaTime(frameRate))));
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
        }
    }
  }

  public void vaciarLista(){
    obstaculos.clear();
  }
  
  public void validarColision(Jugador jugador){
    
    for(int i = 0; i < obstaculos.size(); i++){
      Obstaculo obs = obstaculos.get(i);
      boolean isCollide = obs.getCollider().validarColision(jugador.getCollider());
      if(isCollide){
        jugador.debilitar();
        obstaculos.remove(i);
      }
    }
  }
  
}
