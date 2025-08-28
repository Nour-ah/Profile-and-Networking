// cubit/theme_cubit/theme_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(ThemeMode.light));

  void toggleTheme() {
    emit(
      state.themeMode == ThemeMode.light
          ? ThemeState(ThemeMode.dark)
          : ThemeState(ThemeMode.light),
    );
  }
}
