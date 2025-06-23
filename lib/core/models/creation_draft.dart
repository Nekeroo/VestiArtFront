import 'package:vesti_art/core/models/creation.dart';

class CreationDraft {
  String uuid;
  String person;
  String reference;
  ReferenceType type;

  CreationDraft({
    String? uuid,
    this.person = '',
    this.reference = '',
    this.type = ReferenceType.anime,
  }) : uuid = uuid ?? DateTime.now().millisecondsSinceEpoch.toString();

  bool get isValid {
    return person.isNotEmpty && reference.isNotEmpty;
  }

  CreationDraft copy() {
    return CreationDraft(
      uuid: uuid,
      person: person,
      reference: reference,
      type: type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'person': person,
      'reference': reference,
      'type': type.name.toUpperCase(),
    };
  }
}

extension CreationDraftListExtension on List<CreationDraft> {
  List<Map<String, dynamic>> toJson() {
    return map((draft) => draft.toJson()).toList();
  }
}
