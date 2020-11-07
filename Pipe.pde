class Pipe extends VisibleObject {
  float backgroundY;
  float backgroundH;

  Pipe(float x, float y, float w, float h, float speed, PImage background, boolean isUpPipe) {
    super(x, y, w, h, speed, background);
    backgroundY = isUpPipe ? y - background.height + h : y;
    backgroundH = background.height;
  }

  void move() {
    x -= speed;
  }

  void drawObject() {
    image(background, x, backgroundY, w, backgroundH);
  }
}
