import 'package:logistics_app/features/legals/data/models/vehicle_list_resp.dart';
import 'package:logistics_app/features/legals/presentation/blocs/legals_states/legals.dart';

/// loading ...
class VehicleListLoading extends LegalsState {}

/// success ...
class VehicleListLoaded extends LegalsState {
  final VehicleListResp resp;

  VehicleListLoaded(this.resp);

  @override
  List<Object?> get props => [resp];
}

/// error ...
class VehicleListError extends LegalsState {
  final String error;

  VehicleListError(this.error);

  @override
  List<Object?> get props => [error];
}
