import 'package:devfestbolivia/firebase/profile/profile_repository.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/dynamic.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:flutter/material.dart';

enum ProfileState {
  initial,
  loading,
  loaded,
  failure,
}

class ProfileProvider extends ChangeNotifier {
  ProfileProvider({
    required ProfileRepository profileRepository,
    required this.attendee,
  }) : _profileRepository = profileRepository;

  final ProfileRepository _profileRepository;
  final Attendees attendee;

  late Profile profile;
  ProfileState state = ProfileState.initial;
  String errorMessage = '';

  void initProfile() async {
    try {
      state = ProfileState.loading;
      notifyListeners();
      profile = await _profileRepository.getProfileByAttendee(attendee);
      state = ProfileState.loaded;
      notifyListeners();
    } catch (e) {
      errorMessage = 'No se pudo cargar el perfil';
      state = ProfileState.failure;
      notifyListeners();
      rethrow;
    }
  }

  void addDynamic(DynamicQRResult result) async {
    final qrDynamicScan = QrDynamicScan(
      value: result.value,
      score: result.score,
    );

    profile.qrDynamicScans.add(qrDynamicScan);
    profile.score = profile.score + result.score;
    await _profileRepository.updateProfileData(profile);
  }

  void addFriend(Friend friend) async {
    profile.friends.add(friend);
    profile.score = profile.score + 10.0;
    await _profileRepository.updateProfileData(profile);
  }

  Future<Profile> getProfileById(String id) async {
    try {
      return await _profileRepository.getProfileById(id);
    } catch (e) {
      rethrow;
    }
  }
}
