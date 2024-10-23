import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/res/app_storage.dart';
import '../../../core/services/api_services.dart';
import 'current_trip_event.dart';
import 'current_trip_model.dart';
import 'current_trip_states.dart';

class CurrentTripBloc extends Bloc<CurrentTripEvent, CurrentTripState> {
  CurrentTripBloc() : super(CurrentTripInitial()) {
    on<FetchCurrentTrip>(_onFetchCurrentTrip);
  }

  Future<void> _onFetchCurrentTrip(
      FetchCurrentTrip event, Emitter<CurrentTripState> emit) async {
    emit(CurrentTripLoading());
    try {
      var userDetails = AppStorage().getUserDetails;
      var userId = userDetails['userId'];

      // Call the API with the driver ID
      var response =
          await ApiService().get("/api/api/GetCurrentTrip?Fk_DriverId=$userId");

      if (response.statusCode == 200) {
        // Check if data1 is not empty before parsing
        final currentTrip = CurrentTrip.fromJson(response.data['data1'][0]);
        emit(CurrentTripLoaded(currentTrip));
      } else {
        emit(CurrentTripError('Failed to load current trip data'));
      }
    } catch (e) {
      emit(CurrentTripError(e.toString()));
    }
  }
}
