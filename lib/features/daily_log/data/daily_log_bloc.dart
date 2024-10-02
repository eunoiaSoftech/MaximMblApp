import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../legals/data/models/vehicle_list_resp.dart';
import '../models/daily_log_model.dart';
import 'daily_log_event.dart';
import 'daily_log_repository.dart';
import 'daily_log_vehicle_list_event.dart';
import 'daily_log_vehicle_list_state.dart';

class DailyLogBloc extends Bloc<DailyLogEvent, DailyLogState> {
  final DailyLogRepository repository;

  DailyLogBloc(this.repository) : super(DailyLogInitial()) {
    on<DailyLogVehicleListEvent>(_getDailyLogVehicleList);
  }

  _getDailyLogVehicleList(event, emit) async {
    if (event is DailyLogVehicleListEvent) {
      emit(DailyLogVehicleListLoading());
      try {
        DailyLogVehicleResponse resp = await repository.dailyLogVehicleListRepo(
            userType: event.userType, userId: event.userId);
        if (resp.statusCode == 0) {
          emit(DailyLogVehicleListLoaded(resp));
        } else {
          emit(
              DailyLogVehicleListError("Something went wrong"));
        }
      } catch (e) {
        emit(DailyLogVehicleListError("Failed to fetch vehicle list! $e"));
      }
    }
  }
}
