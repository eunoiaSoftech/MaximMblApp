import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';

class AppBottomActionWidget extends StatelessWidget {
  AppBottomActionWidget({
    super.key,
    required this.message,
    required this.isError,
    this.isCancel = true,
    this.successLabel,
    this.onSuccess,
    this.isOkayButton = true,
  });

  final String message;
  String? successLabel;
  VoidCallback? onSuccess;
  final bool isError;
  final bool isOkayButton;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 22,right: 22,left: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(isError ? Icons.error_outline : Icons.info_outline,
                    color: isError ? Colors.redAccent : Colors.amber),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    message,
                    style: AppStyles.bottomSheetTitleTextStyle(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (isCancel)
                Expanded(
                  child: AppButton(
                      verticalPadding: 10,
                      onPressed: () => Navigator.of(context).pop(),
                      text: "Cancel"),
                ),
              if (isCancel) const SizedBox(width: 12),
              if (isOkayButton)
                Expanded(
                  child: AppButton(
                      verticalPadding: 10,
                      onPressed: () {
                        if (onSuccess != null) {
                          onSuccess!();
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      text: successLabel ?? "Okay"),
                ),
            ],
          )
        ],
      ),
    );
  }
}
