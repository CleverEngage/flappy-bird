class Score extends GameText {  
  int score = 0;

  Score(String scoreLabel, float x, float y, String fontURI, color textColor, boolean horizontalCentered) {
    super(scoreLabel, x, y, fontURI, textColor, horizontalCentered);
  }

  void addPoints(int points) {
    score += points;
  }

  void reset() {
    if (score != 0) {
      score = 0;
    }
  }

  String getText() {
    return theText + ": " + score;
  }
}
