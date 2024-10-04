import 'package:logistics_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:logistics_app/features/auth/data/models/login_req_model.dart';
import 'package:logistics_app/features/auth/data/models/login_resp_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_req.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_resp.dart';

import '../../../../core/services/local_permission_services.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);

  Future<LoginResponseModel> loginRepo(LoginRequestModel params) async {
    final response = await _remoteDataSource.login(params);

    List<dynamic> rights = response.data['rights'];
    PermissionService().storeRights(rights);

    return LoginResponseModel.fromJson(response.data);
  }

  Future<LoginWithOTPResp> loginWithOTPRepo(
      LoginWithOTPRequestModel params) async {
    final response = await _remoteDataSource.loginWithOTP(params);

    List<dynamic> rights = response.data['rights'];
    PermissionService().storeRights(rights);
    return LoginWithOTPResp.fromJson(response.data);
  }
}
