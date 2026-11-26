import 'dart:async';

const Duration kSearchDebounce = Duration(milliseconds: 350);

/// Delays execution until [duration] has passed without another run() call.
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer(this.duration);

  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
