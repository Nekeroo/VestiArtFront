import 'package:flutter/material.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import '../../../../core/models/creation.dart';
import '../../../common/widgets/image_with_placeholder.dart';

class CreationCarousel extends StatelessWidget {
  final List<Creation> creations;
  final String title;
  final IconData icon;
  final String emptyMessage;

  const CreationCarousel({
    super.key,
    required this.creations,
    required this.title,
    required this.icon,
    required this.emptyMessage,
  });

  _navigateToDetails(BuildContext context, Creation creation) {
    Navigator.of(
      context,
    ).pushNamed(AppRoutes.creationDetails, arguments: creation);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleSection(context),
            const SizedBox(height: 16),
            _buildCreationsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.secondary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.secondary,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              const Text('Voir tout'),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward,
                size: 16,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCreationsList(BuildContext context) {
    if (creations.isEmpty) {
      return _buildEmptyState(context);
    }

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: creations.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: EdgeInsets.only(
              right: index != creations.length - 1 ? 16 : 0,
            ),
            child: _buildCreationCard(context, creations[index]),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 48,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Aucune création',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreationCard(BuildContext context, Creation creation) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: theme.cardColor,
          child: InkWell(
            onTap: () => _navigateToDetails(context, creation),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageWithPlaceholder(
                  imageUrl: creation.imageUrl,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creation.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        creation.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
