// import 'dart:developer';
//
// import 'package:logistics_app/features/branches_n_locations/data/datasources/location_remote_datasource.dart';
// import 'package:logistics_app/features/branches_n_locations/data/models/location_list_resp.dart';
// import 'package:logistics_app/features/legals/data/datasources/getlegal_document_remote_datasource.dart';
//
// class GetLegalDocumentRepository {
//   final GetLegalDocumentApiService _apiService;
//
//   GetLegalDocumentRepository({GetLegalDocumentApiService? apiService})
//       : _apiService = apiService ?? GetLegalDocumentApiService();
//
//   Future<dynamic> generateGetLegalDocument(vehicleId, docTypeId) {
//
//     final respData = _apiService.getLegalDocumentMediaResponse(vehicleId, docTypeId);
//
//     _saveFile(respData, fileName);
//   }
//
//   // Function to save the downloaded media file
//   Future<void> _saveFile(List<int> bytes, String fileName) async {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = path.join(directory.path, fileName);
//     final file = File(filePath);
//     await file.writeAsBytes(bytes);
//     print('File saved to $filePath');
//   }
// }
