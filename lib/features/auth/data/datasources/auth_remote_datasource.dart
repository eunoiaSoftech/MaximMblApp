import 'package:dio/dio.dart';
import 'package:logistics_app/core/constants/constants.dart';
import 'package:logistics_app/core/shared/data/base_api.dart';
import 'package:logistics_app/features/auth/data/models/login_req_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_req.dart';

class AuthRemoteDataSource {
  final BaseApi _baseApi;

  AuthRemoteDataSource(this._baseApi);

  Future<Response> login(LoginRequestModel params) async {
    return await _baseApi.post(Urls.login, params.toJson());
  }

  Future<Response> loginWithOTP(LoginWithOTPRequestModel params) async {
    return await _baseApi.post(
        "${Urls.loginWithOTP}?sUsername=${params.username}&PhNo=${params.phone}",
        {});
  }
}
