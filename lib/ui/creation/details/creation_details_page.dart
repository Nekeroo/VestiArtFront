import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vesti_art/core/models/creation.dart';
import 'package:vesti_art/ui/creation/details/widgets/creation_description_section.dart';
import 'package:vesti_art/ui/creation/details/widgets/creation_header_section.dart';
import 'package:vesti_art/ui/creation/details/widgets/creation_image_section.dart';
import 'package:vesti_art/ui/creation/details/widgets/creation_pdf_section.dart';
import 'package:vesti_art/ui/creation/details/widgets/missing_creation_view.dart';

class CreationDetailsPage extends StatelessWidget {
  final Creation? creation;

  const CreationDetailsPage({super.key, this.creation});

  @override
  Widget build(BuildContext context) {
    if (creation == null) {
      return const MissingCreationView();
    }

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(creation!.title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              SharePlus.instance.share(ShareParams(text: creation?.pdfUrl));
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: theme.colorScheme.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreationImageSection(creation: creation!),
                  CreationHeaderSection(creation: creation!),
                  CreationDescriptionSection(creation: creation!),
                  CreationPdfSection(creation: creation!),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
