import 'package:dio/dio.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';
import 'package:logistics_app/features/approvals/data/models/approvals_req_params.dart';

class ApprovalsRemoteDataSource {
  final BaseApi _baseApi;

  ApprovalsRemoteDataSource(this._baseApi);

  Future<Response> approvalsListApi(ApprovalsRequestModel params) async {
    return await _baseApi.post(
        "${Urls.approvalsListList}?fk_UserId=${params.userId}&fk_BranchId=${params.branchId}",
        {});
  }

// Future<Response> loginWithOTP(LoginWithOTPRequestModel params) async {
//   return await _baseApi.post(
//       "${Urls.loginWithOTP}?sUsername=${params.username}&PhNo=${params.phone}",
//       {});
// }
}
