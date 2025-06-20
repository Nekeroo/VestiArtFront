import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/ui/common/theme/app_radius.dart';

class ReferenceTypeChip extends StatelessWidget {
  final ReferenceType type;

  const ReferenceTypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: type.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.s),
        border: Border.all(color: type.color, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(type.icon, size: 16, color: type.color),
          const SizedBox(width: 4),
          Text(
            type.label,
            style: TextStyle(
              color: type.color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
