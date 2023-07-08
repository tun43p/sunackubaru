import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/storage/storage_service.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';
import 'package:sunackubaru/features/settings/settings_provider.dart';
import 'package:sunackubaru/features/tasks/tasks_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.text =
        context.read<SettingsProvider>().gitHubToken ?? '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _onGitHubTokenEditingComplete() async {
    await GetIt.I
        .get<StorageService>()
        .setGitHubToken(_textEditingController.text);
  }

  Future<void> _onClearStoragePressed() async {
    // TODO(tun43p): Add validation popup

    await GetIt.I.get<StorageService>().clearStorage();

    if (context.mounted) {
      context.read<SettingsProvider>().gitHubToken =
          GetIt.I.get<StorageService>().gitHubToken;

      context.read<TasksProvider>().tasks = GetIt.I.get<StorageService>().tasks;

      _textEditingController.text =
          context.read<SettingsProvider>().gitHubToken ?? '';
    }
  }

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
            const SizedBox(height: kDefaultPageSpace),
            CupertinoTextField(
              controller: _textEditingController,
              placeholder: t.settings.github.placeholder,
              onEditingComplete: _onGitHubTokenEditingComplete,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(t.settings.storage.option),
                CupertinoButton(
                  onPressed: _onClearStoragePressed,
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
