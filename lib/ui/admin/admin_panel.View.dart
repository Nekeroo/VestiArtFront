import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/networking/api_creation.dart';
import 'package:vesti_art/ui/admin/admin_panel.ViewModel.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

void showDeleteConfirmation(
  BuildContext context,
  Creation article,
  AdminPanelViewModel viewModel,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Article'),
        content: Text(
          'Are you sure you want to delete the article ${article.title}?',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              viewModel.deleteArticle(article.idExternePdf!);
              ApiCreation.instance.delete(article.idExternePdf!);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

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
                        subtitle: Text(article.dateCreate.toString()),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            // PDFView(
                            //   filePath: article.idExternePdf,
                            //   enableSwipe: true,
                            //   swipeHorizontal: true,
                            //   autoSpacing: false,
                            //   pageFling: false,
                            //   onError: (error) {
                            //     print(error.toString());
                            //   },
                            //   onPageError: (page, error) {
                            //     print('$page: ${error.toString()}');
                            //   },
                            // );
                            // preview pdf
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
                              onPressed:
                                  () => showDeleteConfirmation(
                                    context,
                                    article,
                                    viewModel,
                                  ),
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
