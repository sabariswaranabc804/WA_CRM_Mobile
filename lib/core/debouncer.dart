import 'dart:async';

import 'package:flutter/foundation.dart';

/// Collapses a burst of calls into one, used to keep search boxes from firing
/// a request per keystroke.
///
/// Remember to [dispose] it alongside the state that owns it.
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() => _timer?.cancel();
}
