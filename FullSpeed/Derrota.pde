/**
 * Clase Derrota
 * Representa la pantalla de derrota que se muestra cuando el jugador pierde.
 */
public class Derrota{
  private PImage imagen; // Imagen que representa la pantalla de derrota

 /**
  ----- CONSTRUCTOR -----
  */
  
  public Derrota() {
    imagen = loadImage("Derrota.png"); // Cargar la imagen de derrota
  }

/**
  ----- MÉTODOS -----
  */
  
  public void mostrar() {
    // Dibuja la imagen de derrota en el centro de la pantalla, ajustando su tamaño a todo el ancho y alto
    image(imagen, width / 2, height / 2, width, height);
  }
}
