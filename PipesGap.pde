class PipesGap extends InvisibleObject {
  PipesGap(float x, float y, float w, float h, float speed) {
    super(x, y, w, h, speed);
  }

  void move() {
    x -= speed;
  }
}
