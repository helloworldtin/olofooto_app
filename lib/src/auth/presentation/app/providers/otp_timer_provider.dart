import 'dart:async';

import 'package:flutter/material.dart';

class OtpTimerProvider with ChangeNotifier {
  int _count = 60;
  Timer? _timer;
  int get counter => _count;
  bool get canResend => _count == 1;

  void startTimer() {
    _count = 60;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (counter > 1) {
          _count--;
          notifyListeners();
        } else {
          _timer?.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
