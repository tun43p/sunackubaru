import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/timer/timer_provider.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerProvider timerProvider = context.watch<TimerProvider>();

    return CupertinoPageScaffold(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Timer'),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                timerProvider.duration.toString().split('.').first,
                style: const TextStyle(
                  fontSize: 24,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            CupertinoButton.filled(
              onPressed: timerProvider.running
                  ? null
                  : context.read<TimerProvider>().start,
              child: const Text('Start'),
            ),
            CupertinoButton(
              onPressed: !timerProvider.running
                  ? null
                  : context.read<TimerProvider>().stop,
              child: const Text('Stop'),
            ),
            CupertinoButton(
              onPressed: timerProvider.duration.inSeconds == 0
                  ? null
                  : context.read<TimerProvider>().reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
