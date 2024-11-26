public class Escenario {
  // Arreglo para almacenar las diferentes capas visuales
  private LayerImage[] capas;
  private PImage dodo;
  private int widthFrame;
  private int heightFrame;
  private int cantFrames;
  private int contFrames;
  private float posY;

  /**
  ----- CONSTRUCTOR -----
  */
  
  public Escenario() {
    capas = new LayerImage[7]; // El arreglo puede almacenar hasta 7 capas visuales

    // Inicialización de cada capa con diferentes imágenes y posiciones
    capas[0] = new LayerImage(new PVector(), new PVector(), "fondo.png"); 
    // Capa 0: Fondo de la escena, no tiene movimiento (velocidad = (0, 0))

    capas[1] = new LayerImage(new PVector(0, height / 2), new PVector(), "pista.png");
    // Capa 1: Imagen de pista que comienza desde la posición (0, 0)

    capas[2] = new LayerImage(new PVector(0, height / 2), new PVector(0,-10), "pista.png");
    // Capa 2: Imagen de pista, comienza al final del eje vertical (posición inicial: (0, height))

    capas[3] = new LayerImage(new PVector(0, height / 2), new PVector(0, height), "pista.png");

    capas[4] = new LayerImage(new PVector(0, height), new PVector(), "arbol.png");
    // Capa 3: Imagen de árbol que comienza desde (0, 0)

    capas[5] = new LayerImage(new PVector(0, height), new PVector(0, height), "arbol.png");
    // Capa 4: Imagen de árbol que comienza al final del eje vertical

    capas[6] = new LayerImage(new PVector(0, height), new PVector(0, height), "arbol.png");
    // Capa 5: Otra imagen de árbol que también comienza desde el final del eje vertical
    
    dodo = loadImage("dodoo.png");
    contFrames = 0;
    widthFrame = 48;
    heightFrame = 64;
    posY = 0;
  }


   // Método para mostrar todas las capas de la escena y actualizar sus posiciones
   
  public void display(float deltaTime) {
    // Itera sobre cada capa en el arreglo
    for (LayerImage layer : capas) {
      layer.display(); // Dibuja la capa en la pantalla
      layer.updatePosition(deltaTime); // Actualiza la posición de la capa según su velocidad
    }
  }
  
  public void mostrarDodo(){
    int xFrame = 0;
    if(contFrames <= cantFrames){
    image(dodo.get(xFrame, 0, widthFrame, heightFrame), 100, posY, 48, 64);
    xFrame += widthFrame;
    contFrames++;
    posY += 2;
    if(posY > height){
    posY = -heightFrame;
    }
    if(contFrames >= cantFrames){
      contFrames = 0;
    }
    }
  }
  
}
