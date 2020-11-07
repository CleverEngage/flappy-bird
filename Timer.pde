class Timer {
  int triggerTime;
  int expiredTime;

  Timer() {
  }

  void setInterval(int milliseconds) {
    triggerTime = millis();
    expiredTime = triggerTime + milliseconds;
  }

  boolean isExpired() {
    return millis() >= expiredTime;
  }
}
