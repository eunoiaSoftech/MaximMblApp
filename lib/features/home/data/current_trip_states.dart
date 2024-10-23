import 'package:equatable/equatable.dart';

import 'current_trip_model.dart';

abstract class CurrentTripState extends Equatable {
  const CurrentTripState();
}

class CurrentTripInitial extends CurrentTripState {
  @override
  List<Object> get props => [];
}

class CurrentTripLoading extends CurrentTripState {
  @override
  List<Object> get props => [];
}

class CurrentTripLoaded extends CurrentTripState {
  final CurrentTrip currentTrip;

  const CurrentTripLoaded(this.currentTrip);

  @override
  List<Object> get props => [currentTrip];
}

class CurrentTripError extends CurrentTripState {
  final String message;

  const CurrentTripError(this.message);

  @override
  List<Object> get props => [message];
}
