import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/common/widgets/creation_card.dart';
import 'package:vesti_art/ui/creation/list/widget/sort_section.dart';

class CreationList extends StatelessWidget {
  final List<Creation> creations;
  final Sort sort;
  final Function(Sort) onSortChange;

  const CreationList({
    super.key,
    required this.creations,
    required this.sort,
    required this.onSortChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemCount: creations.length + 1,
      itemBuilder: (BuildContext c, int index) {
        if (index == 0) {
          return SortSection();
        }

        final creation = creations[index - 1];

        return CreationCard(
          creation: creation,
          onTap:
              () => {
                Navigator.pushNamed(
                  c,
                  AppRoutes.creationDetails,
                  arguments: creation,
                ),
              },
        );
      },
    );
  }
}
