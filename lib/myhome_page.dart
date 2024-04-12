import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:document_upload/document_screen.dart';
import 'package:document_upload/document_controller.dart';

class MyHomePage extends StatelessWidget {
  final DocumentController documentController = Get.put(DocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document Selector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                documentController.selectDocuments();
              },
              child: Text("Select Documents"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: documentController.selectedDocuments.length,
                  itemBuilder: (context, index) {
                    String documentPath = documentController.selectedDocuments[index];
                    IconData iconData = Icons.insert_drive_file; // Default icon for unknown file types
                    if (documentPath.toLowerCase().endsWith('.pdf')) {
                      iconData = Icons.picture_as_pdf;
                    } else if (documentPath.toLowerCase().endsWith('.jpg') ||
                        documentPath.toLowerCase().endsWith('.jpeg') ||
                        documentPath.toLowerCase().endsWith('.png')) {
                      iconData = Icons.image;
                    }
                    return ListTile(
                      leading: Icon(iconData),
                      title: Text(File(documentPath).path.split('/').last), // Display file name
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          // Remove the selected document
                          documentController.removeDocument(documentPath);
                        },
                      ),
                      onTap: () {
                        // Navigate to a new screen to display the selected document
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DocumentScreen(documentPath: documentPath),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
