import 'package:logistics_app/features/auth/data/models/loginwith_otp_req.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/auth.dart';

class LoginWithOTPEvent extends AuthEvent {
  final LoginWithOTPRequestModel params;

  LoginWithOTPEvent(this.params);

  @override
  List<Object?> get props => [params];
}
