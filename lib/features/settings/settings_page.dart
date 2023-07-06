import 'package:flutter/cupertino.dart';
import 'package:sunackubaru/core/i18n/i18n.g.dart';
import 'package:sunackubaru/core/theme/theme_constants.dart';

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
          ],
        ),
      ),
    );
  }
}
