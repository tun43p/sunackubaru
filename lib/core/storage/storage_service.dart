import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunackubaru/features/tasks/tasks_model.dart';

class StorageService {
  static Future<void> setTasks(List<Task> tasks) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final List<String> tasksJson =
        tasks.map((Task task) => jsonEncode(task.toJson())).toList();

    await sharedPreferences.setStringList('tasks', tasksJson);
  }

  static Future<List<Task>> getTasks() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final List<String>? tasksJson = sharedPreferences.getStringList('tasks');

    if (tasksJson != null) {
      final List<Task> tasks = tasksJson
          .map(
            (String taskJson) => Task.fromJson(jsonDecode(taskJson)),
          )
          .toList()
          .cast<Task>();

      return tasks;
    }

    return <Task>[];
  }
}
