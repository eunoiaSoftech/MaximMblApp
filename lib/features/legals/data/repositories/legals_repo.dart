import 'package:logistics_app/features/legals/data/datasources/legal_remote_datasource.dart';
import 'package:logistics_app/features/legals/data/models/legal_document_list_resp.dart';
import 'package:logistics_app/features/legals/data/models/vehicle_list_resp.dart';

class LegalsRepository {
  final LegalsRemoteDataSource _remoteDataSource;

  LegalsRepository(this._remoteDataSource);

  Future<VehicleListResp> vehicleListRepo(
      {required int userType, required int userId}) async {
    final response =
        await _remoteDataSource.getVehicleListApi(userType, userId);
    return VehicleListResp.fromJson(response.data);
  }

Future<LegalDocumentListResp> getLegalDocumentListRepo(int vehicleId) async {
  final response = await _remoteDataSource.getLegalDocumentList(vehicleId);
  return LegalDocumentListResp.fromJson(response.data);
}
}
