import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DocumentScreen extends StatelessWidget {
  final String documentPath;

  const DocumentScreen({Key? key, required this.documentPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selected Document"),
      ),
      body: Center(
        child: Container(
          child: documentPath.toLowerCase().endsWith('.pdf')
              ? PDFView(
                  filePath: documentPath,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onRender: (pages) {
                    print("Rendered $pages pages");
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print("Error on page $page: $error");
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                  },
                )
              : Image.file(File(documentPath)),
        ),
      ),
    );
  }
}
