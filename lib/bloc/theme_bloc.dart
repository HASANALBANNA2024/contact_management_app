import 'package:contact_management_app/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<LoadThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? false;
      emit(isDark ? ThemeMode.dark : ThemeMode.light);
    });
    on<ToggleThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      if (state == ThemeMode.light) {
        emit(ThemeMode.dark);
        await prefs.setBool('isDarkMode', true);
      } else {
        emit(ThemeMode.light);
        await prefs.setBool('isDarkMode', false);
      }
    });
  }
}
