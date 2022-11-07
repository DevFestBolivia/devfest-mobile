import 'dart:convert';

import 'package:devfestbolivia/models/dynamic.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

enum ScannerState {
  notScannedYet,
  scannedFriend,
  scannedDynamic,
  scanResultInvalid,
}

class ScannerProvider extends ChangeNotifier {
  String? _scannedValue;

  Friend? friendResult;
  DynamicQRResult? dynamicResult;

  ScannerState state = ScannerState.notScannedYet;

  Future<void> scan() async {
    try {
      _scannedValue = await scanner.scan();
      if (_scannedValue == null) {
        return;
      }
      final Map<String, dynamic> decodedValue = json.decode(_scannedValue!);

      print(decodedValue['type']);

      if (decodedValue['type'] == 'friend') {
        state = ScannerState.scannedFriend;
        friendResult = Friend.fromJson(decodedValue['value']);
        notifyListeners();
        return;
      }

      if (decodedValue['type'] == 'dynamic') {
        state = ScannerState.scannedDynamic;
        dynamicResult = DynamicQRResult.fromJson(decodedValue);
        notifyListeners();
        return;
      }

      state = ScannerState.scanResultInvalid;
      notifyListeners();
    } catch (e) {
      state = ScannerState.scanResultInvalid;
      notifyListeners();
      rethrow;
    }
  }
}
