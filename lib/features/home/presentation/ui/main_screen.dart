import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logistics_app/core/constants/globals.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/features/home/controller/main_controller.dart';
import 'package:logistics_app/features/home/presentation/ui/widgets/drawer.dart';
import '../../../../core/res/app_functions.dart';
import '../../../../core/res/app_icons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainController mainController = MainController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.homeScreenScaffoldKey,
      drawer: const AppDrawer(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Obx(() {
            return mainController.screens[mainController.index.value];
          }),
          _bottomBar(context),
        ],
      ),
    );
  }

  Widget _bottomBar(context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(55)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _bottomBarTab(context, "Home", AppIcons.kIconHomeGrey, () {
              setState(() {
                mainController.index.value = 0;
              });
            }, Colors.grey),
            const Spacer(),
            _bottomBarTab(
                context, "Notifications", AppIcons.kIconNotificationGrey, () {
              setState(() {
                mainController.index.value = 1;
              });
            }, Colors.grey),
            const Spacer(),
            _bottomBarTab(context, "Profile", AppIcons.kIconProfileGery, () {
              setState(() {
                mainController.index.value = 2;
              });
            }, Colors.grey)
          ],
        ),
      );

  _bottomBarTab(context, title, icon, onTap, iconColor) => GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: appSize(context) / 55, color: iconColor),
            Text(title,
                style: TextStyle(
                    fontSize: appSize(context) / 100, color: iconColor))
          ],
        ),
      );
}
