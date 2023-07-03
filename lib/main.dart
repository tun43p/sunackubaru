import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/settings/settings_provider.dart';
import 'package:sunackubaru/features/timer/timer_provider.dart';
import 'package:sunackubaru/sunackubaru.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<TimerProvider>(
          create: (_) => TimerProvider(),
        ),
        ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: const Sunackubaru(),
    ),
  );
}
