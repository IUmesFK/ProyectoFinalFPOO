static class Time{
  static float getDeltaTime(float frames){
    int fps = round(frames);
    float deltaTime = 1.0/fps;
    return deltaTime;
  }
}
