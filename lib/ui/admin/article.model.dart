enum TypeEnum { Movie, Serie, Animed }

class Article {
  final int id;
  final String title;
  final String description;
  final String idExterne;
  final String image;
  final String pdf;
  final String tag1;
  final String tag2;
  final TypeEnum type;
  final DateTime dateCreate;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.idExterne,
    required this.image,
    required this.pdf,
    required this.tag1,
    required this.tag2,
    required this.type,
    required this.dateCreate,
  });
}
