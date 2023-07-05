import 'dart:async';

import 'package:flutter/cupertino.dart';

enum TimerStatus {
  error(CupertinoColors.systemRed),
  success(CupertinoColors.systemGreen),
  warning(CupertinoColors.systemOrange);

  const TimerStatus(this.color);

  final Color color;
}

class TimerProvider with ChangeNotifier {
  late Timer _timer;
  late Timer _statusTimer;

  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  bool _running = false;
  bool get running => _running;

  ({TimerStatus type, String message})? _status;
  ({TimerStatus type, String message})? get status => _status;

  List<Map<String, Duration>> _tasks = <Map<String, Duration>>[];
  List<Map<String, Duration>> get tasks => _tasks;

  Map<String, Duration>? _currentTask;
  Map<String, Duration>? get currentTask => _currentTask;

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();

    _timer.cancel();
    _statusTimer.cancel();
  }

  void start() {
    if (_textEditingController.text.isEmpty && _currentTask == null) {
      _setStatus(
        (
          type: TimerStatus.error,
          message: 'Merci de donner un nom à votre tâche.',
        ),
      );
      return;
    }

    _running = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _duration = _duration + const Duration(seconds: 1);

      if (_currentTask == null) {
        _currentTask = <String, Duration>{
          _textEditingController.text: _duration
        };
        _tasks = <Map<String, Duration>>[..._tasks, _currentTask!];
      } else {
        _tasks.last = <String, Duration>{_currentTask!.keys.single: _duration};
      }

      if (_textEditingController.text.isNotEmpty) {
        _textEditingController.text = '';
      }

      notifyListeners();
    });

    notifyListeners();
  }

  void stop() {
    _timer.cancel();
    _running = false;
    notifyListeners();
  }

  void reset() {
    _timer.cancel();
    _currentTask = null;
    _duration = Duration.zero;
    _running = false;
    _textEditingController.text = '';

    notifyListeners();
  }

  void _setStatus(({TimerStatus type, String message}) status) {
    _status = status;

    _statusTimer = Timer(const Duration(seconds: 3), () {
      _status = null;
      _statusTimer.cancel();
      notifyListeners();
    });

    notifyListeners();
  }
}
