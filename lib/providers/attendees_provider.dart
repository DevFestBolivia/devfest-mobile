import 'package:devfestbolivia/models/attendees.dart';
import 'package:flutter/cupertino.dart';

class AttendeesProvider with ChangeNotifier {
  Attendees? currentUser;

  void setCurrentUser(Attendees user) {
    currentUser = user;
    notifyListeners();
  }

  Attendees? getCurrentUser() {
    return currentUser;
  }
}