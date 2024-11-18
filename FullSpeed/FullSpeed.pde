import ddf.minim.*; // Importa la librería Minim para manejar audio

// Declaración de las variables principales del juego
private Jugador jugador; // Representa al jugador en el juego
private JoyPad joyPad; // Controlador para manejar el movimiento del jugador
private SpawnerObstaculo spawnerO; // Se encarga de generar y gestionar obstáculos
private Hud hud;
private Derrota derrota; // Clase para manejar el estado de derrota
private Victoria victoria; // Clase para manejar el estado de victoria
private Menu menu; // Clase para el menú principal
private Minim sonido; // Manejo de audio
private AudioPlayer audioMenu, audioJuego, audioDerrota, audioVictoria; // Archivos de audio para cada estado
private PImage logo; // Imagen del logo para la pantalla de introducción
private int velocidadLogo; // Velocidad con la que el logo aparece y desaparece
private int presentacion; // Transparencia actual del logo
private int estado; // Estado actual del juego, manejado por MaquinaEstados
private Escenario escenario; // Fondo y capas visuales del juego
private float deltaTime; // Tiempo entre frames para movimientos suaves
private int seleccion;// Controla la opción seleccionada en el menú.


public void setup() {
  size(800, 600); // Tamaño de la ventana
  jugador = new Jugador(new PVector(width / 2, height - 50),
    new PVector(100 * Time.getDeltaTime(frameRate), 100 * Time.getDeltaTime(frameRate)));
  // Inicializa el jugador en el centro inferior de la pantalla con velocidad dependiente de deltaTime

  joyPad = new JoyPad(); // Inicializa el controlador del jugador
  spawnerO = new SpawnerObstaculo(); // Inicializa el generador de obstáculos
  frameRate(60); // Configura la tasa de cuadros por segundo

  int framesPorSegundo = round(frameRate); // Calcula frames por segundo reales
  deltaTime = 1.0 / framesPorSegundo; // Calcula deltaTime para movimientos suaves

  escenario = new Escenario(); // Inicializa la escena del juego con capas visuales

  hud = new Hud(); 

  estado = MaquinaEstado.LOGO; // Estado inicial del juego
  derrota = new Derrota(); // Inicializa el estado de derrota
  victoria = new Victoria(); // Inicializa el estado de victoria
  menu = new Menu(); // Inicializa el menú principal

  sonido = new Minim(this); // Inicializa Minim para el manejo de audio
  // Carga los archivos de audio
  audioMenu = sonido.loadFile("menu.mp3");
  audioJuego = sonido.loadFile("juego.mp3");
  audioDerrota = sonido.loadFile("derrota.mp3");
  audioVictoria = sonido.loadFile("victoria.mp3");

  logo = loadImage("Logo.png"); // Carga la imagen del logo
  presentacion = 0; // Transparencia inicial del logo
  velocidadLogo = int(300 * Time.getDeltaTime(frameRate)); // Velocidad de aparición/desaparición del logo
  seleccion=0;// Opción seleccionada por defecto.
}

public void draw() {
  background(0); // Limpia la pantalla con un fondo negro

  // Manejador de estados del juego
  switch (estado) {
  case MaquinaEstado.LOGO:
    // Pantalla de introducción con el logo
    tint(presentacion); // Aplica la transparencia al logo
    presentacion += velocidadLogo; // Incrementa la transparencia

    image(logo, 0, 0, width, height); // Dibuja el logo en pantalla

    if (presentacion > 255) { // Si alcanza máxima opacidad, invierte dirección
      velocidadLogo *= -1;
    }
    if (presentacion < 0) { // Si desaparece completamente, cambia al estado de menú
      estado = MaquinaEstado.MENU;
      noTint(); // Elimina el efecto de transparencia
    }
    break;

  case MaquinaEstado.MENU:
    // Pantalla del menú principal
    menu.mostrar(); // Muestra el menú
    audioMenu.play(); // Reproduce la música del menú

    if (audioMenu.position() >= audioMenu.length()) {
      audioMenu.rewind(); // Reproduce en bucle
    }
    selector("EMPEZAR");// Mostrar opción de comenzar el juego.
    if (key == ' ') { // Cambia al estado de juego al presionar espacio
      estado = MaquinaEstado.JUGANDO;
      audioMenu.pause(); // Pausa la música del menú
      println("se apreto espacio");
    }
    break;

  case MaquinaEstado.JUGANDO:
    // Estado principal del juego
    escenario.display(deltaTime); // Muestra la escena del juego
    audioJuego.play(); // Reproduce la música del juego
    
    if (audioJuego.position() >= audioJuego.length()) {
      audioJuego.rewind(); // Reproduce en bucle
    }

    jugador.display(); // Muestra al jugador en pantalla
    jugador.calcularPuntaje();
    hud.mostrarTiempo(); // Muestra el tiempo restante en la parte superior izquierda
    hud.mostrarPuntaje(jugador); // Muestra el puntaje en la parte superior derecha
    spawnerO.generarObstaculo(); // Genera nuevos obstáculos
    spawnerO.mostrarObstaculos(); // Muestra los obstáculos en pantalla
    spawnerO.eliminarObstaculos(); // Elimina obstáculos fuera de la pantalla

    // Maneja el movimiento del jugador basado en el JoyPad
    if (joyPad.isUpPressed()) jugador.mover(1);
    if (joyPad.isDownPressed()) jugador.mover(2);
    if (joyPad.isLeftPressed()) jugador.mover(3);
    if (joyPad.isRightPressed()) jugador.mover(4);

    spawnerO.verificarColisionObstaculoJugador(jugador); // Verifica colisiones entre el jugador y obstáculos

    if (jugador.getDurabilidad() == 0) { // Cambia al estado de derrota
      estado = MaquinaEstado.DERROTA;
      audioJuego.pause(); // Pausa la música del juego
      audioDerrota.rewind();
      //println("se apreto c ");
    }
    if (hud.getTiempoRestante() == 0) { // Si el tiempo llega a 0
      estado = MaquinaEstado.VICTORIA; // se cambia de estado
      audioJuego.pause(); // Pausa la música del juego
      //println("se apreto v");
    }
    break;

  case MaquinaEstado.DERROTA:
    // Pantalla de derrota
    audioDerrota.play(); // Reproduce la música de derrota
    derrota.mostrar(); // Muestra la pantalla de derrota
    selector("REINTENTAR"); // Mostrar opción de reiniciar.
    
    if (key == 'o') { // Reinicia el juego al presionar "o"
      estado = MaquinaEstado.JUGANDO;
      audioDerrota.pause();
      audioJuego.rewind();
      audioJuego.play(); // Reanuda la música del juego
   println("Cambiando a estado jugando");
   jugador.setDurabilidad(100);
  
}
    break;

  case MaquinaEstado.VICTORIA:
    // Pantalla de victoria
    audioVictoria.play(); // Reproduce la música de victoria
    victoria.mostrar(); // Muestra la pantalla de victoria
    selector("JUGAR"); // Mostrar opción de volver a jugar
    break;
  }
}

// Método para mostrar las opciones del menú.
public void selector(String nombre) {
  textSize(40); // Tamaño de la fuente.
  if (seleccion == 0) {
    fill(255,0,0);
    text(nombre, width - 550, height/2-200); // Mostrar texto seleccionado.
  } else {
    fill(225);
    text(nombre, width - 550, height/2-200);
    
    
  }
  if (seleccion == 1) {
    fill(225,0,0);
    text("SALIR", width - 300, height/2-200);
  } else {
    fill(225);
    text("SALIR", width - 300, height/2-200);
  }
}


public void keyPressed() {
  // Maneja las teclas de dirección para activar movimiento
  if (key == 'W' || key == 'w' || keyCode == UP) joyPad.setUpPressed(true);
  if (key == 'S' || key == 's' || keyCode == DOWN) joyPad.setDownPressed(true);
  if (key == 'A' || key == 'a' || keyCode == LEFT) joyPad.setLeftPresssed(true);
  if (key == 'D' || key == 'd' || keyCode == RIGHT) joyPad.setRightPressed(true);
}

public void keyReleased() {
  // Maneja las teclas de dirección para desactivar movimiento
  if (key == 'W' || key == 'w' || keyCode == UP) joyPad.setUpPressed(false);
  if (key == 'S' || key == 's' || keyCode == DOWN) joyPad.setDownPressed(false);
  if (key == 'A' || key == 'a' || keyCode == LEFT) joyPad.setLeftPresssed(false);
  if (key == 'D' || key == 'd' || keyCode == RIGHT) joyPad.setRightPressed(false);

  
 
 if (estado == MaquinaEstado.DERROTA && key == 'o') {
        estado = MaquinaEstado.JUGANDO;
        audioDerrota.pause();
        audioJuego.play();
    }
 
 if (key == CODED) {
    if (keyCode == LEFT) seleccion = (seleccion - 1 + 2) % 2;
    else if (keyCode == RIGHT) seleccion = (seleccion + 1) % 2;
  }
  if (keyCode == ENTER) {
    if (seleccion == 0) {
      audioMenu.pause();
      estado = MaquinaEstado.JUGANDO;
    jugador.setDurabilidad(100);
    jugador.setPosicion(new PVector(width / 2, height - 50));
    } else if (seleccion == 1) {
      exit(); // Salir del programa.
    }
  } 
  
}
