import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:vesti_art/core/models/creation.dart';

class CreationDescriptionSection extends StatelessWidget {
  final Creation creation;

  const CreationDescriptionSection({super.key, required this.creation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return creation.description.isNotEmpty
        ? Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
                'Description',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              MarkdownWidget(
                data: creation.description,
                config: MarkdownConfig(
                  configs: [
                    PConfig(
                      textStyle: theme.textTheme.bodyLarge ?? const TextStyle(),
                    ),
                    LinkConfig(
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    CodeConfig(
                      style: TextStyle(
                        fontFamily: 'monospace',
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        )
        : const SizedBox.shrink();
  }
}
