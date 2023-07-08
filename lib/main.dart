import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/github/github_service.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/storage/storage_service.dart';
import 'package:sunackubaru/features/settings/settings_provider.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';
import 'package:sunackubaru/features/tasks/tasks_service.dart';
import 'package:sunackubaru/sunackubaru.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  GetIt.I.registerSingleton<GitHubService>(GitHubService());
  GetIt.I.registerSingleton<StorageService>(StorageService());
  GetIt.I.registerSingleton<TasksService>(TasksService());

  GetIt.I.registerSingleton<SettingsProvider>(SettingsProvider());
  GetIt.I.registerSingleton<TasksProvider>(TasksProvider());

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
      child: const Sunackubaru(),
    ),
  );
}
