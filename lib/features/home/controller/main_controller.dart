import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logistics_app/features/profile/presentation/ui/profile_screen.dart';
import '../presentation/ui/home_screen.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    const HomeScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  var index = 0.obs;
}
