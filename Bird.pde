class Bird extends VisibleObject {
  static final int HOVERING = 0;
  static final int FLAPPING = 1;
  static final float THRUST_MIN = 0;
  static final float THRUST_MAX = 15;
  static final float THRUST_DECREMENT = 0.5;

  int currentState = HOVERING;
  float angle = 90;
  float thrust = 0;
  float gravity = 8;
  float highestAltitude;

  Bird(float x, float y, float size, float _highestAltitude, String uri) {
    super(x, y, size, size, 0, uri);
    highestAltitude = _highestAltitude;
  }

  void update() {
    switch(currentState) {
    case HOVERING:
      speed = sin(angle);
      angle += 0.15;
      break;
    case FLAPPING:
      thrust = constrain(thrust, THRUST_MIN, THRUST_MAX);
      speed = gravity - thrust;

      if (thrust > THRUST_MIN) {   
        thrust -= THRUST_DECREMENT;
      }

      break;
    default:
      return;
    }

    move();
  }

  void flap() {
    if (y <= highestAltitude) {
      thrust = THRUST_MAX * 0.5;
    } else {
      thrust = THRUST_MAX;
    }
  }

  void move() {
    y += speed;
  }

  void drawObject() {
    image(background, x - 5, y, w + 9, h);
  }

  void setState(int state) {
    if (currentState != state) {
      currentState = state;
    }
  }
}
