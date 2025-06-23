import 'dart:html' as html;
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;
import 'package:vesti_art/core/models/creation.dart';

Future<bool> downloadPdf(Creation article) async {
  // Create an anchor element
  await pw.Document().save();
  final anchor = html.AnchorElement(href: article.pdfUrl)
    ..setAttribute('download', 'document.pdf')
    ..text = 'Download PDF'
    ..click();
    
  final file = File('example.pdf');
  try {
    await file.writeAsBytes(await pw.Document().save());
    return true;
  } catch (e) {
    print('Error saving PDF: $e');
    return false;
  } finally {
    // Clean up the anchor element
    anchor.remove();
  }
}

  // anchor.click();
  // html.document.body?.children.remove(anchor);
  
  //  AnchorElement(
//         href:
//             "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
//       ..setAttribute("download", "report.pdf")
//       ..click();

//     //Dispose the document