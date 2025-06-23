import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';

class CreationPdfSection extends StatelessWidget {
  final Creation creation;

  const CreationPdfSection({super.key, required this.creation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return creation.idExternePdf != null && creation.idExternePdf!.isNotEmpty
        ? Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.outlineVariant,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Additional Resources',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('View Reference PDF'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: creation.type.color.withValues(alpha: 0.1),
                  foregroundColor: creation.type.color,
                ),
              ),
            ],
          ),
        )
        : const SizedBox.shrink();
  }
}
