import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';
import 'package:sunackubaru/features/settings/settings_page.dart';
import 'package:sunackubaru/features/timer/tasks_page.dart';

class Sunackubaru extends StatelessWidget {
  Sunackubaru({super.key});

  final String _title = 'Sunackubaru';

  final List<({String name, Widget widget, IconData icon})> _pages =
      <({String name, Widget widget, IconData icon})>[
    (
      name: 'Tasks',
      widget: const TasksPage(),
      icon: CupertinoIcons.timer,
    ),
    (
      name: 'Settings',
      widget: const SettingsPage(),
      icon: CupertinoIcons.settings
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: _title,
      theme: const CupertinoThemeData(),
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(_title),
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
