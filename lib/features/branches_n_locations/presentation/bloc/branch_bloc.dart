import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/features/branches_n_locations/data/models/branch_list_resp_model.dart';
import 'package:logistics_app/features/branches_n_locations/data/repositories/branch_repos.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_events/branch_events.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_states/branch.dart';
import 'package:logistics_app/features/branches_n_locations/presentation/bloc/branch_states/branch_states.dart';

class BranchBloc extends Bloc<BranchListEvent, BranchState> {
  final BranchRepository repository;

  BranchBloc(this.repository) : super(BranchInitial()) {
    on<BranchListEvent>(_getBranches);
  }

  _getBranches(event, emit) async {
    if (event is BranchListEvent) {
      emit(BranchListLoading());
      try {
        BranchListResponseModel resp =
            await repository.branchListRepo(event.userId);
        if (resp.statusCode == 1) {
          emit(BranchListLoaded(resp));
        } else {
          emit(BranchListError(resp.message ?? "Something Went Wrong"));
        }
      } catch (e) {
        emit(BranchListError("Failed to get branches! $e"));
      }
    }
  }
}