import 'package:equatable/equatable.dart';
import 'package:logistics_app/features/profile/model/get_profile_model.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final GetProfileModel profileData;
  final bool isDriver;

  ProfileLoaded(this.profileData, this.isDriver);

  @override
  List<Object?> get props => [profileData, isDriver];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
