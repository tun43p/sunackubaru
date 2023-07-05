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
      children: <Widget>[
        if (state.status != null)
          ColoredBox(
            color: state.status!.type.color,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                state.status!.message,
                style: const TextStyle(
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.zero,
          child: Text(
            state.duration.toString().split('.').first,
            style: const TextStyle(
              fontSize: 24,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <CupertinoButton>[
            CupertinoButton(
              onPressed: state.running ? notifier.stop : notifier.start,
              child: Icon(
                state.running ? CupertinoIcons.stop : CupertinoIcons.play_arrow,
              ),
            ),
            CupertinoButton(
              onPressed: state.duration.inSeconds == 0 ? null : notifier.reset,
              child: const Icon(CupertinoIcons.refresh_thick),
            ),
          ],
        ),
        // TODO(tun43p): Fix scroll
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            if (state.currentTask != null)
              Text('Tâche en cours: ${state.currentTask!.keys.single}'),
            CupertinoTextField(
              controller: state.textEditingController,
              keyboardType: TextInputType.text,
              placeholder: 'Nom de la tâche',
            ),
            ...state.tasks
                .where(
              (Map<String, Duration> task) =>
                  task.keys.single != state.currentTask?.keys.single,
            )
                .map(
              (Map<String, Duration> task) {
                return Text(task.toString());
              },
            )
          ],
        ),
      ],
    );
  }
}
