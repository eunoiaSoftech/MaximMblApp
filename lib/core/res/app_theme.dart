import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';

ThemeData appTheme = ThemeData(
  primaryColor: Colors.blue,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  fontFamily: "aileron",
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    // bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  colorScheme: const ColorScheme(
      brightness: Brightness.light,

      /// dark violet
      primary: AppColors.darkViolet,
      onPrimary: AppColors.darkViolet,

      /// light violet
      secondary: AppColors.lightViolet,
      onSecondary: AppColors.lightViolet,
      error: Colors.red,
      onError: Colors.redAccent,
      background: Colors.white,
      onBackground: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white70),
);
