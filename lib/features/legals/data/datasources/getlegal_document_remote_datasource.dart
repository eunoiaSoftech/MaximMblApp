import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class GetLegalDocumentRemoteApi {
  final Dio _dio = Dio();

  Future<dynamic> getLegalDocument(int vehicleId, int docTypeId) async {
    // try {
    final resp = await http.get(Uri.parse(
        'http://47.247.181.6:8089/api/api/GetLegalDocument?iFK_VehicleId=65&iFk_DocTypeId=1'));
    final contentType = resp.headers['content-type'];
    log("response ::: ${resp.statusCode}   ${contentType}");



    // final response = await _dio.get(
    //   'http://47.247.181.6:8089/api/api/GetLegalDocument',
    //   queryParameters: {
    //     'iFK_VehicleId': vehicleId,
    //     'iFk_DocTypeId': docTypeId,
    //   },
    //   options: Options(
    //     headers: {
    //       // 'Authorization': 'Bearer YOUR_ACCESS_TOKEN',  // if authorization is required
    //       'Content-Type': 'application/pdf',
    //     },
    //     validateStatus: (status) {
    //       return status! < 500; // Allow Dio to not throw on 405 or 404
    //     },
    //   ),
    // );
    return resp;
    // } catch (e) {
    //   throw Exception('Failed to load document: $e');
    // }
  }
}
