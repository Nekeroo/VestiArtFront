enum TypeEnum {
  movie,
  serie,
  anime;

  String get label {
    switch (this) {
      case TypeEnum.movie:
        return 'Movie';
      case TypeEnum.serie:
        return 'Serie';
      case TypeEnum.anime:
        return 'Anime';
    }
  }

  static TypeEnum fromString(String value) {
    return TypeEnum.values.firstWhere(
      (e) => e.toString().toLowerCase() == value.toLowerCase(),
      orElse: () => TypeEnum.movie,
    );
  }
}

class Article {
  final String title;
  final String description;
  final String idExterne;
  final String imageUrl;
  final String tag1;
  final String tag2;
  final TypeEnum type;
  final DateTime dateCreate;

  Article({
    required this.title,
    required this.description,
    required this.idExterne,
    required this.imageUrl,
    required this.tag1,
    required this.tag2,
    required this.type,
    required this.dateCreate,
  });
}
