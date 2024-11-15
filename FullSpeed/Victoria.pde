/**
* Clase Victoria
 * Representa la pantalla de victoria que se muestra cuando el jugador gana.
 */

class Victoria{
  private PImage imagen; // Imagen que representa la pantalla de victoria


  // Constructor de la clase Victoria
  public Victoria() {
    imagen = loadImage("Victoria.png"); // Cargar la imagen de victoria
  }


  // Dibuja la imagen de victoria en el centro de la pantalla.

  public void mostrar() {
    // Dibuja la imagen de victoria en el centro de la pantalla, ajustando su tamaño a todo el ancho y alto
    image(imagen, width / 2, height / 2, width, height);
  }
}
