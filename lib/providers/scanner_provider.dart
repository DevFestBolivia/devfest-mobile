import 'dart:convert';

import 'package:devfestbolivia/models/dynamic.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

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
          dynamicResult = DynamicQRResult.fromJson(decodedValue);

          final existsDynamic = _profileProvider
              .dynamicAlreadyExistsByValue(dynamicResult!.value);

          if (existsDynamic) {
            throw Exception('Already exists dynamic');
          }

          state = ScannerState.scannedDynamic;
          _profileProvider.addDynamic(dynamicResult!);
          notifyListeners();
          return;
        }
      } else {
        final existsFriend =
            _profileProvider.friendAlreadyExists(_scannedValue!);

        if (existsFriend) {
          throw Exception('Already exists friend');
        }

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

  Future<void> scanFromWeb(BuildContext context) async {
    try {
      _scannedValue = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SimpleBarcodeScannerPage(),
        ),
      );
      if (_scannedValue == null) {
        return;
      }

      if (_scannedValue!.contains('{') || _scannedValue!.contains('}')) {
        final Map<String, dynamic> decodedValue = json.decode(_scannedValue!);
        if (decodedValue['type'] == 'dynamic') {
          dynamicResult = DynamicQRResult.fromJson(decodedValue);

          final existsDynamic = _profileProvider
              .dynamicAlreadyExistsByValue(dynamicResult!.value);

          if (existsDynamic) {
            throw Exception('Already exists dynamic');
          }

          state = ScannerState.scannedDynamic;
          _profileProvider.addDynamic(dynamicResult!);
          notifyListeners();
          return;
        }
      } else {
        final existsFriend =
            _profileProvider.friendAlreadyExists(_scannedValue!);

        if (existsFriend) {
          throw Exception('Already exists friend');
        }

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
