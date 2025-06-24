import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/core/routing/app_routes.dart';
import 'package:vesti_art/core/services/authentication_service.dart';
import 'package:vesti_art/ui/admin/admin_panel.ViewModel.dart';
import 'package:vesti_art/ui/pdf_viewer/pdf_downloader.dart';

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
              viewModel.deleteArticle(article.idExternePdf!, context);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class AdminPanelView extends StatefulWidget {
  const AdminPanelView({super.key});

  @override
  State<AdminPanelView> createState() => _AdminPanelViewState();
}

class _AdminPanelViewState extends State<AdminPanelView> {
  @override
  Widget build(BuildContext context) {
    // ensure that user is admin
    if (!AuthenticationService.instance.isAuthenticated ||
        AuthenticationService.instance.currentUser == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return Container();
    } else {
      print(
        'User is authenticated: ${AuthenticationService.instance.currentUser?.username}',
      );
    }
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
                            print(
                              'Opening PDF for article: ${article.title} ${article.idExternePdf}',
                            );
                            // Navigate to PDF viewer
                            Navigator.of(context).pushNamed(
                              AppRoutes.pdfViewer,
                              arguments: article,
                            );
                            print('PDF path: ${article.pdfUrl}');
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
                                print(
                                  'Downloading PDF for article: ${article.title}',
                                );
                                downloadPdf(article);
                                print('PDF URL: ${article.pdfUrl}');
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
                Navigator.of(context).pushNamed(AppRoutes.prompting);
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
