import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_functions.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isLoading = false,
      this.leadingWidget,
      this.height,
      this.circular,
      this.btnColor,
      this.textColor,
      this.isBorder = false,
      this.fontSize,
      this.verticalPadding});

  final Function() onPressed;
  final String text;
  final bool isLoading;
  final bool isBorder;
  final Widget? leadingWidget;
  final double? height;
  final double? circular;
  final double? verticalPadding;
  final double? fontSize;
  final Color? btnColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: MaterialButton(
                padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 16),
              // elevation: isBorder ? 0 : 4.0,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: isBorder ? AppColors.newBlue : Colors.transparent),
                  borderRadius: BorderRadius.circular(circular ?? 44)),
              color: isBorder
                  ? Colors.white
                  : btnColor ?? AppColors.newLightBlueOne,
              onPressed: onPressed,
              child: isLoading
                  ? const Center(
                      child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(strokeWidth: 2)))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        leadingWidget ?? const SizedBox.shrink(),
                        Text(text,
                            style: TextStyle(
                                fontFamily: "aileron",
                                color: textColor ?? Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: fontSize ?? appSize(context) / 60)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
