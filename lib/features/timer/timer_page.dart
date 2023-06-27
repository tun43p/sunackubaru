import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/timer/timer_provider.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Timer'),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                context.watch<TimerProvider>().duration.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  child: const Text('Start'),
                  onPressed: () {
                    context.read<TimerProvider>().start();
                  },
                ),
                CupertinoButton(
                  child: const Text('Stop'),
                  onPressed: () {
                    context.read<TimerProvider>().stop();
                  },
                ),
                CupertinoButton(
                  child: const Text('Reset'),
                  onPressed: () {
                    context.read<TimerProvider>().reset();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
