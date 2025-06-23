import 'package:vesti_art/core/models/creation.dart';

class CreationsResponse {
  final int? nextKey;
  final List<Creation> creations;

  CreationsResponse({required this.nextKey, required this.creations});

  static CreationsResponse fromJson(Map<String, dynamic> json) {
    return CreationsResponse(
      nextKey: json['nextKey'],
      creations: Creation.fromJsonList(json['ideas']),
    );
  }
}
