import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/storage/storage_service.dart';
import 'package:sunackubaru/features/tasks/tasks_model.dart';

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
  set tasks(List<Task> newTasks) {
    _tasks = newTasks;
    notifyListeners();
  }

  Task? _currentTask;
  Task? get currentTask => _currentTask;
  set currentTask(Task? newCurrentTask) {
    _currentTask = newCurrentTask;
    _duration = newCurrentTask?.duration ?? Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    _timer.cancel();
    _statusTimer.cancel();
  }

  Future<void> start() async {
    if (_textEditingController.text.isEmpty && _currentTask == null) {
      _setStatus(
        (
          type: TaskStatus.error,
          message: t.tasks.errors.no_task_name,
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
          message: t.tasks.errors.task_already_exists,
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
        _currentTask = Task(_currentTask!.name, _duration);
        _tasks = _tasks
            .map(
              (Task task) =>
                  task.name == _currentTask!.name ? _currentTask! : task,
            )
            .toList();
      }

      if (_textEditingController.text.isNotEmpty) {
        _textEditingController.text = '';
      }

      notifyListeners();
    });

    await StorageService.setTasks(_tasks);

    notifyListeners();
  }

  Future<void> stop() async {
    _timer.cancel();
    _running = false;

    await StorageService.setTasks(_tasks);

    notifyListeners();
  }

  Future<void> reset() async {
    _timer.cancel();
    _currentTask = null;
    _duration = Duration.zero;
    _running = false;
    _textEditingController.text = '';

    await StorageService.setTasks(_tasks);

    notifyListeners();
  }

  Future<void> delete(Task oldTask) async {
    if (_currentTask == oldTask) await reset();
    _tasks = _tasks.where((Task task) => task != oldTask).toList();

    await StorageService.setTasks(_tasks);

    notifyListeners();
  }

  void _setStatus(({String message, TaskStatus type}) newStatus) {
    _status = newStatus;

    _statusTimer = Timer(const Duration(seconds: 3), () {
      _status = null;
      _statusTimer.cancel();
      notifyListeners();
    });

    notifyListeners();
  }
}
