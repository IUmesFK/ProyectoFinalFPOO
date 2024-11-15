class JoyPad{
  
  private boolean leftPressed;
  private boolean rightPressed;
  private boolean upPressed;
  private boolean downPressed;
  
  /**
  ----- CONSTRUCTOR -----
  */
  
  JoyPad() {
    
  }

  /**
  ----- SETTERS Y GETTERS -----
  */

  void setLeftPresssed(boolean leftPressed) {
    this.leftPressed=leftPressed;
  }
  public boolean isLeftPressed() {
    return this.leftPressed;
  }

  public void setRightPressed(boolean rightPressed) {
    this.rightPressed=rightPressed;
  }
  public boolean isRightPressed() {
    return this.rightPressed;
  }

  public void setUpPressed(boolean upPressed) {
    this.upPressed=upPressed;
  }

  public boolean isUpPressed() {
    return this.upPressed;
  }

  public void setDownPressed(boolean downPressed) {
    this.downPressed=downPressed;
  }

  public boolean isDownPressed() {
    return this.downPressed;
  }
  
}
