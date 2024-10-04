import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class AppBottomSheet {
  static show({
    required BuildContext context,
    required Widget child,
    Color? color,
    Color? titleColor,
    bool? showDragHandle,
    bool? isDismissible,
    bool? enableDrag,
    bool isList = false,
    String? title,
    required FutureOr Function(dynamic value) then,
  }) {
    showModalBottomSheet(
        enableDrag: enableDrag ?? true,
        isDismissible: isDismissible ?? true,
        backgroundColor: color ?? Colors.white,
        showDragHandle: showDragHandle ?? true,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title ?? "",
                      style: AppStyles.titleTextStyle(context).copyWith(
                          color: titleColor ?? Colors.black,
                          fontWeight: FontWeight.w700)),
                  isList ? Expanded(child: child) : child,
                ],
              ),
        )).then(then);
  }
}
