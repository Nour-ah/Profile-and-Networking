// cubit/profile_cubit/profile_state.dart
import '../../data/model/usermodel.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  ProfileLoaded(this.user);
}

class ProfileUpdated extends ProfileState {
  final String message;
  ProfileUpdated(this.message);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
