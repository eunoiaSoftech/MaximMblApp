import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/features/auth/data/models/login_resp_model.dart';
import 'package:logistics_app/features/auth/data/models/loginwith_otp_resp.dart';
import 'package:logistics_app/features/auth/data/repositories/auth_repos.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/auth.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/login_events.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/loginwith_otp_events.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/auth.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/login_states.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_states/loginwith_otp_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<LoginWithOTPEvent>(_loginWithOTP);
  }

  _login(event, emit) async {
    if (event is LoginEvent) {
      emit(LoginLoading());
      try {
        LoginResponseModel resp = await authRepository.loginRepo(event.params);
        if (resp.statusCode == 0) {
          emit(LoginLoaded(resp));
        } else {
          emit(LoginError(resp.data1?[0].message ?? "Something Went Wrong"));
        }
      } catch (e) {
        emit(LoginError("Failed to login! $e"));
      }
    }
  }

  _loginWithOTP(event, emit) async {
    if (event is LoginWithOTPEvent) {
      emit(LoginWithOTPLoading());
      try {
        LoginWithOTPResp resp =
            await authRepository.loginWithOTPRepo(event.params);
        if (resp.statusCode == 0) {
          emit(LoginWithOTPLoaded(resp));
        } else if (resp.statusCode == 1) {
          emit(LoginWithOTPError(resp.data1?.first.message ?? ""));
        } else {
          emit(LoginWithOTPError("Something Went Wrong"));
        }
      } catch (e) {
        emit(LoginWithOTPError("Failed to login! $e"));
      }
    }
  }
}
