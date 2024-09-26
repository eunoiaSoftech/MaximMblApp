// In trip_remote_datasource.dart
import 'package:dio/dio.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/shared/data/base_api.dart';

class TripsRemoteDataSource {
  final BaseApi _baseApi;

  TripsRemoteDataSource(this._baseApi);

  Future<Response> getTrips() async {
    return await _baseApi.get(Urls.trips);
  }
}
