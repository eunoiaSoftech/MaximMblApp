

import 'package:logistics_app/core/shared/data/network/responses/api_error_response.dart';

class GeneralException implements Exception {
  ApiErrorResponse? apiError;

  GeneralException([this.apiError]);

  @override
  String toString() {
    return apiError?.errors ?? '';
  }
}