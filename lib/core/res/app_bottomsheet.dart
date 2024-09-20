import 'dart:async';

import 'package:flutter/material.dart';

class AppBottomSheet {
  static show({
    required BuildContext context,
    required Widget child,
    Color? color,
    bool? showDragHandle,
    bool? isDismissible,
    required FutureOr Function(dynamic value) then,
  }) {
    showModalBottomSheet(
        isDismissible: isDismissible ?? true,
        backgroundColor: color ?? Colors.white,
        showDragHandle: showDragHandle ?? true,
        context: context,
        builder: (context) => child).then(then);
  }
}
