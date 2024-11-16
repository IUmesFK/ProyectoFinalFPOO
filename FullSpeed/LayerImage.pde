/**
 * Clase LayerImage
 * Representa una capa visual que puede moverse en la pantalla con una velocidad y posición específicas.
 * Las capas están asociadas con imágenes que se cargan desde un archivo.
 */
public class LayerImage {
  private PVector velocidad; // define la velocidad de movimiento de la capa
  private PVector posicion;  // define la posición actual de la capa
  private PImage imagen;     // Imagen asociada con la capa

 /**
  ----- CONSTRUCTOR -----
  */
  
  public LayerImage(PVector velocidad, PVector posicion, String pathImage) {
    this.velocidad = velocidad; // Asignar velocidad
    this.posicion = posicion;   // Asignar posición
    this.imagen = loadImage(pathImage); // Cargar la imagen desde la ruta especificada
    

    this.imagen.resize(width + 4, height + 4);
    
  }

  /**
  ----- MÉTODOS -----
  */
  
  public void display() {
    imageMode(CORNER); // Dibuja la imagen desde la esquina superior izquierda
    image(this.imagen, this.posicion.x, this.posicion.y); // Mostrar la imagen en la posición actual
  }

    //Método para actualizar la posición de la capa
  
  public void updatePosition(float deltaTime) {
    //println(this.posicion.x); // Mostrar la posición actual de la capa en la consola 
    
    // Actualizar la posición en el eje Y, desplazándola hacia arriba según la velocidad y deltaTime
    this.posicion.y += (this.velocidad.y * deltaTime);
    
    // Si la capa sale del límite superior de la pantalla, reubicarla al límite inferior
    if (this.posicion.y > height) {
      this.posicion.y = -this.imagen.height;
    }
  }
}
