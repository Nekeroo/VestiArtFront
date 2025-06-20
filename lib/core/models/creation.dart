import 'package:flutter/material.dart';

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

  Color get color {
    switch (this) {
      case ReferenceType.movie:
        return Colors.redAccent;
      case ReferenceType.serie:
        return Colors.blueAccent;
      case ReferenceType.anime:
        return Colors.purpleAccent;
    }
  }

  IconData get icon {
    switch (this) {
      case ReferenceType.movie:
        return Icons.movie;
      case ReferenceType.serie:
        return Icons.tv;
      case ReferenceType.anime:
        return Icons.animation;
    }
  }

  static ReferenceType fromString(String value) {
    return ReferenceType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => ReferenceType.movie,
    );
  }
}

class Creation {
  final String title;
  final String description;
  final String idExterneImage;
  final String? idExternePdf;
  final String imageUrl;
  final String? pdfUrl;
  final String person;
  final String reference;
  final ReferenceType type;
  final DateTime dateCreate;

  Creation({
    required this.title,
    required this.description,
    required this.idExterneImage,
    required this.idExternePdf,
    required this.imageUrl,
    required this.pdfUrl,
    required this.person,
    required this.reference,
    required this.type,
    required this.dateCreate,
  });

  static Creation? fromJson(Map<String, dynamic> json) {
    try {
      return Creation(
        title: json['title'],
        description: json['description'],
        idExterneImage: json['idExterneImage'],
        idExternePdf: json['idExternePdf'],
        imageUrl: json['imageUrl'],
        pdfUrl: json['pdfUrl'],
        person: json['tag1'],
        reference: json['tag2'],
        type: ReferenceType.fromString(json['type']),
        dateCreate: DateTime.parse(json['dateCreate']),
      );
    } catch (e) {
      return null;
    }
  }

  static List<Creation> fromJsonList(List<dynamic> data) {
    return data
        .map((json) => Creation.fromJson(json))
        .whereType<Creation>()
        .toList();
  }
}
