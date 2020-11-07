class BirdWatcher {
  Geometry bird;
  Geometry ground;
  PipesManager pipesManager;
  BirdWatcherListener birdWatcherListener;
  PipesGap passingGap = null;


  BirdWatcher(Geometry _bird, Geometry _ground, PipesManager _pipesManager) {
    bird = _bird;
    ground = _ground;
    pipesManager = _pipesManager;
  }

  void setBirdWatcherListener(BirdWatcherListener listener) {
    birdWatcherListener = listener;
  }

  void watch() {
    if (isBirdCollide(ground)) {
      birdWatcherListener.onGroundCollide();
    }

    ArrayList<Pipe> pipes = pipesManager.getPipes();
    for (Pipe pipe : pipes) {
      if (isBirdCollide(pipe)) {
        birdWatcherListener.onPipeCollide();
        break;
      }
    }

    if (passingGap == null) {
      ArrayList<PipesGap> gaps = pipesManager.getPipesGaps();
      for (PipesGap gap : gaps) {
        if (isBirdCollide(gap)) {
          passingGap = gap;
          break;
        }
      }
    } else if (!isBirdCollide(passingGap)) {
      passingGap = null;
      birdWatcherListener.onPipesGapPass();
    }
  }

  boolean isBirdCollide(Geometry other) {
    if (bird.x > other.x + other.w 
      || bird.x + bird.w < other.x 
      || bird.y > other.y + other.h 
      || bird.y + bird.h < other.y) {
      return false;
    }   

    return true;
  }
}
