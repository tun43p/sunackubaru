import 'dart:async';

import 'package:flutter/cupertino.dart';

enum StatusType {
  error(CupertinoColors.systemRed),
  success(CupertinoColors.systemGreen),
  warning(CupertinoColors.systemOrange);

  const StatusType(this.color);

  final Color color;
}

class StatusProvider with ChangeNotifier {
  late Timer _timer;

  StatusType? _type;
  StatusType? get type => _type;

  String? _message;
  String? get message => _message;

  void set(StatusType type, {required String message}) {
    _type = type;
    _message = message;
    notifyListeners();

    _timer = Timer(const Duration(seconds: 3), () {
      _type = null;
      _message = null;
      _timer.cancel();

      notifyListeners();
    });
  }
}
