import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/ui/admin/admin_panel.ViewModel.dart';

class AdminPanelView extends StatelessWidget {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminPanelViewModel>(
      create: (context) => AdminPanelViewModel()..loadArticles(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Admin Panel')),
            body: Consumer<AdminPanelViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Text('Articles');
              },
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     // Implement add new article functionality
            //   },
            //   child: const Icon(Icons.add),
            // ),
          );
        },
      ),
    );
  }
}
