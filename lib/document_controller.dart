import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

class DocumentController extends GetxController {
  RxList<String> selectedDocuments = <String>[].obs;

  Future<void> selectDocuments() async {
    List<String> documents = [];

    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        List<FilePickerResult> resultList = [result];
        documents = resultList.expand((result) => result.files.map((file) => file.bytes.toString())).toList();
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        documents = result.paths.map((path) => path!).toList();
      }
    }

    selectedDocuments.addAll(documents);
  }

  
  void removeDocument(String documentPath) {
    selectedDocuments.remove(documentPath);
  }
}
