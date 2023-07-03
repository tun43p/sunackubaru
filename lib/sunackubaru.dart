import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/features/settings/settings_page.dart';
import 'package:sunackubaru/features/timer/timer_page.dart';

class Sunackubaru extends StatelessWidget {
  const Sunackubaru({super.key});

  final String _title = 'Sunackubaru';

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
              builder: (BuildContext context) {
                return _SunackubaruPage(index: index);
              },
            );
          },
        ),
      ),
    );
  }
}

class _SunackubaruPage extends StatelessWidget {
  const _SunackubaruPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return CupertinoTabView(
          defaultTitle: 'Timer',
          builder: (BuildContext context) {
            return const TimerPage();
          },
        );
      case 1:
        return CupertinoTabView(
          defaultTitle: 'Settings',
          builder: (BuildContext context) {
            return const SettingsPage();
          },
        );
      default:
        throw Exception('Invalid tab index $index');
    }
  }
}
