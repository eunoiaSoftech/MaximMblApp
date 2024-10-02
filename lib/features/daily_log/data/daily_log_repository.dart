import '../../legals/data/models/vehicle_list_resp.dart';
import '../models/daily_log_model.dart';
import 'daily_log_remote_datasource.dart';

class DailyLogRepository {
  final DailyLogRemoteDataSource _remoteDataSource;

  DailyLogRepository(this._remoteDataSource);

  Future<DailyLogVehicleResponse> dailyLogVehicleListRepo(
      {required int userType, required int userId}) async {
    final response =
    await _remoteDataSource.getDailyLogVehicleListApi(userType, userId);

    print('check api response for get daily log vehicle ${response}');

    return DailyLogVehicleResponse.fromJson(response.data);
  }
}
