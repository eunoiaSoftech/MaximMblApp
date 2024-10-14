import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logistics_app/features/legals/data/datasources/getlegal_document_remote_datasource.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({super.key});

  @override
  PdfViewerPageState createState() => PdfViewerPageState();
}

class PdfViewerPageState extends State<PdfViewerPage> {
  String? localPdfPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    // try {
      // Call the API to get the document
      GetLegalDocumentRemoteApi apiService = GetLegalDocumentRemoteApi();
      Response response = await apiService.getLegalDocument(65, 1);

      // Save the PDF locally
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = File('$tempPath/document.pdf');
      log("resp data ss ${response.data.toString().isEmpty}");
      await file.writeAsBytes(response.data);

      setState(() {
        localPdfPath = file.path;
      });
    // } catch (e) {
    //   print('Error loading PDF: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body:
      // localPdfPath != null
      //     ? PDFView(
      //         filePath: localPdfPath!,
      //       )
          // :
    Center(child: CircularProgressIndicator()),
    );
  }
}
