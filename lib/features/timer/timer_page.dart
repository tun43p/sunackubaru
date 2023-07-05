import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/timer/timer_provider.dart';
import 'package:sunackubaru/features/timer/timer_utils.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerProvider state = context.watch<TimerProvider>();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const _TimerControlsWidget(),
          CupertinoTextField(
            controller: state.textEditingController,
            keyboardType: TextInputType.text,
            placeholder: 'Nom de la tâche',
          ),
          if (state.status != null)
            Text(
              state.status!.message,
              style: TextStyle(
                color: state.status!.type.color,
              ),
            ),
          const _TimerTasksWidget()
        ],
      ),
    );
  }
}

class _TimerControlsWidget extends StatelessWidget {
  const _TimerControlsWidget();

  @override
  Widget build(BuildContext context) {
    final TimerProvider state = context.watch<TimerProvider>();
    final TimerProvider notifier = context.read<TimerProvider>();

    return Column(
      children: <Widget>[
        Text(
          TimerUtils.formatDuration(state.duration),
          style: const TextStyle(
            fontSize: 24,
            color: CupertinoColors.systemGrey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <CupertinoButton>[
            CupertinoButton(
              onPressed: state.running ? notifier.stop : notifier.start,
              child: Icon(
                state.running
                    ? CupertinoIcons.pause
                    : CupertinoIcons.play_arrow,
              ),
            ),
            CupertinoButton(
              onPressed: state.duration.inSeconds == 0 ? null : notifier.reset,
              child: const Icon(CupertinoIcons.stop),
            ),
          ],
        ),
      ],
    );
  }
}

class _TimerTasksWidget extends StatelessWidget {
  const _TimerTasksWidget();

  @override
  Widget build(BuildContext context) {
    final TimerProvider state = context.watch<TimerProvider>();

    return CupertinoListSection(
      header: const Text('Tâches'),
      children: state.tasks
          .map(
            (Map<String, Duration> task) {
              final String name = task.keys.single;
              final Duration duration = task.values.single;

              return CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.doc_text,
                  color: name == state.currentTask?.keys.single
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.systemBlue,
                ),
                key: ValueKey<String>(name),
                title: Text(name),
                additionalInfo: Text(
                  TimerUtils.formatDuration(duration),
                ),
              );
            },
          )
          .toList()
          .reversed
          .toList(),
    );
  }
}
