class EndlessBackgroundObject extends VisibleObject {
  float[] imageX = new float[3];

  EndlessBackgroundObject(float x, float y, float w, float h, float speed, String uri) {
    super(x, y, w, h, speed, uri);

    for (int i = 0; i < 3; i++) {
      imageX[i] = x + i * w;
    }
  }

  void move() {
    for (int i = 0; i < 3; i++) {
      imageX[i] -= speed;
    }

    recycleIfNeeded();
  }

  void drawObject() {
    for (int i = 0; i < 3; i++) {
      image(background, imageX[i], y, w, h);
    }
  }

  void recycleIfNeeded() {
    int recycleIndex = -1;

    for (int i = 0; i < 3; i++) {
      if (imageX[i] + w <= x) {
        recycleIndex = i;
        break;
      }
    }

    if (recycleIndex == -1) return;

    int targetIndex = 0;

    for (int i = 1; i < 3; i++) {
      if (imageX[i] > imageX[targetIndex]) {
        targetIndex = i;
      }
    }

    imageX[recycleIndex] = imageX[targetIndex] + w;
  }
}
