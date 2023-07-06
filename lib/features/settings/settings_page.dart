import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(t.settings.title),
      ],
    );
  }
}
