import 'package:vesti_art/core/models/creation.dart';

class CreationDraft {
  String uuid;
  String name;
  String promptText;
  String reference;
  ReferenceType referenceType;

  CreationDraft({
    String? uuid,
    this.name = '',
    this.promptText = '',
    this.reference = '',
    this.referenceType = ReferenceType.anime,
  }) : uuid = uuid ?? DateTime.now().millisecondsSinceEpoch.toString();

  bool get isValid {
    return name.isNotEmpty && promptText.isNotEmpty && reference.isNotEmpty;
  }

  CreationDraft copy() {
    return CreationDraft(
      uuid: uuid,
      name: name,
      promptText: promptText,
      reference: reference,
      referenceType: referenceType,
    );
  }
}
