import 'package:vesti_art/core/models/reference_type.dart';

class Creation {
  final String uuid;
  final String name;
  final String text;
  final String image;
  final String reference;
  final ReferenceType referenceType;

  Creation({
    required this.uuid,
    required this.name,
    required this.text,
    required this.image,
    required this.reference,
    required this.referenceType,
  });
}
