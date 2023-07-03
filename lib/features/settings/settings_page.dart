import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sunackubaru/features/settings/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsProvider state = context.watch<SettingsProvider>();
    final SettingsProvider notifier = context.read<SettingsProvider>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoButton.filled(
          onPressed: state.code != null ? null : notifier.connectToGitHub,
          child: const Text('Connect'),
        ),
        const SizedBox(height: 16),
        Text(
          state.code ?? 'Not connected',
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
