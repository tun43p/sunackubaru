import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/settings/settings_provider.dart';
import 'package:sunackubaru/features/timer/tasks_provider.dart';
import 'package:sunackubaru/sunackubaru.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: (_) => TasksProvider(),
        ),
      ],
      child: Sunackubaru(),
    ),
  );
}
