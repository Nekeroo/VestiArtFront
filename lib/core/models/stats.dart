class StatsData {
  final int users;
  final int creations;

  StatsData({required this.users, required this.creations});

  factory StatsData.fromJson(Map<String, dynamic> json) {
    return StatsData(users: json['nbUsers'], creations: json['nbCreations']);
  }
}
