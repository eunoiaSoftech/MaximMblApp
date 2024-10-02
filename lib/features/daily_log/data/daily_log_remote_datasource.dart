import 'package:dio/dio.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';

class DailyLogRemoteDataSource {
  final BaseApi _baseApi;

  DailyLogRemoteDataSource(this._baseApi);

  Future<Response> getDailyLogVehicleListApi(int userType, int userId) async {
    return await _baseApi.post(
        "${Urls.dailyLogVehicleList}?iFk_UserType=$userType&iFk_UserId=$userId", {});
  }
}
