import 'package:logistics_app/features/branches/data/datasources/branch_remote_datasource.dart';
import 'package:logistics_app/features/branches/data/models/branch_list_resp_model.dart';

class BranchRepository {
  final BranchRemoteDataSource _remoteDataSource;

  BranchRepository(this._remoteDataSource);

  Future<BranchListResponseModel> branchListRepo(int userid) async {
    final response = await _remoteDataSource.getBranchList(userid);
    return BranchListResponseModel.fromJson(response.data);
  }
}
