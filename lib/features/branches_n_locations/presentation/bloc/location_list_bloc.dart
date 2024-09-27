import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/core/shared/bloc/ui_state.dart';
import 'package:logistics_app/core/shared/data/extensions/future_extensions.dart';
import 'package:logistics_app/features/branches_n_locations/data/models/location_list_resp.dart';
import 'package:logistics_app/features/branches_n_locations/data/repositories/location_repos.dart';

class LocationListBloc extends Cubit<UiState<LocationListResp>> {
  final LocationListRepository _repository;

  LocationListBloc({LocationListRepository? repository})
      : _repository = repository ?? LocationListRepository(),
        super(Default());

  Future generateLocationList(int branchId, int userId) {
    log("message  $branchId $userId");
    emit(Progress());
    return _repository
        .generateLocationList(branchId, userId)
        .then(_onSuccess)
        .handleError(_onError);
  }

  _onSuccess(LocationListResp response) async {
    emit(Success(response));
  }

  _onError(exception) {
    emit(Error(exception as Exception));
  }
}
