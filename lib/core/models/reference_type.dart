enum ReferenceType {
  unknown,
  movies,
  series,
  animes,
  books,
  mangas;

  static ReferenceType fromString(String value) {
    return ReferenceType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ReferenceType.unknown,
    );
  }

  static List<ReferenceType> get all {
    List<ReferenceType> result = List.from(ReferenceType.values);
    result.remove(ReferenceType.unknown);
    return result;
  }

  String get displayName {
    switch (this) {
      case ReferenceType.animes:
        return 'Anime';
      case ReferenceType.mangas:
        return 'Manga';
      case ReferenceType.books:
        return 'Livre';
      case ReferenceType.movies:
        return 'Film';
      case ReferenceType.series:
        return 'Série';
      case ReferenceType.unknown:
        return 'Inconnu';
    }
  }
}
