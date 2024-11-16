class SpawnerObstaculo{
  
  private ArrayList<Obstaculo> obstaculos;
  private int ultimoTmp;
  
  SpawnerObstaculo(){
    obstaculos = new ArrayList<Obstaculo>();
  }
  
    public void generarObstaculo(){
    int tiempoActual = millis(); 
    if(tiempoActual - ultimoTmp > 2000){
      int tipoObstaculo = int(random(1, 3));
      switch(tipoObstaculo){
        case 1: // dibujar cono
          obstaculos.add(new Cono(new PVector(random(width/2 - 80, width/2 + 80), 0), new PVector(0, 150*Time.getDeltaTime(frameRate))));
          break;
        case 2: // dibujar roca
          obstaculos.add(new Roca(new PVector(random(width/2 - 80, width/2 + 80), 0), new PVector(0, 150*Time.getDeltaTime(frameRate))));
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

  public void verificarColisionObstaculoJugador(Jugador jugador){
    for(int i = 0; i < obstaculos.size(); i++){
      Obstaculo obs = obstaculos.get(i);
      if(PVector.dist(jugador.getPosicion(), obs.getPosicion()) < 25){
        obstaculos.remove(i);
      }
    }
  }
  
}
