class PipesManager {
  final static float PIPE_WIDTH = 70;
  final static float PIPE_MIN_HEIGHT = 60;

  float pipesHorizontalSpacing;
  Geometry playingFrame;
  Geometry ground;
  float pipesSpeed;
  PImage upPipeBackground;
  PImage downPipeBackground;

  ArrayList<PipesGap> pipesGaps;
  ArrayList<Pipe> pipes;

  PipesManager(Geometry _playingFrame, Geometry _ground, float _pipesSpeed, String upPipeUri, String downPipeUri) {
    playingFrame = _playingFrame;
    ground = _ground;
    pipesSpeed = _pipesSpeed;
    upPipeBackground = loadImage(upPipeUri);
    downPipeBackground = loadImage(downPipeUri);
    setPipesHorizontalSpacing();
    pipesGaps = new ArrayList<PipesGap>(10);
    pipes = new ArrayList<Pipe>(20);

    float gapX = width + pipesHorizontalSpacing;

    for (int i = 0; i < 10; i++) {
      PipesGap pipesGap = generateRandomGap(gapX);
      pipesGaps.add(pipesGap);
      gapX += pipesHorizontalSpacing;
    }

    for (PipesGap gap : pipesGaps) {
      ArrayList<Pipe> generatedPipes = generatePipes(gap);
      pipes.addAll(generatedPipes);
    }
  }

  void setPipesHorizontalSpacing() {
    if (playingFrame.w > 1200) {
      pipesHorizontalSpacing = 600;
    } else if (playingFrame.w > 800) {
      pipesHorizontalSpacing = 500;
    } else {
      pipesHorizontalSpacing = 300;
    }
  }

  PipesGap generateRandomGap(float x) {
    float gapH = random(100, 180);
    float y = random(playingFrame.y + PIPE_MIN_HEIGHT, ground.y - PIPE_MIN_HEIGHT - gapH);

    return new PipesGap(x, y, PIPE_WIDTH, gapH, pipesSpeed);
  }

  ArrayList<Pipe> generatePipes(PipesGap gap) {
    ArrayList<Pipe> pipes = new ArrayList<Pipe>(2);

    pipes.add(new Pipe(gap.x, playingFrame.y, PIPE_WIDTH, gap.y - playingFrame.y, pipesSpeed, upPipeBackground, true));
    pipes.add(new Pipe(gap.x, gap.y + gap.h, PIPE_WIDTH, ground.y - gap.y - gap.h, pipesSpeed, downPipeBackground, false));

    return pipes;
  }

  ArrayList<PipesGap> getPipesGaps() {
    return pipesGaps;
  }

  ArrayList<Pipe> getPipes() {
    return pipes;
  }

  void update() {
    movePipes();
    removeInvalidAndGenerate();
  }

  void removeInvalidAndGenerate() {
    PipesGap pipesGap = pipesGaps.get(0);
    float gapRightEdge = pipesGap.x + pipesGap.w;

    if (gapRightEdge <= playingFrame.x) {
      pipesGaps.remove(0);
      pipes.remove(0);  // remove upper pipe
      pipes.remove(0);  // remove lower pipe

      PipesGap lastGap = pipesGaps.get(pipesGaps.size() - 1);
      float gapX = lastGap.x + lastGap.w + pipesHorizontalSpacing;

      PipesGap generatedGap = generateRandomGap(gapX);
      pipesGaps.add(generatedGap);

      ArrayList<Pipe> generatedPipes = generatePipes(generatedGap);
      pipes.addAll(generatedPipes);
    }
  }

  void movePipes() {
    for (PipesGap gap : pipesGaps) {
      gap.move();
    }

    for (Pipe pipe : pipes) {
      pipe.move();
    }
  }

  void drawPipes() {
    for (Pipe pipe : pipes) {
      pipe.drawObject();
    }
  }
}
