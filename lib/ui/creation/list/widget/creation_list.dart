import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/common/widgets/creation_card.dart';

class CreationList extends StatefulWidget {
  final List<Creation> creations;
  final Sort sort;
  final Function() loadMore;
  final bool isLoading;

  const CreationList({
    super.key,
    required this.creations,
    required this.sort,
    required this.loadMore,
    required this.isLoading,
  });

  @override
  State<CreationList> createState() => _CreationListState();
}

class _CreationListState extends State<CreationList> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      widget.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Creation> creations = widget.creations;

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemCount: creations.length + 1,
      itemBuilder: (BuildContext c, int index) {
        if (index == 0) {
          return _buildLoadingIndicator();
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

  Widget _buildLoadingIndicator() {
    if (widget.isLoading) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: LinearProgressIndicator(),
      );
    }
    return const SizedBox(height: 8);
  }
}
