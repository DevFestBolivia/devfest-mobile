import 'dart:convert';

import 'package:devfestbolivia/firebase/profile/profile_repository.dart';
import 'package:devfestbolivia/models/dynamic.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

enum ScannerState {
  notScannedYet,
  scannedFriend,
  scannedDynamic,
  scanResultInvalid,
}

class ScannerProvider extends ChangeNotifier {
  ScannerProvider({
    required ProfileProvider profileProvider,
  }) : _profileProvider = profileProvider;

  final ProfileProvider _profileProvider;

  void reset() {
    _scannedValue = null;
    friendResult = null;
    dynamicResult = null;
    state = ScannerState.notScannedYet;
  }

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

      if (_scannedValue!.contains('{') || _scannedValue!.contains('}')) {
        final Map<String, dynamic> decodedValue = json.decode(_scannedValue!);
        if (decodedValue['type'] == 'dynamic') {
          state = ScannerState.scannedDynamic;
          dynamicResult = DynamicQRResult.fromJson(decodedValue);
          _profileProvider.addDynamic(dynamicResult!);
          notifyListeners();
          return;
        }
      } else {
        state = ScannerState.scannedFriend;
        final profile = await _profileProvider.getProfileById(_scannedValue!);
        final newFriend = Friend(
          uid: profile.uid,
          fullName: profile.fullName,
          imageUrl: profile.imageUrl,
        );
        friendResult = newFriend;
        _profileProvider.addFriend(newFriend);
        notifyListeners();
        return;
      }
    } catch (e) {
      state = ScannerState.scanResultInvalid;
      notifyListeners();
      rethrow;
    }
  }
}
