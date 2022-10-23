class SocialUser {
  String? displayName;
  String? email;
  String? photoUrl;
  String? serverAuthCode;
  bool success = false;

  SocialUser({
    this.displayName,
    this.email,
    this.photoUrl,
    this.serverAuthCode,
    this.success = false,
  });
}