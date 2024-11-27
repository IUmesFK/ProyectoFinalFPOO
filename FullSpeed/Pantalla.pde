class Pantalla{

  private PImage imagen;
  private String ruta;
  
  Pantalla(){
    
  }
  
  /**
  ----- SETTERS Y GETTERS -----
  */
  
  public void setRuta(String ruta){
    this.ruta = ruta;
  }
  
  /**
  ----- MÉTODOS -----
  */
  
  public void display(){
    imagen = loadImage(ruta);
    imageMode(CENTER);
    image(imagen, width/2, height/2, width, height);
  }
  
}
