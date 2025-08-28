// cubit/auth_cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/model/usermodel.dart';
import '../../data/repositories/user_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth;
  final UserRepository userRepository;

  AuthCubit(this.auth, this.userRepository) : super(AuthInitial()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      final userData = await userRepository.getUser(currentUser.uid);
      emit(AuthAuthenticated(userData));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final userData = await userRepository.getUser(result.user!.uid);
      emit(AuthAuthenticated(userData));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signUp(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final newUser = UserModel(
        uid: result.user!.uid,
        name: email.split('@')[0],
        bio: "",
        profilePic: "",
      );
      await userRepository.createUser(newUser);
      emit(AuthAuthenticated(newUser));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    emit(AuthUnauthenticated());
  }
}
