import 'package:logistics_app/features/auth/data/models/login_resp_model.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/auth.dart';

/// loading ...
class LoginLoading extends AuthState {}

/// success ...
class LoginLoaded extends AuthState {
  final LoginResponseModel resp;

  LoginLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class LoginError extends AuthState {
  final String error;

  LoginError(this.error);

  @override
  List<Object?> get props => [error];
}
