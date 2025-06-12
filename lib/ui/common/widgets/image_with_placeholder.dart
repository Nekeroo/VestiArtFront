import 'package:flutter/material.dart';

class ImageColors {
  static const Color placeholderColor = Color(0xFFEEEEEE);
}

class ImageWithPlaceholder extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageWithPlaceholder({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Image.network(
          imageUrl,
          fit: fit,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingPlaceholder();
          },
          errorBuilder: (context, error, stackTrace) {
            return _buildPlaceholder();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Stack(
      alignment: Alignment.center,
      children: [_buildPlaceholder(), const CircularProgressIndicator()],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      color: ImageColors.placeholderColor,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 40,
          color: Colors.grey,
        ),
      ),
    );
  }
}
