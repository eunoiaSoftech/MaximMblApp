import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/constants/globals.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_icons.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_textfield.dart';

class CommonPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  CommonPageAppBar({super.key, required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))),
      // surfaceTintColor: Colors.blue,
      backgroundColor: AppColors.newLightBlue,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: appSize(context) / 40),
      centerTitle: false,
      title: Text(title,
          style: AppStyles.titleTextStyle(
            context,
          ).copyWith(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
