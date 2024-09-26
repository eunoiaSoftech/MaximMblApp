import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/features/legals/data/models/legal_document_list_resp.dart';
import 'package:logistics_app/features/legals/data/models/vehicle_list_resp.dart';
import 'package:logistics_app/features/legals/data/repositories/legals_repo.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legal_document_list_events.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legals.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_events/vehicle_list_events.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legal_document_list_states.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legals.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/vehicle_list_states.dart';

class LegalsBloc extends Bloc<LegalsEvent, LegalsState> {
  final LegalsRepository repository;

  LegalsBloc(this.repository) : super(LegalsInitial()) {
    on<VehicleListEvent>(_getVehicleList);
  }

  _getVehicleList(event, emit) async {
    if (event is VehicleListEvent) {
      emit(VehicleListLoading());
      try {
        VehicleListResp resp = await repository.vehicleListRepo(
            userType: event.userType, userId: event.userId);
        if (resp.statusCode == 0) {
          emit(VehicleListLoaded(resp));
        } else {
          emit(VehicleListError(resp.message ?? "Something Went Wrong"));
        }
      } catch (e) {
        emit(VehicleListError("Failed to login! $e"));
      }
    }
  }
}
