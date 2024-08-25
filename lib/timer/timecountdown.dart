import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer {
  int _currentSeconds = 60;
  late Timer _timer;

  CountdownTimer(BuildContext context) {
    // Start the timer when the CountdownTimer object is created
    _startTimer(context);
  }

  // Method to start the countdown timer
  void _startTimer(BuildContext context) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        // Timer has reached zero, pop back to the previous screen
        timer.cancel();
        // You can use Navigator to pop back to the previous screen
        // Replace 'context' and 'previousScreen' with your actual context and screen
        Navigator.pop(context, 'Timer expired');
      } else {
        // Decrement the remaining seconds
        _currentSeconds--;
        print(_currentSeconds);
      }
    });
  }

  // Method to get the current time text
  String getTimeText() {
    int minutes = _currentSeconds ~/ 60;
    int seconds = _currentSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Method to cancel the timer (e.g., when you no longer need it)
  void cancelTimer() {
    _timer.cancel();
  }
}
