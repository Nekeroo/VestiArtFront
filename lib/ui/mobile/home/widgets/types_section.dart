import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/routing/app_routes.dart';

class TypesSection extends StatelessWidget {
  const TypesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.category_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Catégories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTypeButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildTypeButton(context, ReferenceType.movie)),
        const SizedBox(width: 12),
        Expanded(child: _buildTypeButton(context, ReferenceType.serie)),
        const SizedBox(width: 12),
        Expanded(child: _buildTypeButton(context, ReferenceType.anime)),
      ],
    );
  }

  Widget _buildTypeButton(BuildContext context, ReferenceType type) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.creationList, arguments: type);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: type.color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(type.icon, color: type.color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                type.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
