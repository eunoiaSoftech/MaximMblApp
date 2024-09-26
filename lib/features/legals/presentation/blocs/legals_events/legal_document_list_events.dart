import 'package:logistics_app/features/legals/presentation/blocs/legals_events/legals.dart';

class LegalDocumentListEvent extends LegalsEvent {
  final int vehicleId;

  LegalDocumentListEvent(this.vehicleId);

  @override
  List<Object?> get props => [vehicleId];
}
