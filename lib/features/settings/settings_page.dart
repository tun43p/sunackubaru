import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // TODO(tun43p): Connect to GitHub
        CupertinoButton.filled(
          onPressed: null,
          child: Text('Connect to GitHub'),
        )
      ],
    );
  }
}
