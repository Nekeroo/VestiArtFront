import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final Creation creation;
  const PdfViewerPage({super.key, required this.creation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(creation.title)),
      body: SizedBox(child: SfPdfViewer.network(creation.pdfUrl!)),
    );
  }
}
