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

                return ListView.builder(
                  itemCount: viewModel.articles.length,
                  itemBuilder: (context, index) {
                    final article = viewModel.articles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 100,
                      ),
                      child: ListTile(
                        title: Text(article.title),
                        subtitle: Text(article.description),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // download pdf
                          },
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.download,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                // download pdf
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                //viewModel.deleteArticle(article.idExterne);
                                print('Delete article: ${article.idExterne}');
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          // preview pdf
                        },
                      ),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // add article
                print('Add new article');
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
