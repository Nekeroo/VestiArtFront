import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/ui/common/theme/app_radius.dart';
import 'package:vesti_art/ui/creation/details/widgets/reference_type_chip.dart';

class CreationReferenceSection extends StatelessWidget {
  final Creation creation;

  const CreationReferenceSection({super.key, required this.creation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Référence',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.m),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ReferenceTypeChip(type: creation.type),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    creation.reference,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          if (creation.idExternePdf != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('Voir le PDF'),
            ),
          ],
        ],
      ),
    );
  }
}
