import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/features/timer/tasks_model.dart';

class TasksProvider with ChangeNotifier {
  late Timer _timer;
  late Timer _statusTimer;

  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  Duration _duration = Duration.zero;
  Duration get duration => _duration;

  bool _running = false;
  bool get running => _running;

  ({String message, TaskStatus type})? _status;
  ({String message, TaskStatus type})? get status => _status;

  List<Task> _tasks = <Task>[];
  List<Task> get tasks => _tasks;

  Task? _currentTask;
  Task? get currentTask => _currentTask;

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
          type: TaskStatus.error,
          message: 'Merci de donner un nom à votre tâche.',
        ),
      );
      return;
    }

    if (_tasks.any(
      (Task task) => task.name == _textEditingController.text,
    )) {
      _setStatus(
        (
          type: TaskStatus.error,
          message: 'Une tâche avec ce nom existe déjà.',
        ),
      );
      return;
    }

    _running = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _duration = _duration + const Duration(seconds: 1);

      if (_currentTask == null) {
        _currentTask = Task(_textEditingController.text, _duration);
        _tasks = <Task>[..._tasks, _currentTask!];
      } else {
        // TODO(tun43p): Update this implementation to be able to edit the new selected one and not only the last one
        _tasks.last = Task(_currentTask!.name, _duration);
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

  void _setStatus(({String message, TaskStatus type}) status) {
    _status = status;

    _statusTimer = Timer(const Duration(seconds: 3), () {
      _status = null;
      _statusTimer.cancel();
      notifyListeners();
    });

    notifyListeners();
  }
}
