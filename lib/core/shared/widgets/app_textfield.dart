import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics_app/core/res/app_colors.dart';
import 'package:logistics_app/core/res/app_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.enabled,
      this.height = 40,
      this.onTap,
      this.obscureText,
      this.suffix,
      this.prefix,
      this.keyboardType,
      this.hintTextStyle,
      this.contentPadding,
      this.inputTextStyle});

  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final String? hintText;
  final double? height;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffix;
  final Widget? prefix;
  final TextStyle? hintTextStyle;
  final TextStyle? inputTextStyle;
  final Function()? onTap;

  final double circular = 44.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(circular),
          // border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              offset: const Offset(2, 2),
              spreadRadius: 1,
              blurRadius: 2,
            )
          ]),
      child: Row(
        children: [
          if (prefix != null) const SizedBox(width: 22),
          prefix ?? const SizedBox.shrink(),
          Expanded(
            child: TextFormField(
              enabled: enabled ?? true,
              obscureText: obscureText ?? false,
              onTap: onTap,
              keyboardType: keyboardType ?? TextInputType.text,
              // selectionHeightStyle:BoxHeightStyle.includeLineSpacingMiddle,
              controller: controller,
              decoration: InputDecoration(
                contentPadding:
                    contentPadding ?? const EdgeInsets.fromLTRB(22, 2, 12, 10),
                // prefix: prefix,
                // prefixIcon: prefix,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    suffix ?? const SizedBox.shrink(),
                  ],
                ),
                fillColor: Colors.transparent,
                filled: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: hintTextStyle ?? AppStyles.hintTextStyle(context),
              ),
              style: inputTextStyle ?? AppStyles.inputTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
