import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/timer/timer_provider.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerProvider state = context.watch<TimerProvider>();
    final TimerProvider notifier = context.read<TimerProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Timer'),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            state.duration.toString().split('.').first,
            style: const TextStyle(
              fontSize: 24,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        CupertinoButton.filled(
          onPressed: state.running ? null : notifier.start,
          child: const Text('Start'),
        ),
        CupertinoButton(
          onPressed: !state.running ? null : notifier.stop,
          child: const Text('Stop'),
        ),
        CupertinoButton(
          onPressed: state.duration.inSeconds == 0 ? null : notifier.reset,
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
