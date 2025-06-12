enum ReferenceType {
  movie,
  serie,
  anime;

  String get label {
    switch (this) {
      case ReferenceType.movie:
        return 'Movie';
      case ReferenceType.serie:
        return 'Serie';
      case ReferenceType.anime:
        return 'Anime';
    }
  }

  static ReferenceType fromString(String value) {
    return ReferenceType.values.firstWhere(
      (e) => e.toString().toLowerCase() == value.toLowerCase(),
      orElse: () => ReferenceType.movie,
    );
  }
}

class Creation {
  final String title;
  final String description;
  final String idExterne;
  final String imageUrl;
  final String person;
  final String reference;
  final ReferenceType type;
  final DateTime dateCreate;

  Creation({
    required this.title,
    required this.description,
    required this.idExterne,
    required this.imageUrl,
    required this.person,
    required this.reference,
    required this.type,
    required this.dateCreate,
  });

  static Creation fromJson(Map<String, dynamic> json) {
    return Creation(
      title: json['title'],
      description: json['description'],
      idExterne: json['idExterneImage'],
      imageUrl: json['imageUrl'],
      person: json['tag1'],
      reference: json['tag2'],
      type: ReferenceType.fromString(json['type']),
      dateCreate: DateTime.parse(json['dateCreate']),
    );
  }

  static List<Creation> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Creation.fromJson(json)).toList();
  }
}
