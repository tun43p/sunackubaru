import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';
import 'package:sunackubaru/sunackubaru.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<TasksProvider>(
          create: (_) => TasksProvider(),
        ),
      ],
      child: Sunackubaru(),
    ),
  );
}
