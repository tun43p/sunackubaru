import 'package:flutter/cupertino.dart';

class Task {
  const Task(this.name, this.duration);

  final String name;
  final Duration duration;
}

enum TaskStatus {
  error(CupertinoColors.systemRed),
  success(CupertinoColors.systemGreen),
  warning(CupertinoColors.systemOrange);

  const TaskStatus(this.color);

  final Color color;
}
