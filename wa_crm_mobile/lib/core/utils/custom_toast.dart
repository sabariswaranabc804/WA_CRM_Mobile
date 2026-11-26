
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  AppToast._();

  static void success(String message) {
    _show(message);
  }

  static void error([String? message]) {
    _show(message ?? 'An error occurred');
  }

  static void warning(String message) {
    _show(message);
  }

  static void info(String message) {
    _show(message);
  }

  static void _show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 5,
    );
  }
}
