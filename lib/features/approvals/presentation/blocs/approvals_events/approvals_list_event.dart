

import 'package:logistics_app/features/approvals/data/models/approvals_req_params.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_events/approvals.dart';

class ApprovalsListEvent extends ApprovalsEvent{
  final ApprovalsRequestModel params;
  ApprovalsListEvent(this.params);

  @override
  List<Object?> get props => [params];
}

