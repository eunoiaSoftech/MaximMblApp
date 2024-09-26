import 'package:flutter/material.dart';

import '../../../../../core/res/app_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  Color? textColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;

  CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        alignment: Alignment.center,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.titleTextStyle(context).copyWith(
            color: textColor ?? Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
