import 'package:flutter/material.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatelessWidget {
  final Creation creation;
  const PdfViewerPage({super.key, required this.creation});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(creation.title)),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.5,
          height: screenHeight * 0.9,
          child: SfPdfViewer.network(creation.pdfUrl!),
        ),
      ),
    );
  }
}
