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
      (e) => e.toString().split('.').last.toLowerCase() == value.toLowerCase(),
      orElse: () => ReferenceType.movie,
    );
  }
}

class Creation {
  final String title;
  final String description;
  final String idExterne;
  final String idExternePdf;
  final String imageUrl;
  final String person;
  final String reference;
  final ReferenceType type;
  final DateTime dateCreate;

  Creation({
    required this.title,
    required this.description,
    required this.idExterne,
    required this.idExternePdf,
    required this.imageUrl,
    required this.person,
    required this.reference,
    required this.type,
    required this.dateCreate,
  });

  static List<String> checkNullFields(Map<String, dynamic> json) {
    List<String> nullFields = [];

    if (json['title'] == null) nullFields.add('title');
    if (json['description'] == null) nullFields.add('description');
    if (json['idExterneImage'] == null) nullFields.add('idExterneImage');
    if (json['idExternePdf'] == null) nullFields.add('idExternePdf');
    if (json['imageUrl'] == null) nullFields.add('imageUrl');
    if (json['tag1'] == null) nullFields.add('tag1');
    if (json['tag2'] == null) nullFields.add('tag2');
    if (json['type'] == null) nullFields.add('type');
    if (json['dateCreate'] == null) nullFields.add('dateCreate');

    return nullFields;
  }

  static Creation fromJson(Map<String, dynamic> json) {
    List<String> nullFields = checkNullFields(json);

    if (nullFields.isNotEmpty) {
      print(
        'Invalid JSON data. The following fields are null: ${nullFields.join(", ")}',
      );
    }

    return Creation(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      idExterne: json['idExterneImage'] ?? 'No ID',
      idExternePdf: json['idExternePdf'] ?? 'No PDF ID',
      imageUrl: json['imageUrl'] ?? 'No Image URL',
      person: json['tag1'] ?? 'No Person',
      reference: json['tag2'] ?? 'No Reference',
      type: ReferenceType.fromString(json['type'] ?? 'movie'),
      dateCreate: DateTime.parse(
        json['dateCreate'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  static List<Creation> fromJsonList(List<dynamic> jsonList) {
    print("Parsing Creation List from JSON: ${jsonList.length}");
    for (var json in jsonList) {
      print("ICI");
      if (json["idExternePdf"] == null) {
        json["idExternePdf"] = "No ID";
      } else if (json["pdfUrl"] == null) {
        json["pdfUrl"] = "No PDF URL";
      }
      print("Parsing Creation from JSON: ${Creation.fromJson(json)}");
    }
    return jsonList.map((json) => Creation.fromJson(json)).toList();
  }
}
