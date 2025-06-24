import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/creation/list/creation_list_viewmodel.dart';
import 'package:vesti_art/ui/creation/list/widget/creation_list.dart';
import 'package:vesti_art/ui/creation/list/widget/filter_sheet.dart';

class CreationListPage extends StatefulWidget {
  final Sort sort;
  final ReferenceType referenceType;
  const CreationListPage({
    super.key,
    required this.sort,
    this.referenceType = ReferenceType.all,
  });

  @override
  State<StatefulWidget> createState() => _CreationListPageState();
}

class _CreationListPageState extends State<CreationListPage> {
  late final CreationListViewModel viewModel;

  @override
  void initState() {
    viewModel = CreationListViewModel(
      sort: widget.sort,
      referenceType: widget.referenceType,
    );
    super.initState();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Liste des créations'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => _showFilterSheet(context, viewModel),
              tooltip: 'Filtres',
            ),
          ],
        ),
        body: Consumer<CreationListViewModel>(
          builder: (context, viewModel, _) {
            return viewModel.isLoading && viewModel.creations.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : CreationList(
                  creations: viewModel.creations,
                  sort: viewModel.sort,
                  isLoading: viewModel.isLoading,
                  loadMore: () => viewModel.loadCreations(fromStart: false),
                );
          },
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context, CreationListViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => FilterSheet(
            currentReferenceType: viewModel.referenceType,
            currentSort: viewModel.sort,
            changeReferenceType: viewModel.changeReferenceType,
            changeSort: viewModel.changeSort,
          ),
    );
  }
}
