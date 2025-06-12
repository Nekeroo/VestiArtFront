enum PermissionLevel { unknown, guest, user, admin }

enum UserRole { admin, user, guest }

class User {
  final String username;
  final List<UserRole> roles;
  final String token;

  User({required this.username, required this.roles, required this.token});

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      roles:
          json['roles'].map<UserRole>((role) => UserRole.values[role]).toList(),
      token: json['tokenJwt'],
    );
  }
}
