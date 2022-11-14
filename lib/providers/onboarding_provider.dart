import 'package:flutter/material.dart';

class OnboardingProvider extends ChangeNotifier {
  OnboardingProvider() {
    pageIndex = 0;
  }
  late int pageIndex;

  void changePage(int? newIndex) {
    if (newIndex != null) {
      pageIndex = newIndex;
      notifyListeners();
    }
  }
}
