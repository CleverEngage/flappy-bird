import processing.sound.*;

final static int STATE_NEW_GAME = 0;
final static int STATE_PLAYING = 1;
final static int STATE_GAME_OVER = 2;

float gameSpeed;
int gameState = STATE_NEW_GAME;
PlayingFrame playingFrame;
Bird bird;
EndlessBackgroundObject ground;
EndlessBackgroundObject gameBackground;
PipesManager pipesManager;
BirdWatcher birdWatcher;
GameText gameName;
Score score;
GameText gameControlText;
SoundFile flapSFX;
SoundFile hitSFX;
SoundFile scoreSFX;
Timer timer;

void setup() {
  //size(800, 600, P2D);
  size(1200, 800, P2D);
  //fullScreen(P2D);

  flapSFX = new SoundFile(this, "sfx/flap.wav");
  hitSFX = new SoundFile(this, "sfx/hit.wav");
  scoreSFX = new SoundFile(this, "sfx/score.wav");

  gameSpeed = width == 800 ? 3 : 6;
  timer = new Timer();

  setupFrameAndText();
  newGame();
}

void draw() {
  updateGame();
  drawGame();
}

void setupFrameAndText() {
  float vGap = width * 0.02;
  float hGap = height * 0.06;
  float frameX = vGap;
  float frameY = hGap * 2;
  float frameW = width - vGap * 2;
  float frameH = height - hGap * 3;
  playingFrame = new PlayingFrame(frameX, frameY, frameW, frameH);

  String fontUri;
  fontUri = "fonts/" + (width <= 800 ? "Candara-40.vlw" : "Candara-48.vlw");
  score = new Score("Score", frameX + 15, frameY * 0.7, fontUri, color(255, 195, 98), false);

  fontUri = "fonts/" + (width <= 800 ? "Bauhaus93-48.vlw" : "Bauhaus93-60.vlw");
  gameName = new GameText("Flappy Bird", width * 0.5, frameY * 0.7, fontUri, color(240, 179, 56), true);

  fontUri = "fonts/" + (width <= 800 ? "Candara-24.vlw" : "Candara-32.vlw");
  String text = "  -- Space Key --\nFlap | New Game";
  float x = width <= 800 ? width - 110 : width - 165;
  gameControlText = new GameText(text, x, frameY * 0.43, fontUri, color(255, 195, 98), true);
}

void newGame() {
  float birdSize = 40;
  bird = new Bird(playingFrame.x + playingFrame.w * 0.3, playingFrame.y + (playingFrame.h - birdSize) * 0.5, birdSize, playingFrame.y, "images/bird.png");
  gameBackground = new EndlessBackgroundObject(playingFrame.x, playingFrame.y, playingFrame.w, playingFrame.h, gameSpeed, "images/background.png");
  ground = new EndlessBackgroundObject(playingFrame.x, playingFrame.y + playingFrame.h - 60, playingFrame.w, 60, gameSpeed, "images/ground.png");
  pipesManager = new PipesManager(playingFrame, ground, gameSpeed, "images/pipe_up.png", "images/pipe_down.png");
  score.reset();
  birdWatcher = new BirdWatcher(bird, ground, pipesManager);
  birdWatcher.setBirdWatcherListener(new BirdWatcherListener() {
    public void onGroundCollide() {
      endGame();
    }

    public void onPipeCollide() {
      endGame();
    }

    public void onPipesGapPass() {
      updateScore();
    }
  }
  );
}

void endGame() {
  setGameState(STATE_GAME_OVER);
  hitSFX.play();
  timer.setInterval(500);
}

void updateScore() {
  score.addPoints(1);
  scoreSFX.play();
}

void flapBird() {
  bird.flap();
  flapSFX.play();
}

void updateGame() {
  switch(gameState) {
  case STATE_NEW_GAME:
    bird.update();
    break;
  case STATE_PLAYING:
    bird.update();
    gameBackground.move();
    ground.move();
    pipesManager.update();
    birdWatcher.watch();
    break;
  case STATE_GAME_OVER:
  default:
    return;
  }
}

void drawGame() {
  gameBackground.drawObject();
  bird.drawObject();
  pipesManager.drawPipes();
  ground.drawObject();
  playingFrame.drawBorders();
  gameName.display();
  gameControlText.display();
  score.display();
  //showFrameRate();
}

void setGameState(int state) {
  if (gameState != state) {
    gameState = state;
  }
}

void keyPressed() {
  if (key != 32) return;

  switch(gameState) {
  case STATE_NEW_GAME:
    setGameState(STATE_PLAYING);
    bird.setState(Bird.FLAPPING);
    flapBird();
    break;
  case STATE_PLAYING:
    flapBird();
    break;
  case STATE_GAME_OVER:
    if (!timer.isExpired()) return;

    setGameState(STATE_NEW_GAME);
    newGame();
    break;
  default:
    return;
  }
}

void showFrameRate() {
  fill(242, 79, 54);
  text(frameRate, 50, height * 0.19);
}
