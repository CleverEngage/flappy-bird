abstract class VisibleObject extends InvisibleObject {
  PImage background;

  VisibleObject(float x, float y, float w, float h, float speed, String uri) {
    super(x, y, w, h, speed);
    background = loadImage(uri);
  }

  VisibleObject(float x, float y, float w, float h, float speed, PImage _background) {
    super(x, y, w, h, speed);
    background = _background;
  }

  abstract void drawObject();
}
