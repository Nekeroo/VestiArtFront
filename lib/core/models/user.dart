enum UserRole {
  admin,
  user,
  guest;

  static List<UserRole> fromString(List<dynamic> roles) {
    return roles.map((role) => _fromString(role)).toList();
  }

  static UserRole _fromString(dynamic role) {
    return UserRole.values.firstWhere(
      (r) => r.name == role['name'].toString().toLowerCase(),
      orElse: () => UserRole.guest,
    );
  }
}

class User {
  final String username;
  final List<UserRole> roles;
  final String token;

  User({required this.username, required this.roles, required this.token});

  static User fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      roles: UserRole.fromString(json['roles'] as List<dynamic>),
      token: json['token'],
    );
  }
}
