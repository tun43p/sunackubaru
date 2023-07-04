import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final TimerProvider state = context.watch<TimerProvider>();
    final TimerProvider notifier = context.read<TimerProvider>();

    return Column(
      children: <Widget>[
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
              onPressed: () => state.running
                  ? notifier.stopTimer()
                  : notifier.startTimer(
                      task: _textEditingController.text.isEmpty
                          ? null
                          : _textEditingController.text,
                    ),
              child: Icon(
                state.running ? CupertinoIcons.stop : CupertinoIcons.play_arrow,
              ),
            ),
            CupertinoButton(
              onPressed: state.duration.inSeconds == 0
                  ? null
                  : () {
                      _textEditingController.text = '';
                      notifier.resetTimer();
                    },
              child: const Icon(CupertinoIcons.refresh_thick),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CupertinoTextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                placeholder: 'Task name',
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final Map<String, Duration> task = state.tasks[index];
                  return Text('${task.keys.single} - ${task.values.single}');
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
