import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/social_user.dart';
import 'package:flutter/cupertino.dart';

class AttendeesProvider with ChangeNotifier {
  Attendees? currentUser;
  SocialUser? socialUser;

  void setCurrentUser(Attendees user) {
    currentUser = user;
    notifyListeners();
  }

  void setSocialUser(SocialUser sUser) {
    socialUser = sUser;
  }

  Attendees? getCurrentUser() {
    return currentUser;
  }
}
