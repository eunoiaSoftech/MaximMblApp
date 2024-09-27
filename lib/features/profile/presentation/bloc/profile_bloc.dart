import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/app_functions.dart';
import '../../../../core/res/app_storage.dart';
import '../../../../core/services/api_services.dart';
import '../../../auth/presentation/ui/login_screen.dart';

// Define your events
abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {}

class LogoutEvent extends ProfileEvent {}

class DeleteAccountEvent extends ProfileEvent {}

// Define your states
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;
  final Map<String, dynamic> newProfileData;

  ProfileLoaded(this.profileData, this.newProfileData);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

// Define your Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // Register the event handler
    on<FetchProfileEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        // Simulate a profile fetch
        var userDetails = AppStorage().getUserDetails;
        log("_checkForUserSession() >> $userDetails");

        var response = await ApiService().post(
            "/api/api/ProfileDetM?fk_UserId=${userDetails['userId']}&fk_UserTypeId=${userDetails['userType'] ?? ''}",
            {});

        var newProfileResponse = await ApiService().get(
            "/api/api/GetProfileDetails?Fk_DriverId=${userDetails['userId']}&iFK_UserTypeId=${userDetails['userType'] ?? ''}");

        print('check response ${response}');
        print('check response ${newProfileResponse}');

        if (response.statusCode == 200 &&
            newProfileResponse.statusCode == 200) {
          emit(ProfileLoaded(response.data, newProfileResponse.data));
        } else {
          emit(ProfileError("Failed to fetch profile"));
        }
      } catch (e) {
        emit(ProfileError("Failed to fetch profile"));
      }
    });

    on<LogoutEvent>((event, emit) {
      emit(ProfileInitial()); // or any other state
    });

    on<DeleteAccountEvent>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
