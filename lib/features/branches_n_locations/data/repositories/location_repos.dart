import 'dart:developer';

import 'package:logistics_app/features/branches_n_locations/data/datasources/location_remote_datasource.dart';
import 'package:logistics_app/features/branches_n_locations/data/models/location_list_resp.dart';

class LocationListRepository {
  final LocationListApiService _apiService;

  LocationListRepository({LocationListApiService? apiService})
      : _apiService = apiService ?? LocationListApiService();

  Future<LocationListResp> generateLocationList(int branchId, int userId) {
    log("message repo ");
    return _apiService.generateLocationList(branchId, userId);
  }
}
