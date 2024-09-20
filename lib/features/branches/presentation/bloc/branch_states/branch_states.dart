import 'package:logistics_app/features/branches/data/models/branch_list_resp_model.dart';
import 'package:logistics_app/features/branches/presentation/bloc/branch_states/branch.dart';

/// loading ...
class BranchListLoading extends BranchState {}

/// success ...
class BranchListLoaded extends BranchState {
  final BranchListResponseModel resp;

  BranchListLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class BranchListError extends BranchState {
  final String error;

  BranchListError(this.error);

  @override
  List<Object?> get props => [error];
}
