import 'package:devfestbolivia/firebase/profile/profile_repository.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  EditProfileProvider(
      {required Profile initialProfile,
      required ProfileRepository profileRepository})
      : _profile = initialProfile,
        _profileRepository = profileRepository;

  final Profile _profile;
  final ProfileRepository _profileRepository;

  void initProfile() {
    setFullName(_profile.fullName);
    setAboutYou(_profile.bio);
    setAvatar(_profile.avatar);
    setInstagram(_profile.instagramUrl);
    setFacebook(_profile.facebookUrl);
    setTwitter(_profile.twitterUrl);
  }

  Profile get profile => _profile;
  void setFullName(String fullName) {
    _profile.fullName = fullName;
  }

  void setAvatar(int avatarId) {
    _profile.avatar = avatarId;
  }

  void setAboutYou(String aboutYou) {
    _profile.bio = aboutYou;
  }

  void setInstagram(String instagram) {
    _profile.instagramUrl = instagram;
  }

  void setFacebook(String facebook) {
    _profile.facebookUrl = facebook;
  }

  void setTwitter(String twitter) {
    _profile.twitterUrl = twitter;
  }

  Future<void> edit() async {
    try {
      await _profileRepository.updateProfileData(_profile);
    } catch (e) {
      rethrow;
    }
  }
}
