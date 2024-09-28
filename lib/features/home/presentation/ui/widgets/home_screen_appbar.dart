import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/constants/globals.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/shared/widgets/app_logo.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';

class HomeScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(40))),
          // surfaceTintColor: Colors.blue,
          backgroundColor: AppColors.newLightBlue,
          leading: IconButton(
              onPressed: () {
                Globals.homeScreenScaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
              color: Colors.white,
              iconSize: appSize(context) / 40),
          title: Column(
            children: [
              AppLogo(width: appSize(context) / 14)
              // const SearchBar()
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Image.asset(AppIcons.kIconLocation,
                      color: Colors.white70, width: appSize(context) / 75),
                  const SizedBox(width: 12),
                  Text("Mumbai",
                      style: TextStyle(fontSize: appSize(context) / 90)),
                ],
              ),
            ),
          ],
        ),
        // Positioned(
        //     top: appSize(context) / 11,
        //     right: appSize(context) / 60,
        //     left: appSize(context) / 20,
        //     child: AppTextField(
        //       suffix: Image.asset(AppIcons.kIconMicrophone,
        //           width: appSize(context) / 90),
        //       prefix: Image.asset(AppIcons.kIconNewSearch,
        //           width: appSize(context) / 60),
        //       hintText: "Please Search here",
        //     ))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight+20);
}
