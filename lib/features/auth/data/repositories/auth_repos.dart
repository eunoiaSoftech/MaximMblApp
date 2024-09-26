import 'package:logistics_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:logistics_app/features/auth/data/models/login_req_model.dart';
import 'package:logistics_app/features/auth/data/models/login_resp_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_req.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_resp.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource);

  Future<LoginResponseModel> loginRepo(LoginRequestModel params) async {
    final response = await _remoteDataSource.login(params);
    return LoginResponseModel.fromJson(response.data);
  }

  Future<LoginWithOTPResp> loginWithOTPRepo(LoginWithOTPRequestModel params) async {
    final response = await _remoteDataSource.loginWithOTP(params);
    return LoginWithOTPResp.fromJson(response.data);
  }


}
