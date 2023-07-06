import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/storage/storage_service.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPageSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              t.settings.title,
              style: const TextStyle(fontSize: 24),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(t.settings.storage.option),
                CupertinoButton(
                  onPressed: () async {
                    await StorageService.clearStorage();

                    if (context.mounted) {
                      context.read<TasksProvider>().tasks =
                          await StorageService.getTasks();
                    }
                  },
                  child: const Icon(CupertinoIcons.delete),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
