/**
 * Clase Menu
 * Representa el menú principal del juego.
 */

class Menu{
  private PImage imagen; // Imagen que representa el menú principal

  //Constructor por defecto
  public Menu() {
    imagen = loadImage("Menu.png"); // Cargar la imagen del menú
  }



  //Dibuja la imagen del menú en la pantalla, ocupando todo el tamaño de la ventana.

  public void mostrar() {
    image(imagen, 0, 0, width, height); // Dibuja la imagen del menú en la posición (0, 0)
  }
}
