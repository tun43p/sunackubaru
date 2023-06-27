import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;

  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  void start() {
    if (!_isRunning) {
      _isRunning = true;
      notifyListeners();

      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        _duration = _duration + const Duration(seconds: 1);
        notifyListeners();
      });
    }
  }

  void stop() {
    _timer.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void reset() {
    _timer.cancel();
    _duration = Duration.zero;
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
