// cubit/profile_cubit/profile_cubit.dart
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/model/usermodel.dart';
import '../../data/repositories/user_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;
  final FirebaseAuth auth;

  ProfileCubit(this.userRepository, this.auth) : super(ProfileInitial());

  void loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = auth.currentUser;
      if (user != null) {
        final userData = await userRepository.getUser(user.uid);
        emit(ProfileLoaded(userData));
      } else {
        emit(ProfileError("User not logged in"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void updateProfile(UserModel updatedUser) async {
    emit(ProfileLoading());
    try {
      await userRepository.updateUser(updatedUser);
      emit(ProfileUpdated("Profile updated successfully"));
      loadProfile();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfileImage(File imageFile) async {
    emit(ProfileLoading());
    try {
      final user = auth.currentUser;
      if (user != null) {
        final newUrl =
            await userRepository.uploadProfileImage(user.uid, imageFile);
        final currentUser = await userRepository.getUser(user.uid);
        final updated = currentUser.copyWith(profilePic: newUrl);
        await userRepository.updateUser(updated);
        emit(ProfileUpdated("Profile picture updated"));
        loadProfile();
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
