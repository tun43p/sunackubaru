import 'package:flutter/cupertino.dart';

class SettingsProvider with ChangeNotifier {
  String? _gitHubToken;
  String? get gitHubToken => _gitHubToken;
  set gitHubToken(String? newGitHubToken) {
    _gitHubToken = newGitHubToken;
    notifyListeners();
  }
}
