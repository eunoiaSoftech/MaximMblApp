import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_functions.dart';
import 'package:logistics_app/core/res/app_styles.dart';
import 'package:logistics_app/core/shared/widgets/app_button.dart';

class AppAlertWidget extends StatelessWidget {
  const AppAlertWidget(
      {super.key,
      required this.isError,
      this.message,
      this.showButton = false,
      this.btnOnTap,
      this.btnLabel});

  final bool isError;
  final bool showButton;
  final String? message;
  final Function()? btnOnTap;
  final String? btnLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Icon(Icons.error,
                  size: appSize(context) / 10,
                  color: isError
                      ? Colors.redAccent.withOpacity(.6)
                      : Colors.amberAccent.withOpacity(.6)),
              Text(
                message ?? "Something went wrong...",
                style: AppStyles.titleTextStyle(context).copyWith(
                  color: Colors.grey,
                  fontSize: appSize(context) / 70,
                ),
              ),
              if (showButton)
                AppButton(onPressed: btnOnTap ?? () {}, text: btnLabel ?? "")
            ],
          ),
        ),
      ],
    );
  }
}
