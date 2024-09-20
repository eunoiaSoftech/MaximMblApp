import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/shared/widgets/app_logo.dart';
import 'package:logistics_app/features/auth/presentation/ui/login_screen.dart';
import 'package:logistics_app/features/home/presentation/ui/home_screen.dart';
import 'package:logistics_app/features/onboarding/screen/onboarding_screen.dart';

import 'home/presentation/ui/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _callLogin() async {
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => Navigator.of(context)
            .pushReplacement(goToRoute(const LoginScreen())));
  }

  void _navigateToHomeScreen() async {
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => Navigator.of(context)
            .pushReplacement(goToRoute(const MainScreen())));
  }

  void _checkForUserSession() async {
    // Get user details and onboarding status
    var userDetails = AppStorage().getUserDetails;
    bool onBoardingCompleted = AppStorage().onBoarding;

    log("_checkForUserSession() >> $userDetails, Onboarding: $onBoardingCompleted");

    // Check if onboarding is not completed
    if (!onBoardingCompleted) {
      _navigateToOnBoardingScreen(); // Redirect to onboarding page
    }
    // Check if user is logged in and the widget is mounted
    else if (userDetails != null && mounted) {
      _navigateToHomeScreen(); // Redirect to home page if user session exists
    } else {
      _callLogin(); // Redirect to login page if no session
    }
  }

  void _navigateToOnBoardingScreen() {
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => Navigator.of(context)
            .pushReplacement(goToRoute(OnboardingScreen())));
  }

  @override
  void initState() {
    super.initState();
    _checkForUserSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(color: AppColors.newBlue
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //   AppColors.lightViolet,
            //   AppColors.darkViolet,
            // ],
            // )
            ),
        child: Column(
          children: [
            SizedBox(height: appSize(context) / 6),
            const AppLogo(),
            const Spacer(),
            _image(),
          ],
        ),
      ),
    );
  }

  _image() => Image.asset(AppIcons.kIconBackground);
}
