import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_images.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //       border: Border.all(color: Colors.white12),
        //       shape: BoxShape.circle),
        //   height: appSize(context) / 4.1,
        // ),
        Container(
          // color: Colors.white12,
          // padding: EdgeInsets.all(appSize(context) / 17.5),
          // decoration: const BoxDecoration(
          //   shape: BoxShape.circle,
          //   color: Colors.white12,
          // ),
          child: Image.asset(
            AppIcons.kIconLogo,
            width: appSize(context) / 4.5,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
