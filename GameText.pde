class GameText {
  String theText;
  float x;
  float y;
  PFont font;
  color textColor;
  float textSize;

  GameText(String _theText, float _x, float _y, String fontURI, color _textColor, boolean horizontalCentered) {
    theText = _theText;
    x = _x;
    y = _y;
    font = loadFont(fontURI);
    textColor = _textColor;
    int beginIndex = fontURI.lastIndexOf("-") + 1;
    int endIndex = fontURI.lastIndexOf(".");
    textSize = Float.parseFloat(fontURI.substring(beginIndex, endIndex));

    if (horizontalCentered) {
      textFont(font, textSize);
      x -= textWidth(_theText) * 0.5;
    }
  }

  String getText() {
    return theText;
  }

  void display() {
    textFont(font, textSize);
    fill(textColor);
    text(getText(), x, y);
  }
}
