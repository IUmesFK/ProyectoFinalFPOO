/**
 * Clase LayerImage
 * Representa una capa visual que puede moverse en la pantalla con una velocidad y posición específicas.
 * Las capas están asociadas con imágenes que se cargan desde un archivo.
 */
class LayerImage {
  private PVector velocidad; // define la velocidad de movimiento de la capa
  private PVector posicion;  // define la posición actual de la capa
  private PImage imagen;     // Imagen asociada con la capa

 
  public LayerImage(PVector velocidad, PVector posicion, String pathImage) {
    this.velocidad = velocidad; // Asignar velocidad
    this.posicion = posicion;   // Asignar posición
    this.imagen = loadImage(pathImage); // Cargar la imagen desde la ruta especificada
    
    // Verificar si la imagen se cargó correctamente
    if (this.imagen == null) {
      println("Error: No se pudo cargar la imagen desde la ruta " + pathImage);
    } else {
      // Redimensionar la imagen para que tenga un ancho ajustado al canvas y mantenga un pequeño desbordamiento
      this.imagen.resize(width + 4, height);
    }
  }

  /**
   * Método para mostrar la capa en la pantalla
   * Dibuja la imagen de la capa en su posición actual.
   */
  public void display() {
    imageMode(CORNER); // Dibuja la imagen desde la esquina superior izquierda
    image(this.imagen, this.posicion.x, this.posicion.y); // Mostrar la imagen en la posición actual
  }

    //Método para actualizar la posición de la capa
  
  public void updatePosition(float deltaTime) {
    println(this.posicion.x); // Mostrar la posición actual de la capa en la consola 
    
    // Actualizar la posición en el eje Y, desplazándola hacia arriba según la velocidad y deltaTime
    this.posicion.y -= (this.velocidad.y * deltaTime); 
    
    // Si la capa sale del límite superior de la pantalla, reubicarla al límite inferior
    if (this.posicion.y < -height) {
      this.posicion.y = height;
    }
  }
}
