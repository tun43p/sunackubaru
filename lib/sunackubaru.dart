import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';
import 'package:sunackubaru/features/settings/settings_page.dart';
import 'package:sunackubaru/features/timer/timer_page.dart';

class Sunackubaru extends StatelessWidget {
  Sunackubaru({super.key});

  final String _title = 'Sunackubaru';

  final List<Map<String, Widget>> _pages = <Map<String, Widget>>[
    <String, Widget>{
      'Timer': const TimerPage(),
    },
    <String, Widget>{
      'Settings': const SettingsPage(),
    },
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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.timer),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              defaultTitle: _pages[index].keys.single,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: kCupertinoNavigationBarHeight,
                    bottom: kCupertinoTabScaffoldHeight,
                  ),
                  child: _pages[index].values.single,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
