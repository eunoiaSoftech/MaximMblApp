import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class AppSnackBar {
  static show(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.newGolden,
      behavior: SnackBarBehavior.floating,
      actionOverflowThreshold: 1,
      margin: const EdgeInsets.all(8),
      showCloseIcon: true,
      content: Text(
        title,
        style: AppStyles.titleTextStyle(context)
            .copyWith(color: AppColors.textWhiteColor),
      ),
    ));
  }
}
