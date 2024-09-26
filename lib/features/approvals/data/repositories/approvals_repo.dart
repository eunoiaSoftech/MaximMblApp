import 'package:logistics_app/features/approvals/data/datasources/approvals_remote_datasource.dart';
import 'package:logistics_app/features/approvals/data/models/approvals_list_resp.dart';
import 'package:logistics_app/features/approvals/data/models/approvals_req_params.dart';
import 'package:logistics_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:logistics_app/features/auth/data/models/login_req_model.dart';
import 'package:logistics_app/features/auth/data/models/login_resp_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_req.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_resp.dart';

class ApprovalsRepository {
  final ApprovalsRemoteDataSource _remoteDataSource;

  ApprovalsRepository(this._remoteDataSource);

  Future<ApprovalsListResp> approvalsListRepo(
      ApprovalsRequestModel params) async {
    final response = await _remoteDataSource.approvalsListApi(params);
    return ApprovalsListResp.fromJson(response.data);
  }

// Future<LoginWithOTPResp> loginWithOTPRepo(LoginWithOTPRequestModel params) async {
//   final response = await _remoteDataSource.loginWithOTP(params);
//   return LoginWithOTPResp.fromJson(response.data);
// }
}
