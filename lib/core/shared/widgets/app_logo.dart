import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_images.dart';
import 'package:svg_flutter/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.width});

  final double? width;

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
          child: SvgPicture.asset(
            AppIcons.kNewIconLogo,
            width: width ?? appSize(context) / 4.5,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
