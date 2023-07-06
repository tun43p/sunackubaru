import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';
import 'package:sunackubaru/features/tasks/tasks_model.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';
import 'package:sunackubaru/features/tasks/tasks_service.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (state.status != null) const _TaskErrorWidget(),
          const _TasksTimerWidget(),
          const _TaskInputWidget(),
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

    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey.withOpacity(0.25),
        borderRadius: BorderRadius.circular(kDefaultPageSpace / 2),
      ),
      padding: const EdgeInsets.all(kDefaultPageSpace / 2),
      margin: const EdgeInsets.all(kDefaultPageSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                state.currentTask?.name ?? t.tasks.errors.no_current_task,
                style: TextStyle(
                  fontSize: 12,
                  color: CupertinoColors.systemGrey.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: kDefaultPageSpace / 2),
              Text(
                TasksService.formatDuration(state.duration),
                style: const TextStyle(
                  fontSize: 24,
                  color: CupertinoColors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <CupertinoButton>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: state.running ? notifier.stop : notifier.start,
                child: Icon(
                  state.running
                      ? CupertinoIcons.pause
                      : CupertinoIcons.play_arrow,
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed:
                    state.duration.inSeconds == 0 ? null : notifier.reset,
                child: const Icon(CupertinoIcons.stop),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskInputWidget extends StatelessWidget {
  const _TaskInputWidget();

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();
    final TasksProvider notifier = context.read<TasksProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPageSpace),
      child: CupertinoTextField(
        autofocus: true,
        enabled: state.currentTask == null,
        controller: state.textEditingController,
        keyboardType: TextInputType.text,
        placeholder: t.tasks.task_name,
        onEditingComplete: notifier.start,
      ),
    );
  }
}

class _TasksListWidget extends StatelessWidget {
  const _TasksListWidget();

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();
    final TasksProvider notifier = context.read<TasksProvider>();

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPageSpace),
      child: CupertinoListSection(
        margin: EdgeInsets.zero,
        topMargin: 0,
        children: state.tasks
            .map(
              (Task task) {
                final bool isCurrentTask = task.name == state.currentTask?.name;

                return CupertinoListTile(
                  key: ValueKey<String>(task.name),
                  title: Text(task.name),
                  additionalInfo: Text(
                    TasksService.formatDuration(task.duration),
                  ),
                  leading: Icon(
                    CupertinoIcons.doc_text,
                    color: isCurrentTask
                        ? CupertinoColors.systemGreen
                        : CupertinoColors.systemBlue,
                  ),
                  trailing: CupertinoButton(
                    onPressed: isCurrentTask && state.running
                        ? null
                        : () => unawaited(notifier.delete(task)),
                    child: const Icon(CupertinoIcons.delete),
                  ),
                  onTap: () => notifier.currentTask = task,
                );
              },
            )
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}

class _TaskErrorWidget extends StatelessWidget {
  const _TaskErrorWidget();

  @override
  Widget build(BuildContext context) {
    final TasksProvider state = context.watch<TasksProvider>();

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPageSpace,
        right: kDefaultPageSpace,
        left: kDefaultPageSpace,
      ),
      child: Text(
        state.status!.message,
        style: TextStyle(
          color: state.status!.type.color,
        ),
      ),
    );
  }
}
