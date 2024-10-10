import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio;
  static const String baseUrl = 'http://47.247.181.6:8089/';

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  }

  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      print('base url - $endpoint');

      Response response = await _dio.get(endpoint, queryParameters: params);

      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data) async {
    try {
      print('base url - $endpoint');

      Response response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException error) {
    String errorDescription = "";
    switch (error.type) {
      case DioExceptionType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.sendTimeout:
        errorDescription = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.badCertificate:
        errorDescription = "Bad Certificate";
        break;
      case DioExceptionType.badResponse:
        errorDescription = "Bad Response";
        break;
      case DioExceptionType.connectionError:
        errorDescription = "Connection Error";
        break;
    }
    return errorDescription;
  }
}
