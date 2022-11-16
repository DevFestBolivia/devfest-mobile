import 'package:flutter/foundation.dart';

class PrintUtil {
  static void debugPrint(String text) {
    if (kDebugMode) {
      print(text);
    }
  }
}