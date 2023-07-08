import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasks_model.g.dart';

@JsonSerializable()
class Task {
  const Task(this.name, this.duration);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  final String name;
  final Duration duration;

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

enum TaskStatus {
  error(CupertinoColors.systemRed),
  success(CupertinoColors.systemGreen),
  warning(CupertinoColors.systemOrange);

  const TaskStatus(this.color);

  final Color color;
}
