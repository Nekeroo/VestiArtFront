import 'package:flutter/material.dart';

/// Un widget qui adapte son contenu en fonction de la taille d'écran disponible
class ResponsiveLayoutBuilder extends StatelessWidget {
  /// La fonction builder qui reçoit le contexte et les contraintes de taille
  final Widget Function(BuildContext, BoxConstraints) builder;

  /// La largeur maximale du contenu sur grand écran
  final double maxWidth;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.builder,
    this.maxWidth = 600,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > maxWidth;

        // Sur desktop, on centre le contenu avec une largeur maximale
        // Sur mobile, on utilise toute la largeur disponible
        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? maxWidth : constraints.maxWidth,
            ),
            child: builder(context, constraints),
          ),
        );
      },
    );
  }
}
