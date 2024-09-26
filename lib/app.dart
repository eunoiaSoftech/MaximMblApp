import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/core/res/app_theme.dart';
import 'package:logistics_app/features/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAXIM',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
