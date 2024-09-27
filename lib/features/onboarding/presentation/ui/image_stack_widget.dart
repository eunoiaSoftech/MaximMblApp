import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class ImageStackWidget extends StatelessWidget {
  const ImageStackWidget({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: appSize(context) / 5,
      // height: appSizeUnit(context: context, unit: 20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(33),
              bottomLeft: Radius.circular(33)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(image).image)),
    );
  }
}
