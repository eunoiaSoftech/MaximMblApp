import 'package:logistics_app/features/auth/data/models/login_resp_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_resp.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/auth.dart';

/// loading ...
class LoginWithOTPLoading extends AuthState {}

/// success ...
class LoginWithOTPLoaded extends AuthState {
  final LoginWithOTPResp resp;

  LoginWithOTPLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class LoginWithOTPError extends AuthState {
  final String error;

  LoginWithOTPError(this.error);

  @override
  List<Object?> get props => [error];
}
