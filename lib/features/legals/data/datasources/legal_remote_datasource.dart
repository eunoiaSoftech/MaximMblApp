import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';

class LegalsRemoteDataSource {
  final BaseApi _baseApi;

  LegalsRemoteDataSource(this._baseApi);

  Future<Response> getVehicleListApi(int userType, int userId) async {
    return await _baseApi.post(
        "${Urls.vehicleList}?iFk_UserType=$userType&iFk_UserId=$userId", {});
  }

  Future<Response> getLegalDocumentList(int vehicleId) async {

    log('check get legal document by vehicle id ${"${Urls.getLegalDocumentList}?iFK_VehicleId=$vehicleId"}');

    return await _baseApi
        .post("${Urls.getLegalDocumentList}?iFK_VehicleId=$vehicleId", {});
  }
}
