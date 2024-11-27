public class Escenario {
  // Arreglo para almacenar las diferentes capas visuales
  private LayerImage[] capas;
  private PImage[] dodo;
  private int widthFrame;
  private int heightFrame;
  private int delayActual;
  private int delay;
  private PVector[] posicion;
  private int xFrame;

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
    
    dodo = new PImage[2];
    posicion = new PVector[2];
    dodo[0] = loadImage("dodoo.png");
    dodo[1] = loadImage("dodoo.png");
    delayActual = 0;
    delay = 10;
    widthFrame = 48;
    heightFrame = 64;
    xFrame = 0;
    posicion[0] = new PVector(random(10, 300), 0);
    posicion[1] = new PVector(random(width/2 + 100, width - 10), 0);
  }
  
  /**
  ----- MÉTODOS -----
  */
   
  public void display(float deltaTime) {
    // Itera sobre cada capa en el arreglo
    for (LayerImage layer : capas) {
      layer.display(); // Dibuja la capa en la pantalla
      layer.updatePosition(deltaTime); // Actualiza la posición de la capa según su velocidad
    }
  }
  
  public void mostrarDodos(){
    
    image(dodo[0].get(this.xFrame, 0, this.widthFrame, this.heightFrame), this.posicion[0].x, this.posicion[0].y, this.widthFrame, this.heightFrame);
    image(dodo[1].get(this.xFrame, 0, this.widthFrame, this.heightFrame), this.posicion[1].x, this.posicion[1].y, this.widthFrame, this.heightFrame);

    this.delayActual++;
    if(this.delayActual >= this.delay) {
      this.delayActual = 0;
      this.xFrame += this.widthFrame;


    if(this.xFrame >= this.dodo[0].width && this.xFrame >= this.dodo[1].width) {
      this.xFrame = 0;
    }
    }

    // Se iran moviendo hacia abajo
    this.posicion[0].y += 2;        
    this.posicion[1].y += 2; 

    
    // Si la posicion en Y de ambos dodos supera el alto del lienzo
    
    if(this.posicion[0].y > height && this.posicion[1].y > height) {
      // en ambos se genera una posición aleatoria
      this.posicion[0].x = random(10, width/2 - 120);
      this.posicion[1].x = random(width/2 + 120, width - 10);
      // va a reaparecer arriba del lienzo
      this.posicion[0].y = -this.heightFrame;
      this.posicion[1].y = -this.heightFrame;
  }
  }

}
