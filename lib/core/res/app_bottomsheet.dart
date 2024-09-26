import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class AppBottomSheet {
  static show({
    required BuildContext context,
    required Widget child,
    Color? color,
    bool? showDragHandle,
    bool? isDismissible,
    bool? enableDrag,
    String? title,
    required FutureOr Function(dynamic value) then,
  }) {
    showModalBottomSheet(
        enableDrag: enableDrag ?? true,
        isDismissible: isDismissible ?? true,
        backgroundColor: color ?? Colors.white,
        showDragHandle: showDragHandle ?? true,
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title ?? "",
                    style: AppStyles.titleTextStyle(context).copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700)),
                child,
              ],
            )).then(then);
  }
}
