// presentation/screens/auth/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/auth_cubit/auth_cubit.dart';
import '../../../cubit/auth_cubit/auth_state.dart';
import '../profile_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return ProfileScreen();
        } else if (state is AuthUnauthenticated) {
          return LoginScreen();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
