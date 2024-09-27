import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';

class AppStyles {
  static TextStyle titleTextStyle(context) => TextStyle(
      fontSize: appSize(context) / 80,
      color: AppColors.borderColor,
      fontFamily: "aileron");

  static TextStyle hintTextStyle(context) => TextStyle(
      fontSize: appSize(context) / 75,
      color: Colors.grey,
      fontWeight: FontWeight.w400);

  static TextStyle btnTextStyle(context) =>
      TextStyle(fontSize: appSize(context) / 40, color: Colors.white70);

  static TextStyle inputTextStyle(context) => TextStyle(
      fontSize: appSize(context) / 75,
      fontWeight: FontWeight.w500,
      color: Colors.black87);

  static TextStyle bottomSheetTitleTextStyle(context) => TextStyle(
      fontSize: appSize(context) / 75,
      fontWeight: FontWeight.w500,
      color: Colors.black87);

  static TextStyle bottomSheetSUBTitleTextStyle(context) => TextStyle(
      fontSize: appSize(context) / 85,
      fontWeight: FontWeight.w500,
      color: Colors.black87);
}
