import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';

class CreationImageSection extends StatelessWidget {
  final Creation creation;

  const CreationImageSection({super.key, required this.creation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: creation.idExterneImage,
            child: Image.network(
              creation.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value:
                        loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.broken_image,
                    size: 80,
                    color: theme.colorScheme.error,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
