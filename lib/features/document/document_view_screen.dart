import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class DocumentScreen extends StatefulWidget {
  final int vehicleId;
  final int docTypeId;

  DocumentScreen({required this.vehicleId, required this.docTypeId});

  @override
  _DocumentScreenState createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  String? _fileUrl;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDocument();
  }

  Future<void> _fetchDocument() async {
    final url =
        'http://47.247.181.6:8089/api/api/GetLegalDocument?iFK_VehicleId=${widget.vehicleId}&iFk_DocTypeId=${widget.docTypeId}';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _fileUrl = url;
          _isLoading = false;
        });

        print('check _fileUrl ${_fileUrl}');
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load document: ${response.reasonPhrase}');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadFile() async {
    if (_fileUrl == null) return;

    // Request storage permission
    var status = await Permission.storage.request();
    if (status.isDenied) {
      // If the permission is denied, show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
      return;
    } else if (status.isPermanentlyDenied) {
      // If the permission is permanently denied, you can show a dialog to open settings
      await openAppSettings();
      return;
    }

    try {
      final response = await Dio().post(
        _fileUrl!,
        data: {
          'iFK_VehicleId': widget.vehicleId,
          'iFk_DocTypeId': widget.docTypeId,
        },
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      final filePath =
          '${(await getDownloadsDirectory())?.path}/downloaded_document.pdf';
      final file = File(filePath);
      await file.writeAsBytes(response.data);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File downloaded successfully!')),
        );

        // Open the downloaded file
        OpenFile.open(filePath).then((result) {
          print('File opened: ${result.message}');
        });

        // Print the file location
        print('File location: $filePath');
      }
    } catch (error) {
      print('Download error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Preview'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_fileUrl != null) ...[
                    ElevatedButton(
                      onPressed: _downloadFile,
                      child: Text(
                        'Download Document',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ] else
                    Text('No document available'),
                ],
              ),
            ),
    );
  }
}
