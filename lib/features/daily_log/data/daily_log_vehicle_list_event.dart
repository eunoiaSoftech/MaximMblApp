
import 'daily_log_event.dart';

class DailyLogVehicleListEvent extends DailyLogEvent {
  final int userType;
  final int userId;

  DailyLogVehicleListEvent(this.userId, this.userType);

  @override
  List<Object?> get props => [userType, userId];
}
