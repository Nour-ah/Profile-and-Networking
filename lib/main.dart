// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'cubit/auth_cubit/auth_cubit.dart';
import 'cubit/profile_cubit/profile_cubit.dart';
import 'cubit/theme_cubit/theme_cubit.dart';
import 'cubit/theme_cubit/theme_state.dart';
import 'cubit/user_cubit/usercubit.dart';
import 'data/repositories/user_repository.dart';
import 'presentation/screens/auth/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final userRepository = UserRepository(
    FirebaseFirestore.instance,
    FirebaseStorage.instance,
  );

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthCubit(FirebaseAuth.instance, userRepository),
        ),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => UserCubit(userRepository)),
        BlocProvider(
          create: (_) => ProfileCubit(userRepository, FirebaseAuth.instance),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeState.themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            home: AuthWrapper(),
          );
        },
      ),
    );
  }
}
