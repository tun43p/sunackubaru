import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunackubaru/features/tasks/tasks_model.dart';

class StorageService {
  late final SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> clearStorage() async {
    await _sharedPreferences.clear();
  }

  Future<void> setGitHubToken(String token) async {
    await _sharedPreferences.setString('github_token', token);
  }

  String? get gitHubToken {
    return _sharedPreferences.getString('github_token');
  }

  Future<void> setTasks(List<Task> tasks) async {
    final List<String> tasksJson =
        tasks.map((Task task) => jsonEncode(task.toJson())).toList();

    await _sharedPreferences.setStringList('tasks', tasksJson);
  }

  List<Task> get tasks {
    final List<String>? tasksJson = _sharedPreferences.getStringList('tasks');

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
