import 'package:equatable/equatable.dart';

abstract class CurrentTripEvent extends Equatable {
  const CurrentTripEvent();
}

class FetchCurrentTrip extends CurrentTripEvent {
  @override
  List<Object> get props => [];
}
