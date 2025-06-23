import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';

class CreationDescriptionSection extends StatelessWidget {
  final Creation creation;

  const CreationDescriptionSection({
    super.key,
    required this.creation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            creation.description,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
