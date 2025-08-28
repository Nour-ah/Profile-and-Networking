// cubit/user_cubit/usercubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  void loadUsers() {
    emit(UserLoading());
    userRepository.getAllUsers().listen(
          (users) => emit(UserLoaded(users)),
          onError: (e) => emit(UserError(e.toString())),
        );
  }
}
