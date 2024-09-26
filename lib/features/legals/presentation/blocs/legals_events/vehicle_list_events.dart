import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legals.dart';

class VehicleListEvent extends LegalsEvent {
  final int userType;
  final int userId;

  VehicleListEvent(this.userId, this.userType);

  @override
  List<Object?> get props => [userType, userId];
}
