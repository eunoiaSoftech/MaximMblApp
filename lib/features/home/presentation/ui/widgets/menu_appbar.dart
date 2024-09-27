import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';

class MenuAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MenuAppbar({super.key, required this.title, this.titleWidget});

  final String title;
  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBar(
          backgroundColor: AppColors.lightViolet,
          leading: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: appSize(context) / 40,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: titleWidget != null
              ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  height: kToolbarHeight + 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(fontSize: appSize(context) / 60)),
                      Spacer(),
                    ],
                  ),
                )
              : Text(title, style: TextStyle(fontSize: appSize(context) / 60)),
          actions: [],
          toolbarHeight:
              titleWidget != null ? kToolbarHeight + 100 : kToolbarHeight,
        ),
        Positioned(
            left: 20,
            right: 20,
            top: appSize(context) / 12,
            child: titleWidget ?? const SizedBox.shrink())
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      titleWidget != null ? kToolbarHeight + 100 : kToolbarHeight);
}
