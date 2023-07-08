import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/storage/storage_service.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';
import 'package:sunackubaru/features/settings/settings_page.dart';
import 'package:sunackubaru/features/settings/settings_provider.dart';
import 'package:sunackubaru/features/tasks/tasks_page.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';

class Sunackubaru extends StatefulWidget {
  const Sunackubaru({super.key});

  @override
  State<Sunackubaru> createState() => _SunackubaruState();
}

class _SunackubaruState extends State<Sunackubaru> {
  final List<({String name, Widget widget, IconData icon})> _pages =
      <({String name, Widget widget, IconData icon})>[
    (
      name: t.tasks.title,
      widget: const TasksPage(),
      icon: CupertinoIcons.timer,
    ),
    (
      name: t.settings.title,
      widget: const SettingsPage(),
      icon: CupertinoIcons.settings
    ),
  ];

  @override
  void initState() {
    super.initState();

    unawaited(_initState());
  }

  Future<void> _initState() async {
    await GetIt.I.get<StorageService>().init();

    if (mounted) {
      context.read<SettingsProvider>().gitHubToken =
          GetIt.I.get<StorageService>().gitHubToken;

      context.read<TasksProvider>().tasks = GetIt.I.get<StorageService>().tasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: t.core.title,
      theme: const CupertinoThemeData(applyThemeToAll: true),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocaleUtils.supportedLocales,
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(t.core.title),
        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: _pages
                .map(
                  (({IconData icon, String name, Widget widget}) page) =>
                      BottomNavigationBarItem(icon: Icon(page.icon)),
                )
                .toList(),
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              defaultTitle: _pages[index].name,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: kCupertinoNavigationBarHeight,
                    bottom: kCupertinoTabScaffoldHeight,
                  ),
                  child: _pages[index].widget,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
