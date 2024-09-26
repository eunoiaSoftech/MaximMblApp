import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/features/approvals/data/models/approvals_list_resp.dart';
import 'package:logistics_app/features/approvals/data/repositories/approvals_repo.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_events/approvals.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_events/approvals_list_event.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_states/approvals.dart';
import 'package:logistics_app/features/approvals/presentation/blocs/approvals_states/approvals_list_state.dart';

class ApprovalsBloc extends Bloc<ApprovalsEvent, ApprovalsState> {
  final ApprovalsRepository repository;

  ApprovalsBloc(this.repository) : super(ApprovalsInitial()) {
    on<ApprovalsListEvent>(_approvalsList);
  }

  _approvalsList(event, emit) async {
    if (event is ApprovalsListEvent) {
      emit(ApprovalsListLoading());
      try {
        ApprovalsListResp resp =
            await repository.approvalsListRepo(event.params);
        if (resp.statusCode == 0) {
          emit(ApprovalsListLoaded(resp));
        } else {
          emit(ApprovalsListError(resp.message ?? "Something Went Wrong"));
        }
      } catch (e) {
        emit(ApprovalsListError("Failed to login! $e"));
      }
    }
  }
}
