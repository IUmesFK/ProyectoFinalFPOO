import ddf.minim.*; 

// Declaración de las variables principales del juego
private Jugador jugador; 
private JoyPad joyPad; 
private SpawnerObstaculo spawnerO; 
private Hud hud;
private Pantalla pantalla;
private Minim sonido; 
private AudioPlayer audioMenu, audioJuego, audioDerrota, audioVictoria; 
private PImage logo; 
private int velocidadLogo; 
private int presentacion; 
private int estado; 
private Escenario escenario; 
private float deltaTime; 
private int seleccion;
private int tiempoInicial; // Se usara para el estado DERROTA_EXPLOSION
private PFont fuente;


public void setup() {
  frameRate(60);
// Usamos el renderizador P2D y no el que viene por defecto (JAVA2D) ya que al tener grafica dedicada podemos sacarle mayor provecho en el apartado grafico debido a que usamos muchas imagenes, en caso de tener problemas, sacar el P2D  
  size(800, 600, P2D);
  fuente = loadFont("Calibri-BoldItalic-48.vlw");
  textFont(fuente);
  jugador = new Jugador(new PVector(width / 2, height - 50),
  new PVector(100 * Time.getDeltaTime(frameRate), 100 * Time.getDeltaTime(frameRate)));
  // Inicializa el jugador en el centro inferior de la pantalla con velocidad dependiente de deltaTime

  joyPad = new JoyPad(); 
  spawnerO = new SpawnerObstaculo(); // Inicializa el generador de obstáculos
  frameRate(60); // Configura la tasa de cuadros por segundo

  int framesPorSegundo = round(frameRate); // Calcula frames por segundo reales
  deltaTime = 1.0 / framesPorSegundo; // Calcula deltaTime para movimientos suaves

  escenario = new Escenario(); // Inicializa la escena del juego con capas visuales
  
  pantalla = new Pantalla();
  
  hud = new Hud(); 

  estado = MaquinaEstado.LOGO; // Estado inicial del juego

  sonido = new Minim(this); // Inicializa Minim para el manejo de audio
  // Carga los archivos de audio
  audioMenu = sonido.loadFile("menu.mp3");
  audioJuego = sonido.loadFile("juego.mp3");
  audioDerrota = sonido.loadFile("derrota.mp3");
  audioVictoria = sonido.loadFile("victoria.mp3");

  logo = loadImage("Logo.png"); 
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
    pantalla.setRuta("Menu.png");
    pantalla.display();
    audioMenu.play(); // Reproduce la música del menú

    if (audioMenu.position() >= audioMenu.length()) {
      audioMenu.rewind(); // Reproduce en bucle
    }
    selector("EMPEZAR");// Mostrar opción de comenzar el juego.
    if (keyCode == ENTER) { // Cambia al estado de juego al presionar espacio
      estado = MaquinaEstado.JUGANDO;
      audioMenu.pause(); // Pausa la música del menú
    }
    break;

  case MaquinaEstado.JUGANDO:
    // Estado principal del juego
    escenario.display(deltaTime); // Muestra la escena del juego
    audioJuego.play(); // Reproduce la música del juego
    
    if (audioJuego.position() >= audioJuego.length()) {
      audioJuego.rewind(); // Reproduce en bucle
    }

     
    jugador.calcularPuntaje();
    hud.mostrarTiempo(); // Muestra el tiempo restante en la parte superior izquierda
    hud.mostrarPuntaje(jugador); // Muestra el puntaje en la parte superior derecha
    hud.mostrarDurabilidad(jugador); // Muestra la durabilidad en la parte inferior izquierda
    spawnerO.generarObstaculo(); // Genera nuevos obstáculos
    spawnerO.mostrarObstaculos(); // Muestra los obstáculos en pantalla
    spawnerO.eliminarObstaculos(); // Elimina obstáculos fuera de la pantalla
    jugador.display();

    // Maneja el movimiento del jugador basado en el JoyPad
    if (joyPad.isUpPressed()) jugador.mover(1);
    if (joyPad.isDownPressed()) jugador.mover(2);
    if (joyPad.isLeftPressed()) jugador.mover(3);
    if (joyPad.isRightPressed()) jugador.mover(4);

    spawnerO.validarColision(jugador); // Verifica colisiones entre el jugador y obstáculos
    if (jugador.getDurabilidad() == 0) {// Cambia al estado de derrota
      estado = MaquinaEstado.DERROTA_EXPLOSION;
      audioJuego.pause();
      audioDerrota.rewind();
    }
    if (hud.getTiempoRestante() == 0) { // Si el tiempo llega a 0
      estado = MaquinaEstado.VICTORIA; // se cambia de estado
      audioJuego.pause(); // Pausa la música del juego
    }
    break;

  case MaquinaEstado.DERROTA_EXPLOSION:
    
    escenario.display(deltaTime);
    jugador.display();

    jugador.explotarAuto();

    if (tiempoInicial == 0) { // Si tiempo inicial es igual a 0, almacenara el tiempo en milisegundos desde que se entro al estado DERROTA_EXPLOSION
        tiempoInicial = millis();
    }

    int tiempoActual = millis(); //
    if (tiempoActual - tiempoInicial > 1500) { // Dura 1 segundo y medio
        estado = MaquinaEstado.DERROTA_PANTALLA; // Cambia de estado
        tiempoInicial = 0; // Reinicia el tiempo inicial
    }
    tiempoActual = 0;
    break;
    
  case MaquinaEstado.DERROTA_PANTALLA:
    // Pantalla de derrota
    audioDerrota.play(); // Reproduce la música de derrota
    pantalla.setRuta("Derrota.png");
    pantalla.display();
    selector("REINTENTAR"); // Mostrar opción de reiniciar.
    break;

  case MaquinaEstado.VICTORIA:
    // Pantalla de victoria
    audioVictoria.play(); // Reproduce la música de victoria
    pantalla.setRuta("Victoria.png");
    pantalla.display();
    selector("JUGAR"); // Mostrar opción de volver a jugar
    break;
  }
}

// Método para mostrar las opciones del menú.
public void selector(String nombre) {
  textSize(40); // Tamaño de la fuente.
  if (seleccion == 0) {
    fill(255,0,0);
    textAlign(CENTER);
    text(nombre, width/2 - 150, height/2-200); // Mostrar texto seleccionado.
  } else {
    fill(225);
    textAlign(CENTER);
    text(nombre, width/2 - 150, height/2-200);
    
    
  }
  if (seleccion == 1) {
    fill(225,0,0);
    textAlign(CENTER);
    text("SALIR", width - 200, height/2-200);
  } else {
    fill(225);
    textAlign(CENTER);
    text("SALIR", width - 200, height/2-200);
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

  if (keyCode == LEFT || key == 'A' || key == 'a') seleccion = (seleccion - 1 + 2) % 2;
  else if (keyCode == RIGHT || key == 'D' || key == 'd') seleccion = (seleccion + 1) % 2;
  
  if (keyCode == ENTER) {
    if (seleccion == 0) {
      audioMenu.pause();
      estado = MaquinaEstado.JUGANDO;
      audioJuego.rewind();
      jugador.setDurabilidad(100);
      jugador.setPosicion(new PVector(width / 2, height - 50));
      jugador.setVelocidad(new PVector(100 * Time.getDeltaTime(frameRate), 100 * Time.getDeltaTime(frameRate)));
      hud.reiniciarTiempo();
      jugador.setPuntaje(0);
      jugador.setContFrames(1);
      jugador.setXFrame(0);
      jugador.setYFrame(0);
      spawnerO.vaciarLista();
    } else if (seleccion == 1) {
      exit(); // Salir del programa.
    }
  }
  
}
