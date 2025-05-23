import 'package:flutter/material.dart';

class PromptingHeader extends StatelessWidget {
  final int remainingCreations;
  final int maxCreations;

  const PromptingHeader({
    super.key,
    required this.remainingCreations,
    required this.maxCreations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Générer des créations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Créez jusqu\'à $maxCreations designs de vêtements en décrivant ce que vous souhaitez.',
            style: TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          _buildCreationCounter(context),
        ],
      ),
    );
  }

  Widget _buildCreationCounter(BuildContext context) {
    final theme = Theme.of(context);
    final bool isLow = remainingCreations <= 1;
    
    return Row(
      children: [
        Icon(
          isLow ? Icons.warning_amber_rounded : Icons.check_circle_outline,
          size: 16,
          color: isLow 
              ? theme.colorScheme.error 
              : theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          'Créations restantes: $remainingCreations/$maxCreations',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isLow 
                ? theme.colorScheme.error 
                : theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
