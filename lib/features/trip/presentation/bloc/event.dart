// trips_event.dart
import 'package:equatable/equatable.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class LoadTrips extends TripsEvent {}
