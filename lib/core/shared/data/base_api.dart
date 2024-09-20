import 'dart:developer';

import 'package:dio/dio.dart';

class BaseApi {
  final Dio _dio;

  BaseApi(this._dio);

  Future<Response> get(String path) async {
    // try {
      return await _dio.get(path);
    // } on DioException catch (error) {
    //   throw ApiException(_handleError(error));
    // }
  }

  Future<Response> post(String path, dynamic data,
      {Map<String, dynamic>? headers}) async {
    log("""||--------------------------------------------------------------||
    POST REQUEST :: $path,
    BODY :: $data,
    HEADERS :: $headers 
    """);
    // try {
      final resp = await _dio.post(path,
          data: data,
          options: Options(
            responseType: ResponseType.json,
            contentType: "application/json",
            headers: headers,
          ));
      log("""RESPONSE :: $resp
||--------------------------------------------------------------||
      """);
      return resp;
    // } on DioException catch (error) {
    //   throw ApiException(_handleError(error));
    // }
  }

  String _handleError(DioException error) {
    if (error.response != null) {
      return "Request failed with status code : ${error.response?.statusCode}";
    } else {
      return "Request failed: ${error.message}";
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}
