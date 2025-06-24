import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/creation/list/creation_list_viewmodel.dart';
import 'package:vesti_art/ui/creation/list/widget/filter_sheet.dart';

class SortSection extends StatelessWidget {
  const SortSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CreationListViewModel>(context);
    final sortList =
        Sort.values.where((sort) => sort != viewModel.sort).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSortChip(viewModel.sort, viewModel),
                      ...sortList.map((sort) => _buildSortChip(sort, viewModel)),
                    ],
                  ),
                ),
              ),
              _buildFilterButton(context, viewModel),
            ],
          ),
        ),
        _buildLoadingIndicator(viewModel),
      ],
    );
  }

  Widget _buildSortChip(Sort sort, CreationListViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: InputChip(
        label: Text(sort.label),
        selected: sort == viewModel.sort,
        onSelected: (selected) {
          viewModel.changeSort(sort);
        },
      ),
    );
  }

  Widget _buildLoadingIndicator(CreationListViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 4),
        child: LinearProgressIndicator(),
      );
    }
    return const SizedBox(height: 8);
  }

  Widget _buildFilterButton(BuildContext context, CreationListViewModel viewModel) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () => _showFilterSheet(context, viewModel),
      tooltip: 'Filtres',
    );
  }

  void _showFilterSheet(BuildContext context, CreationListViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => FilterSheet(
        currentReferenceType: viewModel.referenceType,
        currentSort: viewModel.sort,
        changeReferenceType: viewModel.changeReferenceType,
        changeSort: viewModel.changeSort,
      ),
    );
  }
}
