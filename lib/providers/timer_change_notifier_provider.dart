import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerChangeNotifier extends ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds = 60;
  bool isOTPFieldVisible = false;

  int get remainingSeconds => _remainingSeconds;

  bool get isRunning => _timer != null && _timer!.isActive;

  void isOTpVisibleChnage(bool isVisible) {
    isOTPFieldVisible = isVisible;
    notifyListeners();
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        stopTimer();
      }
    });
    notifyListeners();
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  void resetTimer() {
    stopTimer();
    _remainingSeconds = 60;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final isOTPTimerChangeNotifierProvider =
    ChangeNotifierProvider.autoDispose<TimerChangeNotifier>(
        (ref) => TimerChangeNotifier());
