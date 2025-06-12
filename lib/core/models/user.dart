enum PermissionLevel { unknown, guest, user, admin }

enum UserRole { admin, user, guest }

class User {
  final String username;
  final UserRole role;
  final String token;

  User({required this.username, required this.role, required this.token});

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      role: UserRole.values[json['role']],
      token: json['token'],
    );
  }
}
