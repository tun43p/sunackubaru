import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/tasks/tasks_model.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';
import 'package:sunackubaru/features/tasks/tasks_service.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();
    final TasksProvider notifier = context.read<TasksProvider>();

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const _TasksTimerWidget(),
          CupertinoTextField(
            autofocus: true,
            enabled: state.currentTask == null,
            controller: state.textEditingController,
            keyboardType: TextInputType.text,
            placeholder: 'Nom de la tâche',
            onEditingComplete: notifier.start,
          ),
          if (state.status != null)
            Text(
              state.status!.message,
              style: TextStyle(
                color: state.status!.type.color,
              ),
            ),
          if (state.tasks.isNotEmpty) const _TasksListWidget()
        ],
      ),
    );
  }
}

class _TasksTimerWidget extends StatelessWidget {
  const _TasksTimerWidget();

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();
    final TasksProvider notifier = context.read<TasksProvider>();

    return Column(
      children: <Widget>[
        Text(
          TasksService.formatDuration(state.duration),
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

class _TasksListWidget extends StatelessWidget {
  const _TasksListWidget();

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();

    return CupertinoListSection(
      header: const Text('Tâches'),
      children: state.tasks
          .map(
            (Task task) {
              return CupertinoListTile(
                leading: Icon(
                  CupertinoIcons.doc_text,
                  color: task.name == state.currentTask?.name
                      ? CupertinoColors.systemGreen
                      : CupertinoColors.systemBlue,
                ),
                key: ValueKey<String>(task.name),
                title: Text(task.name),
                additionalInfo: Text(
                  TasksService.formatDuration(task.duration),
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
