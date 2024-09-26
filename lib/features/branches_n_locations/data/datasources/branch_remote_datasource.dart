import 'package:dio/dio.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';

class BranchRemoteDataSource {
  final BaseApi _baseApi;

  BranchRemoteDataSource(this._baseApi);

  Future<Response> getBranchList(int userid) async {
    return await _baseApi.post("${Urls.branchList}?UserId=$userid", {});
  }
}
