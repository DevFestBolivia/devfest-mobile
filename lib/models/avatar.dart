class Avatar {
  final int id;
  final String path;
  Avatar({
    required this.id,
    required this.path,
  });
  static String background = "assets/avatars/background.png";
  static List<Avatar> listAvatart = [
    Avatar(id: 0, path: 'assets/avatars/avatar_0.png'),
    Avatar(id: 1, path: 'assets/avatars/avatar_1.png'),
    Avatar(id: 2, path: 'assets/avatars/avatar_2.png'),
    Avatar(id: 3, path: 'assets/avatars/avatar_3.png'),
    Avatar(id: 4, path: 'assets/avatars/avatar_4.png'),
    Avatar(id: 5, path: 'assets/avatars/avatar_5.png'),
    Avatar(id: 6, path: 'assets/avatars/avatar_6.png'),
    Avatar(id: 7, path: 'assets/avatars/avatar_7.png'),
    Avatar(id: 8, path: 'assets/avatars/avatar_8.png'),
    Avatar(id: 9, path: 'assets/avatars/avatar_9.png'),
    Avatar(id: 10, path: 'assets/avatars/avatar_10.png'),
    Avatar(id: 11, path: 'assets/avatars/avatar_11.png'),
    Avatar(id: 12, path: 'assets/avatars/avatar_12.png'),
    Avatar(id: 13, path: 'assets/avatars/avatar_13.png'),
    Avatar(id: 14, path: 'assets/avatars/avatar_14.png'),
    Avatar(id: 15, path: 'assets/avatars/avatar_15.png'),
    Avatar(id: 16, path: 'assets/avatars/avatar_16.png')
  ];

  static Avatar getAvatart(int id) {
    return listAvatart.where((element) => element.id == id).toList().first;
  }
}
