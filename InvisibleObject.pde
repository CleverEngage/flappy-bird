abstract class InvisibleObject extends Geometry {
  float speed;

  InvisibleObject(float x, float y, float w, float h, float _speed) {
    super(x, y, w, h);
    speed = _speed;
  }

  abstract void move();
}
