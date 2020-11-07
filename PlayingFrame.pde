class PlayingFrame extends Geometry {
  PlayingFrame(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void drawBorders() {
    fill(51);
    noStroke();
    // top
    rect(0, 0, width, y);
    // left
    rect(0, 0, x, height);
    // right
    rect(x + w, 0, x, height);
    // bottom
    rect(0, y + h, width, height - y - h);
  }
}
