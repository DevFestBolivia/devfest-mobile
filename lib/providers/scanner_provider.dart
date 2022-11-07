import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScannerProvider extends ChangeNotifier {
  String? scannedValue;

  void scan() async {
    scannedValue = await scanner.scan();
  }
}
