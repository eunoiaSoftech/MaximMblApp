import 'package:logistics_app/features/approvals/data/models/approvals_list_resp.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_states/approvals.dart';

/// loading ...
class ApprovalsListLoading extends ApprovalsState {}

/// success ...
class ApprovalsListLoaded extends ApprovalsState {
  final ApprovalsListResp resp;

  ApprovalsListLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class ApprovalsListError extends ApprovalsState {
  final String error;

  ApprovalsListError(this.error);

  @override
  List<Object?> get props => [error];
}
