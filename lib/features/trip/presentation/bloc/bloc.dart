// trips_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics_app/features/trip/presentation/bloc/state.dart';
import '../../data/repositories/trip_repos.dart';
import 'event.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final TripsRepository tripsRepository;

  TripsBloc(this.tripsRepository) : super(TripsInitial()) {
    on<LoadTrips>((event, emit) async {
      emit(TripsLoading());
      try {
        final trips = await tripsRepository.fetchTrips();
        emit(TripsLoaded(trips));
      } catch (e) {
        emit(TripsError(e.toString()));
      }
    });
  }
}
