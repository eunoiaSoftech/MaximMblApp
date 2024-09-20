

import 'package:logistics_app/features/auth/data/models/login_req_model.dart';
import 'package:logistics_app/features/auth/presentation/bloc/auth_events/auth.dart';

class LoginEvent extends AuthEvent{
  final LoginRequestModel params;
  LoginEvent(this.params);

  @override
  List<Object?> get props => [params];
}

