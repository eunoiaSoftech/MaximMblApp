import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logistics_app/core/services/build_config.dart';
import 'package:logistics_app/core/shared/data/exceptions/general_exception.dart';
import 'package:logistics_app/core/shared/data/network/api_service/dio_client.dart';
import 'package:logistics_app/core/shared/data/network/responses/api_error_response.dart';

class BaseApiService {
  final Dio httpClient;

  BaseApiService(dynamic client) : httpClient = client ?? DioClient().client;

  /// Creates URI for API calls
  Uri getUri(String path) {
    log("path >>>>>>  $path");
    final String uriPath = path.startsWith('/') ? path : '/$path';
    log("scheme  ${BuildConfig.instance?.scheme}");
    log("apiBaseUrl  ${BuildConfig.instance?.apiBaseUrl}");
    final uri = Uri(
      scheme: BuildConfig.instance?.scheme,
      host: BuildConfig.instance?.apiBaseUrl,
      path: uriPath,
    );
    log("URI ::::::: $uri");
    return uri;
  }

  /// Sends requests & parses response for success/error handling
  Future<Response> send(Future<Response> request) async {
    try {
      final response = await request;
      return response;
    } on DioException catch (error) {
      if (error.response != null) {
        return _handleError(error.response!);
      } else if (error.type == DioExceptionType.unknown) {
        throw error.error ?? Error();
      }
      throw GeneralException();
    }
  }

  Future<Response> _handleError(Response response) {
    final apiError = _parseError(response);
    throw GeneralException(apiError);
  }

  ApiErrorResponse _parseError(Response response) {
    return ApiErrorResponse(errors: response.data.toString());
    // return ApiErrorResponse.fromJson(response.data);
  }

  /// creates very basic headers api calls
  Options getOptions({
    Map<String, dynamic>? headers,
  }) {
    final options = Options(
      responseType: ResponseType.json,
      contentType: 'application/json',
      headers: headers,
    );
    return options;
  }
}
