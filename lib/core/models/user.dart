enum PermissionLevel { unknown, guest, user, admin }

class User {
  final String username;
  final PermissionLevel permissionLevel;
  final String token;

  User({
    required this.username,
    required this.permissionLevel,
    required this.token,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      permissionLevel: PermissionLevel.values[json['role']],
      token: json['token'],
    );
  }
}
