import 'dart:async';

import 'package:flutter/widgets.dart';

class TimerProvider with ChangeNotifier {
  late Timer _timer;

  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  bool _running = false;
  bool get running => _running;

  List<Map<String, Duration>> _tasks = <Map<String, Duration>>[];
  List<Map<String, Duration>> get tasks => _tasks;

  Map<String, Duration>? _currentTask;
  Map<String, Duration>? get currentTask => _currentTask;

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void start({String? task}) {
    if (!_running) {
      _running = true;
      notifyListeners();

      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        _duration = _duration + const Duration(seconds: 1);

        if (task != null) {
          if (_currentTask == null) {
            _currentTask = <String, Duration>{task: _duration};
            _tasks = <Map<String, Duration>>[..._tasks, _currentTask!];
          } else {
            _tasks.last = <String, Duration>{
              _currentTask!.keys.single: _duration
            };
          }
        }

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

    _currentTask = null;
    _duration = Duration.zero;
    _running = false;
    notifyListeners();
  }
}
