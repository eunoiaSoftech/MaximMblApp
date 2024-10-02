import 'package:equatable/equatable.dart';

import '../../legals/data/models/vehicle_list_resp.dart';
import '../models/daily_log_model.dart';

abstract class DailyLogState extends Equatable {
  const DailyLogState();

  @override
  List<Object?> get props => [];
}

class DailyLogInitial extends DailyLogState {
  @override
  List<Object?> get props => [];
}

/// loading ...
class DailyLogVehicleListLoading extends DailyLogState {}

/// success ...
class DailyLogVehicleListLoaded extends DailyLogState {
  final DailyLogVehicleResponse resp;

  DailyLogVehicleListLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class DailyLogVehicleListError extends DailyLogState {
  final String error;

  DailyLogVehicleListError(this.error);

  @override
  List<Object?> get props => [error];
}
