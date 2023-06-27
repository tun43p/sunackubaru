import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/features/timer/timer_page.dart';

class Sunackubaru extends StatelessWidget {
  const Sunackubaru({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Sunackubaru',
      theme: CupertinoThemeData(),
      home: TimerPage(),
    );
  }
}
