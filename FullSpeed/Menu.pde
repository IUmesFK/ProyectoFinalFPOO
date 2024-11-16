/**
 * Clase Menu
 * Representa el menú principal del juego.
 */

public class Menu{
  private PImage imagen; // Imagen que representa el menú principal

  /**
  ----- CONSTRUCTOR -----
  */
  
  public Menu() {
    imagen = loadImage("Menu.png"); // Cargar la imagen del menú
  }

  /**
  ----- MÉTODOS -----
  */

  public void mostrar() {
    image(imagen, 0, 0, width, height); // Dibuja la imagen del menú en la posición (0, 0)
  }
}
