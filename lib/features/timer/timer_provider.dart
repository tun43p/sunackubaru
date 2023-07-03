import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;

  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  bool _running = false;
  bool get running => _running;

  void start() {
    if (!_running) {
      _running = true;
      notifyListeners();

      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        _duration = _duration + const Duration(seconds: 1);
        notifyListeners();
      });
    }
  }

  void stop() {
    if (_running) _timer.cancel();

    _running = false;
    notifyListeners();
  }

  void reset() {
    if (_running) _timer.cancel();

    _duration = Duration.zero;
    _running = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
