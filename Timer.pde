// Example 10-5: Object-oriented timer

class Timer {

  int savedTime; // When Timer started
  int totalTime; // How long Timer should last

  Timer() {
    totalTime = 300;
  }

  // Starting the timer
  void start(int duration) {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis();
    totalTime = duration;
  }

  // The function isFinished() returns true if 5,000 ms have passed.
  // The work of the timer is farmed out to this method.
  boolean isFinished() {
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
