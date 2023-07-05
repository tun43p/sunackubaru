import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/status/status_provider.dart';
import 'package:sunackubaru/features/timer/timer_provider.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  void _onPlayPausePressed() {
    final TimerProvider timerNotifier = context.read<TimerProvider>();

    if (timerNotifier.running) {
      timerNotifier.stop();
    } else {
      if (_textEditingController.text.isEmpty &&
          timerNotifier.currentTask == null) {
        context.read<StatusProvider>().set(
              StatusType.warning,
              message: 'Vous lancez un timer sans tâche associée.',
            );
      }

      timerNotifier.start(
        task: _textEditingController.text.isEmpty
            ? null
            : _textEditingController.text,
      );

      if (_textEditingController.text.isNotEmpty) {
        _textEditingController.text = '';
      }
    }
  }

  void _onResetPressed() {
    context.read<TimerProvider>().reset();
    _textEditingController.text = '';
  }

  void _onEditingComplete() {
    final TimerProvider timerNotifier = context.read<TimerProvider>();

    if (_textEditingController.text.isEmpty) {
      context.read<StatusProvider>().set(
            StatusType.error,
            message: 'Vous ne pouvez pas créer une tâche vide.',
          );
      return;
    }

    if (timerNotifier.running) timerNotifier.reset();
    timerNotifier.start(task: _textEditingController.text);
    _textEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final StatusProvider statusState = context.watch<StatusProvider>();
    final TimerProvider timerState = context.watch<TimerProvider>();

    return Column(
      children: <Widget>[
        if (statusState.type != null && statusState.message != null)
          ColoredBox(
            color: statusState.type!.color,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                statusState.message!,
                style: const TextStyle(
                  color: CupertinoColors.white,
                ),
              ),
            ),
          ),

        Padding(
          padding: EdgeInsets.zero,
          child: Text(
            timerState.duration.toString().split('.').first,
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
              onPressed: _onPlayPausePressed,
              child: Icon(
                timerState.running
                    ? CupertinoIcons.stop
                    : CupertinoIcons.play_arrow,
              ),
            ),
            CupertinoButton(
              onPressed:
                  timerState.duration.inSeconds == 0 ? null : _onResetPressed,
              child: const Icon(CupertinoIcons.refresh_thick),
            ),
          ],
        ),
        // TODO(tun43p): Fix scroll
        ListView(
          shrinkWrap: true,
          children: <Widget>[
            if (timerState.currentTask != null)
              Text('Tâche en cours: ${timerState.currentTask!.keys.single}'),
            CupertinoTextField(
              controller: _textEditingController,
              keyboardType: TextInputType.text,
              placeholder: 'Nom de la tâche',
              onEditingComplete: _onEditingComplete,
            ),
            ...timerState.tasks
                .where(
              (Map<String, Duration> task) =>
                  task.keys.single != timerState.currentTask?.keys.single,
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
