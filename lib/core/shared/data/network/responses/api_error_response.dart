
import 'package:json_annotation/json_annotation.dart';

part 'api_error_response.g.dart';

@JsonSerializable()
class ApiErrorResponse {
  @JsonKey(name: 'errors')
  final String? errors;

  ApiErrorResponse({
    this.errors,
  });

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);
}