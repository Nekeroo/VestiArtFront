import 'package:flutter/material.dart';

class AppElevation {
  static const List<BoxShadow> low = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      blurRadius: 1.0,
      offset: Offset(0, 1),
    ),
  ];
  static const List<BoxShadow> medium = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 8.0,
      offset: Offset(0, 4),
    ),
  ];
  static const List<BoxShadow> high = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.15),
      blurRadius: 24.0,
      offset: Offset(0, 8),
    ),
  ];
}
