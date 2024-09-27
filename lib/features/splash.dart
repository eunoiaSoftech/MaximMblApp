import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_images.dart';
import 'package:logistics_app/core/res/app_storage.dart';
import 'package:logistics_app/core/shared/widgets/app_logo.dart';
import 'package:logistics_app/features/home/presentation/ui/home_screen.dart';
import 'package:logistics_app/features/home/presentation/ui/main_screen.dart';
import 'package:logistics_app/features/onboarding/presentation/ui/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _callOnBoarding() async {
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => Navigator.of(context)
            .pushReplacement(goToRoute(const OnBoardingScreen())));
  }

  void _navigateToHomeScreen() async {
    Future.delayed(
        const Duration(milliseconds: 3000),
        () => Navigator.of(context)
            .pushReplacement(goToRoute(const MainScreen())));
  }

  void _checkForUserSession() async {
    var userDetails = AppStorage().getUserDetails;
    log("_checkForUserSession() >> $userDetails");
    if (userDetails != null && mounted) {
      _navigateToHomeScreen();
    } else {
      _callOnBoarding();
    }
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
